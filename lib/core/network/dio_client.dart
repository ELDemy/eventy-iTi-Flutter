import 'package:dio/dio.dart';
import 'package:events_hub/core/constants/api_constants.dart';
import 'package:events_hub/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  DioClient() : dio = Dio(_baseOptions) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final apiKey = dotenv.env['TICKETMASTER_API_KEY'];
          if (apiKey == null || apiKey.trim().isEmpty) {
            return handler.reject(
              DioException(
                requestOptions: options,
                message: 'Missing TICKETMASTER_API_KEY in .env',
              ),
            );
          }

          options.queryParameters = {
            ...options.queryParameters,
            'apikey': apiKey,
          };
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
        ),
      );
    }
  }

  final Dio dio;

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 20),
    validateStatus: (status) => status != null && status >= 200 && status < 300,
  );

  ServerException mapDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;
    var message = error.message ?? 'Unable to load events. Please try again.';

    print(error);

    if (responseData is Map<String, Object?>) {
      final fault = responseData['fault'];
      final apiMessage = responseData['message'];
      if (fault is Map<String, Object?> && fault['faultstring'] is String) {
        message = fault['faultstring'] as String;
      } else if (apiMessage is String) {
        message = apiMessage;
      }
    }

    return ServerException(message: message, statusCode: statusCode);
  }
}

import 'package:events_hub/core/constants/app_strings.dart';
import 'package:events_hub/core/theme/AppIcons.dart';
import 'package:events_hub/core/theme/app_colors.dart';
import 'package:events_hub/core/theme/app_text_styles.dart';
import 'package:events_hub/domain/models/event.dart';
import 'package:events_hub/domain/models/mock_events.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_list.dart';
import 'package:events_hub/presentation/events/events_list/widgets/events_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchEventsScreen extends StatefulWidget {
  const SearchEventsScreen({super.key});

  @override
  State<SearchEventsScreen> createState() => _SearchEventsScreenState();
}

class _SearchEventsScreenState extends State<SearchEventsScreen> {
  EventsTab _selectedTab = EventsTab.upcoming;

  List<Event> get _events {
    return [
      ...MockEvents.upcoming,
      ...MockEvents.past,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final events = _events;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(AppStrings.search, style: AppTextStyles.signInTitle),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchRow(),
            const SizedBox(height: 24),
            EventsList(events: events)
          ],
        ),
      ),
    );
  }

  Widget _buildSearchRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 32,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.search,
                    colorFilter:
                        ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: AppColors.textOnPrimary.withValues(alpha: 0.3),
                  ),
                  textField(),
                ],
              ),
            ),
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.headerFilter,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.filter, width: 24, height: 24),
                const SizedBox(width: 4),
                Text(AppStrings.filters, style: AppTextStyles.homeFilterLabel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textField() {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: TextField(
          decoration: InputDecoration(
            hintText: AppStrings.searchHint,
            hintStyle: AppTextStyles.homeSearchHint.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}

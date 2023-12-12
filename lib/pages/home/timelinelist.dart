import 'package:flutter/material.dart';
import 'package:saas_msaa/pages/home/activitieslist.dart';
import 'package:saas_msaa/viewmodels/timelines_viewmodel.dart';

class TimeLineList extends StatefulWidget {
  const TimeLineList({super.key});

  @override
  State<TimeLineList> createState() => _TimeLineListState();
}

class _TimeLineListState extends State<TimeLineList> {
  late TimeLineListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TimeLineListViewModel();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await _viewModel.fetchTimelines();
      setState(() {}); // Trigger rebuild after data is fetched
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final timelines = _viewModel.getTimelines();
    final activities = _viewModel.getActivities();

    return ListView(
      children: timelines
          .map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(e, style: const TextStyle(color: Colors.grey)),
                  ),
                  ActivitiesList(date: e, activities: activities),
                ],
              ))
          .toList(),
    );
  }
}

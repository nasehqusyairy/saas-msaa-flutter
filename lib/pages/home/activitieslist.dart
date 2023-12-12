import 'package:flutter/material.dart';
import 'package:saas_msaa/models/activities.dart';
import 'package:saas_msaa/pages/presence/page.dart';

class ActivitiesList extends StatefulWidget {
  const ActivitiesList({
    super.key,
    required this.date,
    required this.activities,
  });

  final String date;
  final List<Activity> activities;

  @override
  State<ActivitiesList> createState() => _ActivitiesListState();
}

class _ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.activities
            .where((e) => e.date == widget.date)
            .map((e) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PresencePage(
                            activityName: e.name, activityId: e.id)));
                  },
                  child: ListTile(title: Text(e.name), subtitle: Text(e.time)),
                ))
            .toList());
  }
}

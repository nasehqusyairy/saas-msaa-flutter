import 'package:flutter/material.dart';

class Activity {
  String id;
  String name;
  String date;
  String time;

  Activity(
      {required this.id,
      required this.name,
      required this.date,
      required this.time});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
        id: json['id'].toString(),
        name: json['name'].toString(),
        date: json['date'].toString(),
        time: json['time'].toString());
  }
}

class ActivitiesProvider extends ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> getActivities() => _activities;

  void setActivities(List<Activity> activities) {
    _activities.clear();
    _activities.addAll(activities);
    notifyListeners();
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void updateActivity(Activity updatedActivity) {
    final index =
        _activities.indexWhere((activity) => activity.id == updatedActivity.id);
    if (index != -1) {
      _activities[index] = updatedActivity;
      notifyListeners();
    }
  }

  void removeActivity(String activityId) {
    _activities.removeWhere((activity) => activity.id == activityId);
    notifyListeners();
  }
}

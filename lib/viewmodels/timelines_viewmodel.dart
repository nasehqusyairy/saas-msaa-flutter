import 'package:dio/dio.dart';
import 'package:saas_msaa/models/activities.dart';

class TimeLineListViewModel {
  List<String> timelines = [];
  List<Activity> activities = [];

  Future<void> fetchTimelines() async {
    try {
      final response =
          await Dio().get('http://192.168.133.47:8000/api/activities');
      // final response = await Dio().get('http://localhost:8000/api/activities');
      timelines = List<String>.from(response.data['dates']);
      activities = List<Activity>.from(response.data['activities']
          .map((activity) => Activity.fromJson(activity)));
    } catch (e) {
      throw Exception('Failed to load timelines');
    }
  }

  List<String> getTimelines() {
    return timelines;
  }

  List<Activity> getActivities() {
    return activities;
  }
}

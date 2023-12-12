import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saas_msaa/models/presences.dart';
import 'package:saas_msaa/models/students.dart';
import 'package:saas_msaa/pages/presence/studentlist.dart'; // Import StudentList widget

class PresencePage extends StatelessWidget {
  const PresencePage(
      {Key? key, required this.activityName, required this.activityId})
      : super(key: key);

  final String activityName;
  final String activityId;

  Stream<List<Student>> fetchStudents() => FirebaseFirestore.instance
      .collection('students')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => Student.fromJson(document.data()))
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(activityName),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white),
        body: StudentsList(
            activityId: activityId,
            presenceProvider: Provider.of<PresenceProvider>(context)));
  }
}

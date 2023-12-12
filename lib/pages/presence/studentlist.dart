import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saas_msaa/models/presences.dart';
import 'package:saas_msaa/models/students.dart';
import 'package:saas_msaa/pages/presence/circularavatar.dart';
import 'package:saas_msaa/viewmodels/presences_viewmodel.dart'; // Import PresencesViewModel
import 'package:saas_msaa/viewmodels/students_viewmodel.dart'; // Import StudentsViewModel

class StudentsList extends StatelessWidget {
  final String activityId;
  final PresencesViewModel presencesViewModel = PresencesViewModel();
  final StudentsViewModel studentsViewModel = StudentsViewModel();
  final PresenceProvider presenceProvider;

  StudentsList(
      {super.key, required this.activityId, required this.presenceProvider});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        presencesViewModel.fetchPresences(),
        studentsViewModel.fetchStudents(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          presenceProvider.setPresences(presencesViewModel.getPresences());
          return ListView.builder(
            itemCount: studentsViewModel.getStudents().length,
            itemBuilder: (context, index) {
              final e = studentsViewModel.getStudents()[index];
              final presence = presencesViewModel
                  .getPresences()
                  .where(
                      (p) => p.activityId == activityId && p.studentId == e.id)
                  .firstOrNull;
              return ListTile(
                leading: studentAvatar(e),
                title: Text(e.name),
                subtitle: studentStatus(presence),
                trailing: studentOptions(e),
              );
            },
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.green));
        }
      },
    );
  }

  String studentInitialName(Student e) {
    String leadingText = '';

    if (e.img.isEmpty) {
      List<String> nameParts = e.name.split(' ');
      if (nameParts.isNotEmpty) {
        leadingText = nameParts.map((namePart) {
          return namePart.isNotEmpty ? namePart[0].toUpperCase() : '';
        }).join();
      }
    }

    return leadingText;
  }

  Widget studentAvatar(Student e) {
    return e.img.isNotEmpty
        ? CircleAvatar(backgroundImage: NetworkImage(e.img))
        : CircularAvatar(studentInitialName(e), Colors.green);
  }

  Text studentStatus(Presence? presence) {
    return Text(
      presence?.getStatus() ?? 'Belum Presensi',
      style: const TextStyle(color: Colors.grey),
    );
  }

  Future<void> submitAttendence(
      String studentId, String activityId, String status) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('presences').add({
      'studentId': studentId,
      'activityId': activityId,
      'status': status,
    });

    // Create a new Presence object with the new data
    Presence newPresence = Presence(
      id: docRef.id,
      studentId: studentId,
      activityId: activityId,
      status: status,
    );

    // Add the new presence to the provider
    presenceProvider.addPresence(newPresence);
  }

  Future<void> updateAttendence(String studentId, String activityId,
      String status, String presenceId) async {
    await FirebaseFirestore.instance
        .collection('presences')
        .doc(presenceId)
        .update({
      'studentId': studentId,
      'activityId': activityId,
      'status': status,
    });
    // Create a new Presence object with updated data
    Presence updatedPresence = Presence(
      id: presenceId,
      studentId: studentId,
      activityId: activityId,
      status: status,
    );

    // Update the presence in the provider
    presenceProvider.updatePresence(updatedPresence);
  }

  Future<void> studentOptionOnTap(
      String studentId, String activityId, String status) async {
    final presence = presenceProvider
        .getPresences()
        .where((presence) =>
            presence.studentId == studentId &&
            presence.activityId == activityId)
        .firstOrNull;
    if (presence == null) {
      return await submitAttendence(studentId, activityId, status);
    } else {
      return await updateAttendence(studentId, activityId, status, presence.id);
    }
  }

  PopupMenuButton<dynamic> studentOptions(Student student) {
    final String studentId = student.id;
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            onTap: () async =>
                await studentOptionOnTap(studentId, activityId, 'H'),
            child: const Text("Hadir")),
        PopupMenuItem(
            onTap: () async =>
                await studentOptionOnTap(studentId, activityId, 'I'),
            child: const Text("Izin")),
        PopupMenuItem(
            onTap: () async =>
                await studentOptionOnTap(studentId, activityId, 'S'),
            child: const Text("Sakit")),
        PopupMenuItem(
            onTap: () async =>
                await studentOptionOnTap(studentId, activityId, 'A'),
            child: const Text("Absen")),
        PopupMenuItem(
            onTap: () async => await deleteAttendence(studentId),
            child: const Text("Belum Presensi")),
      ],
    );
  }

  Future<void> deleteAttendence(String studentId) async {
    final presence = presenceProvider
        .getPresences()
        .where((presence) => presence.studentId == studentId)
        .firstOrNull;
    if (presence != null) {
      await FirebaseFirestore.instance
          .collection('presences')
          .doc(presence.id)
          .delete();
      presenceProvider.removePresence(presence.id);
    }
  }
}

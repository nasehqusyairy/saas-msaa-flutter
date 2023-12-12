import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Presence {
  String id;
  String activityId;
  String studentId;
  String status;

  Presence(
      {required this.activityId,
      required this.studentId,
      required this.status,
      required this.id});

  factory Presence.fromJson(Map<String, dynamic> json) {
    return Presence(
        id: json['id'].toString(),
        activityId: json['activity_id'].toString(),
        studentId: json['student_id'].toString(),
        status: json['status'].toString());
  }

  factory Presence.fromSnapshot(DocumentSnapshot snapshot) {
    return Presence(
      id: snapshot.id,
      activityId: snapshot['activityId'],
      studentId: snapshot['studentId'],
      status: snapshot['status'],
    );
  }

  String getStatus() {
    switch (status) {
      case 'H':
        return 'Hadir';
      case 'I':
        return 'Izin';
      case 'S':
        return 'Sakit';
      default:
        return 'Absen';
    }
  }
}

class PresenceProvider extends ChangeNotifier {
  final List<Presence> _presences = [];

  List<Presence> getPresences() => _presences;

  void setPresences(List<Presence> presences) {
    _presences.clear();
    _presences.addAll(presences);
    // Future.microtask(() => notifyListeners());
  }

  void addPresence(Presence presence) {
    _presences.add(presence);
    notifyListeners();
  }

  void updatePresence(Presence updatedPresence) {
    final index =
        _presences.indexWhere((presence) => presence.id == updatedPresence.id);
    if (index != -1) {
      _presences[index] = updatedPresence;
      notifyListeners();
    }
  }

  void removePresence(String presenceId) {
    _presences.removeWhere((presence) => presence.id == presenceId);
    notifyListeners();
  }
}

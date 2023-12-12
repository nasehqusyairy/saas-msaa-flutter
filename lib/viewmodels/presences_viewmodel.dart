import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saas_msaa/models/presences.dart'; // Assuming you have a Presence model

class PresencesViewModel {
  List<Presence> presences = []; // Assuming Presence is a model class

  Future<void> fetchPresences() async {
    try {
      final QuerySnapshot result =
          await FirebaseFirestore.instance.collection('presences').get();
      final List<DocumentSnapshot> documents = result.docs;
      presences =
          documents.map((document) => Presence.fromSnapshot(document)).toList();
    } catch (e) {
      throw Exception('Failed to load presences');
    }
  }

  List<Presence> getPresences() {
    return presences;
  }
}

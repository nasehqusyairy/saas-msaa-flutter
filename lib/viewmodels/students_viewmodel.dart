import 'package:dio/dio.dart';
import 'package:saas_msaa/models/students.dart';

class StudentsViewModel {
  List<Student> students = [];

  Future<void> fetchStudents() async {
    try {
      final response =
          await Dio().get('http://192.168.133.47:8000/api/students');
      // final response = await Dio().get('http://localhost:8000/api/students');
      students = List<Student>.from(response.data['students']
          .map((student) => Student.fromJson(student)));
    } catch (e) {
      throw Exception('Failed to load students');
    }
  }

  List<Student> getStudents() {
    return students;
  }
}

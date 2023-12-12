class Student {
  final String id;
  final String name;
  final String img;
  final String nim;

  Student({
    required this.id,
    required this.name,
    required this.img,
    required this.nim,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'].toString(),
        name: json['name'].toString(),
        img: json['img'].toString(),
        nim: json['nim'].toString());
  }
}

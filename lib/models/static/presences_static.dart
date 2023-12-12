class Presence {
  int activityId;
  String nim;
  String status;

  Presence({required this.activityId, required this.nim, required this.status});
}

final presences = [
  Presence(activityId: 1, nim: '210605110066', status: 'Hadir'),
  Presence(activityId: 1, nim: '210605110067', status: 'Izin'),
  Presence(activityId: 1, nim: '210605110068', status: 'Absen')
];

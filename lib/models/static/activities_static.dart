class Activity {
  int id;
  String name;
  String date;
  String time;

  Activity(
      {required this.id,
      required this.name,
      required this.date,
      required this.time});
}

final activities = [
  Activity(id: 1, name: 'Jamaah Subuh', date: '06/10/2023', time: '04.00'),
  Activity(id: 2, name: 'Jamaah Maghrib', date: '06/10/2023', time: '18.00'),
  Activity(id: 3, name: 'Jamaah Isya', date: '06/10/2023', time: '19.00'),
  Activity(id: 4, name: 'Taklim Quran', date: '06/10/2023', time: '19.30'),
  Activity(id: 5, name: 'Jamaah Subuh', date: '05/10/2023', time: '04.00'),
  Activity(id: 6, name: 'Jamaah Maghrib', date: '05/10/2023', time: '18.00'),
  Activity(id: 7, name: 'Jamaah Isya', date: '05/10/2023', time: '19.00'),
  Activity(id: 8, name: 'Taklim Afkar', date: '05/10/2023', time: '19.30'),
  Activity(id: 9, name: 'Jamaah Subuh', date: '04/10/2023', time: '04.00'),
  Activity(id: 10, name: 'Jamaah Maghrib', date: '04/10/2023', time: '18.00'),
  Activity(id: 11, name: 'Jamaah Isya', date: '04/10/2023', time: '19.00'),
  Activity(id: 12, name: 'Taklim Quran', date: '04/10/2023', time: '19.30'),
];
final timelines = [
  "06/10/2023",
  "05/10/2023",
  "04/10/2023",
];

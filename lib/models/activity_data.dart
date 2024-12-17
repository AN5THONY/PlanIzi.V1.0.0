class ActivityData {
  String? id;
  String title;
  String subtitle;
  String place;
  String time;
  String details;
  bool isCompleted;

  ActivityData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.place,
    required this.time,
    required this.details,
    this.isCompleted = false,
  });

  static List<ActivityData> activityList() {
    return [
      ActivityData(
        id: '1',
        title: 'Reunión de trabajo',
        subtitle: 'Preparar reporte mensual',
        time: '10:00 AM',
        place: 'Oficina',
        details: 'Virtual',
        isCompleted: false,
      ),
      ActivityData(
        id: '2',
        title: 'Gimnasio',
        subtitle: 'Brazos y Pecho',
        time: '6:00 PM',
        details: 'Smart Fit',
        place: 'Mall de comas',
        isCompleted: false,
      ),
      ActivityData(
        id: '3',
        title: 'Leer un libro',
        subtitle: 'Terminar el capítulo 5',
        time: '8:00 PM',
        details: '',
        place: '',
        isCompleted: true,
      ),
    ];
  }
}

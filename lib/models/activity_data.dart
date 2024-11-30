class ActivityData {
  String? id;
  String title;
  String subtitle;
  String time;
  String details;
  bool isCompleted;

  ActivityData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.details,
    this.isCompleted = false,
  });

  static List<ActivityData> activityList() {
    return [
      ActivityData(
        id: '1',
        title: 'Reunión de trabajo',
        subtitle: 'Llamada con el equipo',
        time: '10:00 AM',
        details: 'Preparar reporte mensual',
        isCompleted: false,
      ),
      ActivityData(
        id: '2',
        title: 'Gimnasio',
        subtitle: 'Entrenamiento personal',
        time: '6:00 PM',
        details: 'Cardio y pesas',
        isCompleted: false,
      ),
      ActivityData(
        id: '3',
        title: 'Leer un libro',
        subtitle: 'Ficción y desarrollo personal',
        time: '8:00 PM',
        details: 'Terminar el capítulo 5',
        isCompleted: true,
      ),
    ];
  }
}

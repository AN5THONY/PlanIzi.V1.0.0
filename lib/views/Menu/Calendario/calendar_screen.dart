import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/ActivityViews/activity_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime today = DateTime.now(); // fecha seleccionada
  List<ActivityData> activityList = [];
  bool isLoading = false;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _fetchActivitiesForSelectedDate();
    });
  }

  // activ por fechas seleccionada
  Future<void> _fetchActivitiesForSelectedDate() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('actividades')
          .where('tipo', isEqualTo: 'especial')
          .get();

      final selectedDate =
          DateTime(today.year, today.month, today.day); // fecha sin hora

      List<ActivityData> filteredActivities = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final fecha = data['fecha'];
        // Fecha almacenada en Firestore

        if (fecha is Timestamp) {
          final fechaDate = fecha.toDate();
          final fechaSinHora =
              DateTime(fechaDate.year, fechaDate.month, fechaDate.day);
          if (fechaSinHora.isAtSameMomentAs(selectedDate)) {
            filteredActivities.add(ActivityData(
              id: doc.id,
              title: data['nombreActividad'] ?? 'Sin título',
              subtitle: data['comentario'] ?? '',
              time: data['horaInicio'] ?? 'Sin hora',
              place: data['ubicacionA'] ?? 'Sin ubicación',
              details: data['comentario'] ?? '',
              isCompleted: data['isCompleted'] ?? false,
            ));
          }
        }
      }
      setState(() {
        activityList = filteredActivities;
      });
    } catch (e) {
      //
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchActivitiesForSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 100),
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                child: const Text(
                  'Agenda',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Calendario
              Container(
                decoration:
                    const BoxDecoration(color: AppColors.cardBackground),
                child: TableCalendar(
                  locale: "en_US",
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2030, 3, 14),
                  onDaySelected: _onDaySelected,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 80),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  'Tus actividades',
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Actividades del día seleccionado
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : activityList.isEmpty
                        ? const Center(
                            child: Text("No tienes actividades para este día."),
                          )
                        : ListView(
                            children: [
                              for (ActivityData activity in activityList)
                                ActivityView(
                                  activity: activity,
                                  onDelete: () {
                                    _deleteActivity(activity.id!);
                                  },
                                )
                            ],
                          ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _deleteActivity(String id) {
    setState(() {
      activityList.removeWhere((activity) => activity.id == id);
    });
  }
}

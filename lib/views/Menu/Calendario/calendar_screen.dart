import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/ActivityViews/activity_view.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarScreen extends StatefulWidget {

   const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  DateTime today = DateTime.now();

  final List<ActivityData> activityList = ActivityData.activityList();

  void _onDaySelected(DateTime day,DateTime focusedDay) {
    setState(() {
      today = day;
    });
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
                decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 100),
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: const Text('Agenda', style: TextStyle(
                              fontSize: 30,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,)),
              ),
              //CALENDARIO
              Container(
                decoration: const BoxDecoration( color: AppColors.cardBackground),
                child: TableCalendar(
                  locale: "en_US",
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  onDaySelected: _onDaySelected,
                ),
              ),
              
              Container(
                decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 80),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: const Text('Tus actividades', style: TextStyle(
                              fontSize: 30,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,)),
              ),
                //ACTIVIDADES DEL DÍA SELECIONADO 
              Expanded(child: ListView(
                children: [
                  for (ActivityData activity in activityList)
                          ActivityView(
                            activity: activity,
                            onPostpone: () => _postponeActivity(activity.id!),
                            onComplete: () => _completeActivity(activity.id!),
                            onDelete: () => _deleteActivity(activity.id!),
                          ),
                  ],
                )
              ),
            ],
          ),
        ),
      ],
    ); 
  }


  
  void _postponeActivity(String id) {
    setState(() {
      final activity = activityList.firstWhere((element) => element.id == id);
      activity.time = "Pospuesta a más tarde";
    });
  }

  void _completeActivity(String id) {
    setState(() {
      final activity = activityList.firstWhere((element) => element.id == id);
      activity.isCompleted = true;
    });
  }

  void _deleteActivity(String id) {
    setState(() {
      activityList.removeWhere((activity) => activity.id == id);
    });
  }
}
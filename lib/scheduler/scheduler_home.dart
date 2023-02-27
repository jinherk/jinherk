import 'package:everynue/scheduler/schedul_bottom_sheet.dart';
import 'package:everynue/scheduler/schedule_card.dart';
import 'package:everynue/scheduler/today_banner.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../const/colors.dart';
import '../drift/drift_database.dart';
import 'calender.dart';

class SchedulerHome extends StatefulWidget {
  const SchedulerHome({Key? key}) : super(key: key);

  @override
  State<SchedulerHome> createState() => _SchedulerHomeState();
}

class _SchedulerHomeState extends State<SchedulerHome> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(context),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(selectedDay: selectedDay),
            SizedBox(height: 8.0),
            _ScheduleList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton(context) {
    return FloatingActionButton(
        backgroundColor: schedulerBlue,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return ScheduleBottomSheet(
                  selectedDate: selectedDay,
                );
              });
        },
        child: Icon(Icons.create));
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay; //selectedDay에 선택한 날짜를 넣어줌
      this.focusedDay = selectedDay; //focusedDay를 selectedDay로 만듬
    });
  }
}

class _ScheduleList extends StatelessWidget {
  DateTime selectedDate;

  _ScheduleList({required this.selectedDate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Schedule>>(
        stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
        builder: (context, snapshot) {
          ///스트림이 아직 도착 못한 경우
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          ///스트림이 도착했는데 데이터가 비어있는 경우
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return (Center(child: Text("스케쥴이 없습니다.")));
          }

          ///데이터가 있는 경우
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final schedule = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Dismissible(
                  key: ObjectKey(schedule.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (DismissDirection direction) {
                    GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return ScheduleBottomSheet(
                                selectedDate: selectedDate,
                                scheduleId: schedule.id);
                          });
                    },
                    child: ScheduleCard(
                      content: schedule.content,
                      startTime: schedule.startTime,
                      endTime: schedule.endTime,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

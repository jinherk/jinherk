import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../const/colors.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay; //선택된 날짜
  final DateTime focusedDay; //보여줄 날짜
  final OnDaySelected? onDaySelected; //날짜를 선택했을 때 실행할 함수
  Calendar({required this.selectedDay, required this.focusedDay, required this.onDaySelected, Key? key})
      : super(key: key);

  final defaultBoxDeco = BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(6.0),
  );

  final defaultTextStyle = TextStyle(
    color: Colors.grey[600],
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: "ko_KR",
      focusedDay: focusedDay,
      //선택된 날짜랑 다름 보여줘야할 날짜
      firstDay: DateTime(1800),
      //선택할 수 있는 가장 과거의 날짜
      lastDay: DateTime(3000),
      //선택할 수 있는 가장 미래의 날짜
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
      ),
      calendarStyle: CalendarStyle(
        //처음 앱을 켰을 때, focusedDay로 오늘 날짜를 보여주지만 색칠은 안할거임
        isTodayHighlighted: false,
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        //평일 데코레이션
        defaultDecoration: defaultBoxDeco,
        //평일 텍스트 스타일
        defaultTextStyle: defaultTextStyle,
        //주말 데코레이션
        weekendDecoration: defaultBoxDeco,
        //주말 텍스트 스타일
        weekendTextStyle: defaultTextStyle,
        //선택 일 데코레이션
        selectedDecoration: defaultBoxDeco.copyWith(
          color: Colors.white,
          border: Border.all(color: schedulerBlue),
        ),
        //선택 일 텍스트 스타일
        selectedTextStyle: defaultTextStyle.copyWith(color: schedulerBlue),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }
        //지금 선택된 날짜와 onDayselected에서 selectedDay에 넣어준 날짜가 같으면 색을 바꿈
        //일종의 더블 체크
        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}
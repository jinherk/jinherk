import 'package:flutter/material.dart';

import '../const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  ScheduleCard(
      {required this.content,
        required this.endTime,
        required this.startTime,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: schedulerBlue, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(startTime: startTime, endTime: endTime),
              SizedBox(
                width: 16,
              ),
              Expanded(child: _Content(content: content)),
              SizedBox(
                width: 16,
              ),
            ]),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  _Time({required this.startTime, required this.endTime, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: schedulerBlue,
      fontSize: 16.0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${startTime.toString().padLeft(2, "0")}:00",
          style: textStyle,
        ),
        Text(
          "${endTime.toString().padLeft(2, "0")}:00",
          style: textStyle,
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("${content}");
  }
}
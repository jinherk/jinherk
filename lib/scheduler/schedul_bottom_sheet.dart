import 'package:drift/drift.dart' hide Column;
import 'package:everynue/scheduler/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../const/colors.dart';
import '../drift/drift_database.dart';


class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? scheduleId;

  const ScheduleBottomSheet(
      {required this.selectedDate, this.scheduleId, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formkey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Schedule>(
          future: widget.scheduleId != null
              ? GetIt.I<LocalDatabase>().getSchedules(widget.scheduleId!)
              : null,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("스케쥴을 불러올 수 없습니다."),
              );
            }
            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && startTime == null) {
              startTime = snapshot.data!.startTime;
              endTime = snapshot.data!.endTime;
              content = snapshot.data!.content;
            }
            return SafeArea(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height - 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Form(
                    key: formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        _Time(
                          startinitialvalue: startTime?.toString() ?? "",
                          endinitialvalue: endTime?.toString() ?? "",
                          onStartSaved: (String? val) {
                            startTime = int.parse(val!);
                          },
                          onEndSaved: (String? val) {
                            endTime = int.parse(val!);
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        _Content(
                          initialvalue: content ?? "",
                          onSaved: (String? val) {
                            content = val;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        _SaveButton(
                          onPressed: onSavePressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void onSavePressed() async {
    //formkey가 없는 경우(일어날 일 없음)
    if (formkey.currentState == null) {
      return;
    }
    //validate에서 null이 리턴되어서 formkey.currentState!.validate()에 true가 들어왔을 때
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save(); //onsaved 함수를 작동 시킴

      if (widget.scheduleId == null) {
        await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
          ),
        );
        Navigator.of(context).pop();
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleById(
          widget.scheduleId!,
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
          ),
        );
        Navigator.of(context).pop();
      }
    } else {
      //validate에서 null말고 다른 값이 리턴되어서 formkey.currentState!.validate()에 false가 들어왔을 때
      print("에러발생");
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startinitialvalue;
  final String endinitialvalue;

  const _Time(
      {required this.onStartSaved,
        required this.onEndSaved,
        required this.startinitialvalue,
        required this.endinitialvalue,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: "시작 시간",
            isTime: true,
            onSaved: onStartSaved,
            initialvalue: startinitialvalue,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: CustomTextField(
            initialvalue: endinitialvalue,
            onSaved: onEndSaved,
            label: "마감 시간",
            isTime: true,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String initialvalue;
  final FormFieldSetter<String> onSaved;

  const _Content({required this.onSaved, Key? key, required this.initialvalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        initialvalue: initialvalue,
        label: "내용",
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  _SaveButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: schedulerBlue),
              onPressed: onPressed,
              child: Text("저장"),
            )),
      ],
    );
  }
}

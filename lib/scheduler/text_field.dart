import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final String initialvalue;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({required this.label, required this.isTime,required this.onSaved, required this.initialvalue, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: schedulerBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,
      validator: (String? val){
        if(val == null || val.isEmpty){
          return "아무것도 입력하지 않았어요!";
        }
        if(isTime){
          int time = int.parse(val);
          if(time<0){
            return "0 이상의 숫자를 입력해주세요.";
          }
          if(time >24){
            return "24 이하의 숫자를 입력해주세요.";
          }
        }
        return null;
      },
      expands: isTime ? false : true,
      maxLines: isTime ? 1 : null,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      cursorColor: Colors.grey,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      initialValue: initialvalue,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey[300],
        filled: true,
        hintText: isTime? "00:00": "동아리 연습시간",
        suffixText: isTime? "시": null,
      ),
    );
  }
}

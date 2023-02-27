import 'package:everynue/const/colors.dart';
import 'package:flutter/material.dart';

import '../../e_clean/for_clean_code.dart';

class NewPosting extends StatefulWidget {
  const NewPosting({Key? key}) : super(key: key);

  @override
  State<NewPosting> createState() => _NewPostingState();
}

class _NewPostingState extends State<NewPosting> {
  final postController = TextEditingController();
  var postText = "";
  ForNewPosting? forNew;

  @override
  void didChangeDependencies() {
    forNew = ForNewPosting(context: context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: forNew!.width,
      height: forNew!.height,
      padding: forNew!.padding,
      margin: forNew!.margin,
      decoration: forNew!.boxDecoration,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: textField(),
            ),
          ),
          notion(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  color: red,
                  onPressed:
                  postText.trim().length < 7 ? null : () => forNew!.uploadPosting(postText),
                  icon: Icon(Icons.send)),
            ],
          ),
        ],
      ),
    );
  }

  Widget textField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      maxLength: 2000,
      controller: postController,
      decoration: InputDecoration(
        labelText: "7자 이상 입력",
        labelStyle: forNew!.textStyle,
        border: InputBorder.none,
      ),
      onChanged: (value) {
        setState(() {
          postText = value;
        });
      },
    );
  }

  Widget notion() {
    return Container(
      width: double.infinity,
      height: 120,
      child: Text(
        'EVERYNUE는 타인의 권리를 침해하거나, 반 사회적인 사상이 담긴 글은 존중하지 않습니다. EVERYNUE는 그 어떤 경우에도 여러분들의 익명성과 개인정보를 최우선으로 보호할 것입니다. 하지만, 이를 악용하여 발생하는 문제에 대한 책임은 본인에게 있습니다.',
        style: TextStyle(color: Colors.grey),
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

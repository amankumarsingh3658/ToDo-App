import 'package:flutter/material.dart';
import 'package:todoapp/Utilities/mybutton.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  GlobalKey<FormState> inputKey;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      required this.inputKey
      });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: height * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              key: inputKey,
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Add a new task',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),

            //buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                Visibility(
                  maintainState: true,
                  child: Mybutton(text: 'Save', onPress: onSave)),
                SizedBox(width: 8),
                //cancel button
                Mybutton(text: 'Cancel', onPress: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}

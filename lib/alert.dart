import 'package:flutter/material.dart';
class Dialogs extends StatelessWidget {
  final controller;
  final VoidCallback Onsave;
  final VoidCallback Oncancel;
  Dialogs({super.key,required this.controller,required this.Onsave,required this.Oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)
        ),
        
        child: Column(children: [
          
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "Enter the task",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(onPressed: (){Onsave();},
              minWidth: 50,
              color: Theme.of(context).primaryColor,
              child: Text("Save"),
              ),
              MaterialButton(onPressed: (){Oncancel();},
              minWidth: 50,
              child: Text("Cancel"),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
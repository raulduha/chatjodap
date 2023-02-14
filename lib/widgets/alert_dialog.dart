import 'package:division/division.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel }

class AlertDialogsInteractive {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
    String cancelMsg,
    String confirmMsg,
    Color? confirmMsgColor,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(rgb(28, 27, 27)),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pop(DialogsAction.cancel),
                    child: Text(
                      cancelMsg,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(rgb(28, 27, 27)),
                    ),
                    onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                    child: Text(
                      confirmMsg,
                      style: TextStyle(
                          color: confirmMsgColor, fontWeight: FontWeight.w500),
                    ),
                  )

                ],
              )
            ],
          );
        },);
        return (action != null) ? action : DialogsAction.cancel;
  }
}
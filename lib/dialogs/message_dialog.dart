import 'package:flutter/material.dart';
import 'package:tasker/dialogs/components/dialog_body.dart';
import 'package:tasker/dialogs/components/dialog_heading.dart';
import 'package:tasker/dialogs/components/horizontal_pair_btn.dart';

class MessageDialog {
  final BuildContext context;
  final String title;
  final String message;

  MessageDialog(
    this.context, {
    required this.title,
    required this.message,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0),
              DialogHeading(title),
              SizedBox(height: 8.0),
              DialogBody(message),
              SizedBox(height: 8.0),
              HorizontalPairBtn(
                onlyCancelBtn: true,
                cancelBtnTitle: "Close",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HorizontalPairBtn extends StatelessWidget {
  final String cancelBtnTitle;
  final String confirmBtnTitle;
  final void Function()? onConfirmBtnPress;
  final bool onlyCancelBtn;
  const HorizontalPairBtn({
    this.cancelBtnTitle = "Cancel",
    this.confirmBtnTitle = "",
    this.onConfirmBtnPress,
    this.onlyCancelBtn = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white60
                  : Colors.black54,
            ),
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white10
                  : Colors.black12,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            this.cancelBtnTitle.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              letterSpacing: 0.8,
            ),
          ),
        ),
        this.onlyCancelBtn
            ? SizedBox()
            : TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  overlayColor: MaterialStateProperty.all(
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white10
                        : Colors.black12,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                ),
                onPressed: this.onConfirmBtnPress,
                child: Text(
                  this.confirmBtnTitle.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
      ],
    );
  }
}

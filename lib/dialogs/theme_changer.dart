import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:tasker/dialogs/components/dialog_heading.dart';
import 'package:tasker/dialogs/components/horizontal_pair_btn.dart';

class ThemeChange {
  final BuildContext context;
  AdaptiveThemeMode themeMode;

  ThemeChange(
    this.context,
    this.themeMode,
  ) {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: DialogHeading("Choose theme"),
            ),
            RadioListTile(
              activeColor: Colors.blue,
              title: Text("Light"),
              groupValue: this.themeMode,
              value: AdaptiveThemeMode.light,
              onChanged: (dynamic value) {
                this.themeMode = AdaptiveThemeMode.light;
                AdaptiveTheme.of(context).setLight();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              activeColor: Colors.blue,
              title: Text("Dark"),
              groupValue: this.themeMode,
              value: AdaptiveThemeMode.dark,
              onChanged: (dynamic value) {
                this.themeMode = AdaptiveThemeMode.dark;
                AdaptiveTheme.of(context).setDark();
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              activeColor: Colors.blue,
              title: Text("Follow System"),
              groupValue: this.themeMode,
              value: AdaptiveThemeMode.system,
              onChanged: (dynamic value) {
                this.themeMode = AdaptiveThemeMode.system;
                AdaptiveTheme.of(context).setSystem();
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: HorizontalPairBtn(
                onlyCancelBtn: true,
                cancelBtnTitle: "Close",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ride_with_passion/styles.dart';
import 'package:intl/intl.dart';

class DateFieldWidget extends StatelessWidget {
  final String text;
  final String label;
  final IconData iconData;
  final TextStyle labelStyle;

  final Function(DateTime) onChanged;
  final DateTime date;

  DateFieldWidget(
      {Key key,
      this.text,
      this.iconData,
      this.label,
      this.onChanged,
      this.date,
      this.labelStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: InkWell(
          onTap: () {
            closeKeyboard(context);
            showDatePicker(context);
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xFFE7ECFD),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(date == null ? text : formatDateMMMd(date),
                          style: date == null ? labelStyle : medium20spRed),
                      Icon(
                        iconData,
                        color: accentColor,
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

  showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      currentTime: date ?? DateTime(1990, 1, 1),
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime(2000, 12, 31),
      locale: LocaleType.de,
      theme: DatePickerTheme(
          doneStyle: medium20sp.copyWith(color: blackHeadingColor)),
      showTitleActions: true,
      onConfirm: onChanged,
    );
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String formatDateMMMd(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }
}

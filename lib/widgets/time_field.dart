import 'package:flutter/material.dart';

class TimeField extends StatefulWidget {
  TimeField({
    Key? key,
    this.controller,
    this.labelText,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? labelText;
  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay _time = TimeOfDay.now();
    void selectTime(TextEditingController date) async {
      TimeOfDay? newTime = await showTimePicker(
        hourLabelText: "a",
        context: context,
        initialTime: _time,
      );
      FocusScope.of(context).requestFocus(FocusNode());
      if (newTime != null) {
        setState(() {
          _time = newTime;
          date.value = TextEditingValue(text: newTime.format(context));
        });
      }
    }

    return TextFormField(
      decoration: InputDecoration(labelText: widget.labelText),
      controller: widget.controller,
      onTap: () => selectTime(widget.controller!),
      onChanged: (parse) => widget.controller!.text,
    );
  }
}

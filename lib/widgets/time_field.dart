import 'package:flutter/material.dart';

class TimeField extends StatefulWidget {
  TimeField({
    Key? key,
    this.labelText,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String? labelText;
  final TextEditingController? controller;
  final String Function(String?)? validator;
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.deepPurple));
  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay _time = TimeOfDay.now();
    void selectTime(TextEditingController date) async {
      TimeOfDay? newTime = await showTimePicker(
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
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(color: Colors.deepPurple),
            enabledBorder:
                widget.controller!.text.isNotEmpty ? widget._border : null,
            border: widget._border),
        controller: widget.controller,
        onTap: () => selectTime(widget.controller!),
        onChanged: (time) => widget.controller!.text,
        validator: widget.validator);
  }
}

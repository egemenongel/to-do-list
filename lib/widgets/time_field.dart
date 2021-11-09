import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class TimeField extends StatefulWidget {
  TimeField({
    Key? key,
    this.labelText,
    this.controller,
    this.validator,
    this.enabled,
    this.clearButton,
  }) : super(key: key);
  final String? labelText;
  final TextEditingController? controller;
  final String Function(String?)? validator;
  final void Function()? clearButton;
  final enabled;
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
      if (date.value.text.isNotEmpty) {
        Provider.of<TaskListManager>(context, listen: false).changeBool(false);
      }
    }

    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 24, 0, 16),
          suffixIcon: IconButton(
            onPressed: widget.clearButton,
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.clear,
              color: Colors.deepPurple,
            ),
            iconSize: 15,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Colors.deepPurple,
          ),
          enabledBorder:
              widget.controller!.text.isNotEmpty ? widget._border : null,
          border: widget._border),
      controller: widget.controller,
      onTap: () => selectTime(widget.controller!),
      validator: widget.validator,
      enabled: widget.enabled,
    );
  }
}

import 'package:flutter/material.dart';

class DateField extends StatefulWidget {
  DateField({
    Key? key,
    this.labelText,
    this.controller,
    this.clearButton,
  }) : super(key: key);
  final String? labelText;
  final TextEditingController? controller;
  final void Function()? clearButton;
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.deepPurple));
  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    DateTime _day = DateTime.now();
    void selectTime(TextEditingController date) async {
      DateTime? newDay = await showDatePicker(
          context: context,
          initialDate: _day,
          firstDate: DateTime(2000, 1, 1),
          lastDate: DateTime(2050, 1, 1));
      FocusScope.of(context).requestFocus(FocusNode());
      if (newDay != null) {
        setState(() {
          _day = newDay;
          date.value = TextEditingValue(text: newDay.toString().split(" ")[0]);
        });
      }
    }

    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 24, 0, 16),
          suffixIcon: IconButton(
            onPressed: () {},
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
    );
  }
}

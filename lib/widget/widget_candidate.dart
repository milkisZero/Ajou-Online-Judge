import 'package:flutter/material.dart';

class CandWidget extends StatefulWidget {
  VoidCallback tap;
  String text;
  int index;
  double width;
  bool selected_state;

  CandWidget(
      {required this.tap,
      required this.index,
      required this.width,
      required this.text,
      required this.selected_state});
  _CandWidgetState createState() => _CandWidgetState();
}

class _CandWidgetState extends State<CandWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.width * 0.024),
      child: Container(
        padding: EdgeInsets.all(widget.width * 0.024),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2),
          color: widget.selected_state ? Colors.purple.shade300 : Colors.white,
        ),
        child: InkWell(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
              color: widget.selected_state ? Colors.white : Colors.black,
            ),
          ),
          onTap: () {
            setState(() {
              widget.tap();
              widget.selected_state = !widget.selected_state;
            });
          },
        ),
      ),
    );
  }
}

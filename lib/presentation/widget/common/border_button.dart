import 'package:flutter/material.dart';
import 'package:mft_customer_side/common/style/dimens.dart';

class BorderButton extends StatefulWidget {
  const BorderButton(
      {@required this.title,
      @required this.color,
      this.width,
      @required this.function});

  final String title;
  final Color color;
  final double width;
  final Function function;

  @override
  _BorderButtonState createState() => _BorderButtonState();
}

class _BorderButtonState extends State<BorderButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size70),
          child: ElevatedButton(
            onPressed: widget.function, //Event goes here
            style: ElevatedButton.styleFrom(
              primary: widget.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.size5),
                side: BorderSide(color: widget.color),
              ),
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: Dimens.size25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

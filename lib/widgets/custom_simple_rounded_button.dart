import 'package:flutter/material.dart';

class CustomSimpleRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomSimpleRoundedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(text),
      ),
    );
  }
}

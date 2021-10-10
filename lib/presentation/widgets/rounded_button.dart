import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RoundedButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          splashColor: Colors.white.withAlpha(60),
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: const Text(
            'Delete All',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

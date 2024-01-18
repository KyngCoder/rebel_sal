import 'package:fireworks_demo/curtin_anim.dart';
import 'package:flutter/material.dart';

void navigateToAnimationScreen(BuildContext context, String userName) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          MyImageAnimation(
        userName: userName,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.linear;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ),
  );
}

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  Input({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          cursorColor: Colors.blue,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            alignLabelWithHint: true,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  Button({required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        maximumSize: Size(500, 150),
        minimumSize: Size(350, 50),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

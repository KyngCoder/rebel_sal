import 'package:fireworks_demo/abstract.dart';
import 'package:fireworks_demo/curtin_anim.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    String enteredName = _nameController.text;
 navigateToAnimationScreen(context, enteredName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 49, 49),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Input(
              controller: _nameController,
              hintText: 'name',
            ),
            Button(
              onPressed: _handleButtonPress,
              buttonText: 'launch Rebel Salute',
            ),

     ],
        ),
      ),
    );
  }
}

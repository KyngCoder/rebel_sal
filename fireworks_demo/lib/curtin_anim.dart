import 'package:fireworks/fireworks.dart';
import 'package:fireworks_demo/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fireworks/fireworks.dart';
import 'package:google_fonts/google_fonts.dart';

class MyImageAnimation extends StatefulWidget {
  MyImageAnimation({key, required this.userName});
  final String userName;
  @override
  _MyImageAnimationState createState() => _MyImageAnimationState();
}

class _MyImageAnimationState extends State<MyImageAnimation> {
  bool _isCurtainOpen = false;

  bool _displayFireworks = false;
  bool _displayQuiz = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isCurtainOpen = !_isCurtainOpen;
      });
      if (_isCurtainOpen) {
        Future.delayed(Duration(seconds: 2), () {
          // Ensure the widget is still mounted before updating the state
          if (mounted) {
            setState(() {
              // Set the variable to trigger the display of fireworks
              _displayFireworks = true;
            });
          }
        });
        Future.delayed(Duration(seconds: 8), () {
          // Ensure the widget is still mounted before updating the state
          if (mounted) {
            setState(() {
              // Set the variable to trigger the display of fireworks
              // _displayFireworks = false;
              _displayQuiz = true;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    print(screenWidth);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isCurtainOpen = !_isCurtainOpen;
            });
            if (_isCurtainOpen) {
              Future.delayed(Duration(seconds: 2), () {
                // Ensure the widget is still mounted before updating the state
                if (mounted) {
                  setState(() {
                    // Set the variable to trigger the display of fireworks
                    _displayFireworks = true;
                  });
                }
              });
              Future.delayed(Duration(seconds: 8), () {
                // Ensure the widget is still mounted before updating the state
                if (mounted) {
                  setState(() {
                    // Set the variable to trigger the display of fireworks
                    _displayFireworks = false;
                    _displayQuiz = true;
                  });
                }
              });
            }
          },
          child:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/heart.jpeg', // Replace with your background image URL
            ),
            fit: BoxFit.contain,
          ),
        ),
        child:
           Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                child: AnimatedContainer(
                  width: _isCurtainOpen ? 0 : screenWidth / 2,
                  height: screenHeight,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: Image.network(
                    'https://t4.ftcdn.net/jpg/01/35/87/89/360_F_135878937_sLm07yCbXbyef1K32kHbZvIsZEX2zoMh.jpg',
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire space
                  ),
                ),
              ),

              // Right curtain
              Positioned(
                right: 0,
                bottom: 0,
                child: AnimatedContainer(
                  width: _isCurtainOpen ? 0 : screenWidth / 2,
                  height: screenHeight,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  child: Image.network(
                    'https://t4.ftcdn.net/jpg/01/35/87/89/360_F_135878937_sLm07yCbXbyef1K32kHbZvIsZEX2zoMh.jpg',
                    fit: BoxFit
                        .cover, // Ensure the image covers the entire space
                  ),
                ),
              ),
              if (_displayFireworks) _Fireworks(userName: widget.userName),
              if (_displayQuiz) QuizScreen()
            ],
          ),
        ),
      ),
      )
    );
  
  }
}

class _Fireworks extends StatefulWidget {
  const _Fireworks({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  _FireworksState createState() => _FireworksState();
}

class _FireworksState extends State<_Fireworks>
    with SingleTickerProviderStateMixin {
  late final _controller = FireworkController(vsync: this)..start();
  late final _titleEditingController = TextEditingController(
    text: _controller.title,
  );
  late final _autoLaunchEditingController = TextEditingController(
    text: _controller.autoLaunchDuration.inMilliseconds.toString(),
  );
  late final _spawnTimeoutEditingController = TextEditingController(
    text: _controller.rocketSpawnTimeout.inMilliseconds.toString(),
  );
  late final _particleCountEditingController = TextEditingController(
    text: _controller.explosionParticleCount.toString(),
  );
  late final _particleSizeEditingController = TextEditingController(
    text: (_controller.particleSize * 10 ~/ 1).toString(),
  );

  var _showInfoOverlay = false;

  @override
  void dispose() {
    _controller.dispose();
    _titleEditingController.dispose();
    _autoLaunchEditingController.dispose();
    _spawnTimeoutEditingController.dispose();
    _particleCountEditingController.dispose();
    _particleSizeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _showInfoOverlay = !_showInfoOverlay;
        // });
      },
      child: Stack(
        children: [
          Fireworks(
            controller: _controller,
          ),
          ScreenUtilInit(
            designSize: const Size(1000, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return Positioned(
                top: 15.w,
                left: null,
                right: null,
                child: Container(
                  width: 1.sw, // Using sw extension for screen width
                  child: Center(
                    child: Text(
                      '${widget.userName}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        // final fontSize = constraints.maxWidth / controller.title.length * 3 / 4;
                        fontSize: screenWidth / widget.userName.length * 5/4,
                        fontWeight: FontWeight.w700
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
              );
            },
          ),
            ScreenUtilInit(
            designSize: const Size(1000, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return Positioned(
                top:screenHeight/3,
                left: null,
                right: null,
                child: Container(
                  width: 1.sw, // Using sw extension for screen width
                  child: Center(
                    child: Text(
                      'Tried a Skill',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        // final fontSize = constraints.maxWidth / controller.title.length * 3 / 4;
                        fontSize: screenWidth / 14 * 5/4,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
              );
            },
          ),
         
                ScreenUtilInit(
            designSize: const Size(1000, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return Positioned(
                top: screenHeight /2,
                left: null,
                right: null,
                child: Container(
                  width: 1.sw, // Using sw extension for screen width
                  child: Center(
                    child: Text(
                      'CODING',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        // final fontSize = constraints.maxWidth / controller.title.length * 3 / 4;
                        fontSize: screenWidth / 9 * 5/4,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
              );
            },
          ),
         
          ScreenUtilInit(
            designSize: const Size(1000, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return Positioned(
                bottom: 20.w,
                left: null,
                right: null,
                child: Container(
                  width: 1.sw, // Using sw extension for screen width
                  child: Center(
                    child: Text(
                      'Rebel Salute 2024',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        // final fontSize = constraints.maxWidth / controller.title.length * 3 / 4;
                        fontSize: screenWidth / 16 * 5/4,
                        fontWeight: FontWeight.w900
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ),
              );
            },
          ),
      
        ],
      ),
    );
  }
}

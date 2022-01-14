import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:bankapp/home/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  SplashPage createState() => SplashPage();
}

class SplashPage extends State<Splash> {
  @override
  void initState() {
    super.initState();
    buildTypewriterAnimatedTextKit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF00FF),
              Color(0xFF7FCDCD),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: buildTypewriterAnimatedTextKit(context),
        ),
      ),
    );
  }

  TypewriterAnimatedTextKit buildTypewriterAnimatedTextKit(
      BuildContext context) {
    return TypewriterAnimatedTextKit(
      speed: Duration(milliseconds: 950),
      isRepeatingAnimation: false,
      pause: Duration(milliseconds: 350),
      onFinished: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: Home(),
          ),
        );
      },
      text: ["bankapp"],
      textStyle: TextStyle(
        fontSize: 38.0,
        color: Colors.white,
        fontFamily: 'Pacifico',
      ),
      textAlign: TextAlign.center,
    );
  }
}

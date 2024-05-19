import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IntroScreen extends StatefulWidget {
  ContainerColor color = ContainerColor();

  IntroScreen({Key? key}) : super(key: key);
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff8338ec),
              Color(0xffd402da),
              Color(0xff5b1cea),
              Color(0xff76a6e0),
              Color(0xfff872af),
              Color(0xff8338ec),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage('assets/images/robot_icon.png'),
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 17.0),
                child: Text(
                  'FlexFlow Fitness\nChatbot',
                  style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      shadowColor: Colors.red,
                      backgroundColor: Colors.black,
                      minimumSize: const Size(70.0, 44.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'Get Fit Now',
                    style: TextStyle(fontSize: 18, color: Color(0xffFFBE0B)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class ContainerColor {
  Color color1 = const Color(0xff8338ec);
  Color color2 = const Color(0xffd402da);
  Color color3 = const Color(0xff5b1cea);
  Color color4 = const Color(0xff76a6e0);
  Color color5 = const Color(0xfff872af);
}

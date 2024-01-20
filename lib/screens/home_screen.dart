import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        //상단바 구분하기 위한 3가지 특성.(음영을통해서 구현함)
        //ㄴelevation,surfaceTintColor,shadowColor
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,

        backgroundColor: Colors.white, //배경색
        foregroundColor: Colors.green, //글자색
        title: const Text(
          "Today's Webtoons",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

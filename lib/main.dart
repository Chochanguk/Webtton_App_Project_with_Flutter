import 'package:flutter/material.dart';
import 'package:mini_webtoon_app/screens/home_screen.dart';
import 'package:mini_webtoon_app/services/api_service.dart';

void main() {
  //내가 만든 ApiService 클래스 중 .getTodaysToons() 함수 사용
  ApiService().getTodaysToons(); //★★★둘다 "()"를 붙여야함.★★★
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

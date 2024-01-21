import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mini_webtoon_app/screens/home_screen.dart';

/* 애뮬레이터 403에러 처리 하는법
http가 서버-클라이언트 통신 규칙(프로토콜)이기 때문입니다. 정해진 규칙에 의해서 통신을 한다는 뜻이지요.
User-Agent는 서버 또는 클라이언트의 소프트웨어 버전이나 os 버전을 나타내는 헤더입니다.
*/
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  //내가 만든 ApiService 클래스 중 .getTodaysToons() 함수 사용
  //ApiService().getTodaysToons(); //★★★둘다 "()"를 붙여야함.★★★(콘솔 확인용)
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

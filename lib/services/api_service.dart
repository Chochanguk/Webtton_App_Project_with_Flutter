//★★★http패키를 불러오되,해당 패키지에 namespace를 지정함.★★★
//★★★"as http"를 통해 패키지의 이름을 간단하게 구성한다.★★★
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    //★★get(Uri url, {Map<String, String>? headers})★★
    //★★url은 Uri의 형태로 받는다.★★
    final url = Uri.parse('$baseUrl/$today');
    //★Future<Response>이 형태로 받는 이유: 어떤 일이 일어날때까지 기다리는 것
    //★get함수가 미래에 완료되면 서버에 대한 응답도 함.
    //★★★우리는 이것을 비동기(async) 프로그램이라고도 한다.★★★
    // await http.get(url); //해당 값을 받아오기 까지 기다리기 위해★★★ "await" 지시어 사용
    //await지시어는 async 함수 내에서만 사용 가능하다.
    final response = await http.get(url);
    //응답 코드가 200이면 성공한거임.
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    //응답 코드가 200이 아니면 실패한 거임.
    throw Error();
  }
}

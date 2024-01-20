import 'dart:convert';
//★★★http패키를 불러오되,해당 패키지에 namespace를 지정함.★★★
//★★★"as http"를 통해 패키지의 이름을 간단하게 구성한다.★★★
import 'package:http/http.dart' as http;
import 'package:mini_webtoon_app/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  //List<WebtoonModel> 형태로 반환 하는데 비동기 이므로 Future로 반환
  Future<List<WebtoonModel>> getTodaysToons() async {
    //json으로 웹툰을 받아올때마다 List에 추가하기
    List<WebtoonModel> webtoonInstances = [];

    //★★get(Uri url, {Map<String, String>? headers})★★
    //★★url은 Uri의 형태로 받는다.★★
    final url = Uri.parse('$baseUrl/$today');
    //★★★★Future<Response>이 형태로 받는 이유: 어떤 일이 일어날때까지 기다리는 것
    //★get함수가 미래에 완료되면 서버에 대한 응답도 함.
    //★★★우리는 이것을 비동기(async) 프로그램이라고도 한다.★★★
    // await http.get(url); //해당 값을 받아오기 까지 기다리기 위해★★★ "await" 지시어 사용
    //await지시어는 async 함수 내에서만 사용 가능하다.
    final response = await http.get(url);
    //응답 코드가 200이면 성공한거임.
    if (response.statusCode == 200) {
      //★★★★★jsonDecode(response.body): 그저 텍스트로 된 body문장들을
      //★★★★★dynamic(어떤 데이터값이든 상관x)형태로 반환한다.
      //★★★이때 Json데이터는 {}(오브젝트)들로 구성된 List형태이므로
      //★★★해당 객체 webtoons의 데이터 타입을 List<dynamic>으로 받는다.
      final List<dynamic> Webtoons = jsonDecode(response.body);
      for (var webtoon in Webtoons) {
        /*웹툰 제목 출력 WebtoonModel.fromJson(webtoon) -> named constructor에서 초기화 시켜줌.
        final toon = WebtoonModel.fromJson(webtoon);
        print(toon.title);
        */
        //리스트에 넣고 관리하기
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    //응답 코드가 200이 아니면 실패한 거임.
    throw Error();
  }
}

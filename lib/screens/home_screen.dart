import 'package:flutter/material.dart';
import 'package:mini_webtoon_app/models/webtoon_model.dart';
import 'package:mini_webtoon_app/services/api_service.dart';
import 'package:mini_webtoon_app/widegets/webtoon_widget.dart';

/* "put state" after Data fecthing: Future를 기다리는 방법1... 고전적임
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> Webtoons = [];
  bool isLoading = true;

  //로딩이 끝나면 "로딩 중" 끄기
  void waitForWebToons() async {
    //getTodaysToons가 끝나면 해당 값들을 받기위해서 await으로 지정.
    Webtoons = await ApiService().getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }

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
*/
/* "put state" after Data fecthing: Future를 기다리는 방법2...훨씬 좋음(실수,코드량)*/
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  //ApiService().getTodaysToons()의 Future 객체 생성.
  //추후 이 객체는 FutureBuilder 위젯에서 다룸.
  final Future<List<WebtoonModel>> webtoons = ApiService().getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        // 뒤로가기 버튼 아이콘 변경
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // 원하는 아이콘으로 변경
          ),
          onPressed: () {
            // 뒤로가기 버튼 클릭 시 수행할 작업 추가 (선택사항)
            Navigator.pop(context);
          },
        ),
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
      //★★★★ data를 fetching하고, await하고, setState를 한방에 해주는 위젯
      //★★★★ FutuerBuilder!!!
      body: FutureBuilder(
        future: webtoons, //굳이 await안해도 됨

        //snapshot을 통해 Future의 상태를 안다.(snapshot.data,snapshot.error 등을 알 수 있다.)
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //★★★"snapshot.hasData" 를 통해 지금 API로부터★★★
          //Future형의 객체가 데이터 받고 있는 데이터가 있는지 확인 가능
          if (snapshot.hasData) {
            /*ListView를 통해 웹툰의 데이터를 로딩함. +scroll도 됨.
            return ListView(
              children: [
                //snapshot.data는 future 객체가 받는 최종 데이터들
                //"!"은 null 아닐경우 명시 해주는건데 위에서 조건 체크하므로 ! 사용
                for (var webtoon in snapshot.data!) Text('${webtoon.title}'),
              ],
            );*/
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //Listview의 column의 범위 지정
                Expanded(child: makeList(snapshot)),
              ],
            );
          } else {
            //Loading중일땐, 동그라미로 보여줌
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<dynamic> snapshot) {
    //ListView.builder가 ListView를 최적화 한것이다.
    //이는 사용자가 보고 있는 아이템에 대해서만 build 할수 있다.
    //ListView.separated는 builder보다 더 최적화 되어있다.
    //이는 SizedBox및 무언가를 통해 각 item별 구분을해준다.
    return ListView.separated(
      scrollDirection: Axis.horizontal, //수평방향 스크롤
      itemCount: snapshot.data.length, //item총 개수
      //각 리스트들을 패딩
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        //보이는 것에 대한각 인덱스별 webtoon객체를 빌드함.
        //스크롤 하면 사용자가 보이는 item에 대해서만 객체를 얻음.
        print(index);
        var webtoon = snapshot.data[index];
        //webtoon_widget에서 클래스로 따로 만든 카드모양
        return Webtoon(
          id: webtoon.id,
          thumb: webtoon.thumb,
          title: webtoon.title,
        );
      },
      //SizedBox를 통해 각 item별 구분하였음.
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(width: 40),
    );
  }
}

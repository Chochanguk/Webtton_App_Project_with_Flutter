import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_webtoon_app/models/webtoon_detail_model.dart';
import 'package:mini_webtoon_app/models/webtoon_episode_model.dart';
import 'package:mini_webtoon_app/services/api_service.dart';
import 'package:mini_webtoon_app/widegets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String id, thumb, title;

  //Navigator.push를 통해서 받은 값들
  const DetailScreen({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //일단 선언하고, 나중에 initState에서 초기 상태 세팅
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes; //애는 List로 받아옴

  //★★★initState는 (widget.~)에 접근 가능.
  //★★★widget은 state를 통해 상위 클래스에 접근 하는건데, 이렇게 해주면 접근가능
  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
    initPrefs(); //사용자 저장소 접근 함수... 초기에 확인
  }

  //★★★★★★좋아요 기능★★★★★★
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    //사용자 저장소에 접근하여 받아옴.
    prefs = await SharedPreferences.getInstance();
    //사용자 저장소에서 likedToons를 찾아봄
    final likedToons = prefs.getStringList('likedToons'); //해당 키값으로 리스트를 받아옴
    if (likedToons != null) {
      //만약 해당 웹툰(id)를 가지면 좋아요체크
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      //해당키 값으로 리스트를 setting (null이니까)
      await prefs.setStringList('likedToons', []);
    }
  }

  //좋아요 누르기,취소 함수
  onHeatTaP() async {
    //1. 사용자는 버튼을 클릭하면 List를 먼저 가져옴
    final likedToons = prefs.getStringList('likedToons');
    //2. likedToons리스트가 null이 아니면
    if (likedToons != null) {
      //3. 사용자가 이미 좋아요를 누르면 해당 id를 리스트에서 제거
      if (isLiked) {
        likedToons.remove(widget.id);
        //4. 좋아요를 안눌렀다면 id를 리스트에 add
      } else {
        likedToons.add(widget.id);
      }
      //5. 위의 if문에 대한 List를 핸드폰 저장소에 다시금 List를 저장(setting)
      await prefs.setStringList('likedToons', likedToons);
      //6. 버튼을 눌러서 좋아요 상태가 바뀌었으니 반대되는 상태로 바꿈
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // 뒤로가기 버튼 아이콘 변경
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded, // 원하는 아이콘으로 변경
          ),
          onPressed: () {
            // 뒤로가기 버튼 클릭 시 수행할 작업 추가 (선택사항)
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        //상단바 구분하기 위한 3가지 특성.(음영을통해서 구현함)
        //ㄴelevation,surfaceTintColor,shadowColor
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,

        backgroundColor: Colors.white, //배경색
        foregroundColor: Colors.green, //글자색
        title: Text(
          widget.title, //★★(widget.~)DetialScreen부터 상위 클래스로부터 받으란 이야기
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
              onPressed: onHeatTaP,
              icon: Icon(
                isLiked
                    ? Icons.favorite_outlined //속이 꽌찬 하트
                    : Icons.favorite_outline_outlined, //속이 빈 하트
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 50,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget
                        .id, //hero위젯은 tag속성을 두어 각 child 마다 id를 부여해서 나타나게 한다.
                    child: Container(
                      width: 250,
                      //둥글게 하기 위해 짜름
                      clipBehavior: Clip.hardEdge,
                      //container로 이미지를 설정한 후 BoxDecoration에서
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          //★★★box에 그림자 및 음영 넣기★★★
                          //3가지 blurRadius,offest,color
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(10, 10),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ]),
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start, //왼쪽 정렬
                      children: [
                        //about: 웹툰에 대한 간략한 설명
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // 장르 / 이용나이
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('...');
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //ListView보다 Column으로 하는이유: 10개 뿐이라서(아이템 요소의 개수를 알기에)
                    //다만 최적화는 ListView가 더 나을 수도 있다.
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          //왼쪽엔 아이콘, 오른쪽엔 텍스트표시
                          Episode(
                            episode: episode,
                            webtoonId: widget.id,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mini_webtoon_app/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String id, thumb, title;
  const Webtoon({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    //★★★GestureDetector는 사용자으 대부분의 동작을 감지하도록 한다.★★★
    return GestureDetector(
      onTap: () {
        //★★★화면전환을 위한 메소드: Naviagtor(context,route)★★★
        //route는 StatlessWidget을 애니메이션 효과로 감싸서 스크린처럼 보이게 하는 것
        //따라서 그냥 DetailScreen 클래스를 그대로 쓸수 없다.(ctrl+space)
        Navigator.push(
          context,
          //★★★MaterialPageRoute(buileder: %%% )★★★
          //builder는 새로운 화면을 생성하고 반환하는 역할을 한다.
          //즉, context를 새로운 클래스에 적용 시키는 역할.
          /*
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: id,
              thumb: thumb,
              title: title,
            ),
            // fullscreenDialog: true,
          ),
          */
          //PageRouteBuilder는 android에선 MaterialPageRoute보단 이게 더 낫다.
          //좀 더 명확한 애니메이션을 만들 수 있다.(customize the transition animation)

          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0); //아래에서 위 방향
              var end = Offset.zero;
              var curve = Curves.ease; //애니메이션 모양
              var tween =
                  //chain메소드를 통해 Tween과 CurveTween의 애니메이션을 결합
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, anmation, secondaryAnimation) =>
                DetailScreen(
              id: id,
              title: title,
              thumb: thumb,
            ),
          ),
        );
      },
      child: Column(
        children: [
          //★★★ container로 이미지를 설정한 후 BoxDecoration를 통해
          //★★★ 이미지 카드를 꾸밈.
          //★★★★★ Hero 위젯을 통해서 해당 container들이 떠다니는 듯이
          //보이는 애니메이션 구현 가능.
          Hero(
            tag: id,
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
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

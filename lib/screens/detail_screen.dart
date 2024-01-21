import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatelessWidget {
  final String id, thumb, title;
  //Navigator.push를 통해서 받은 값들
  const DetailScreen({
    super.key,
    required this.id,
    required this.thumb,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        centerTitle: true,
        //상단바 구분하기 위한 3가지 특성.(음영을통해서 구현함)
        //ㄴelevation,surfaceTintColor,shadowColor
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,

        backgroundColor: Colors.white, //배경색
        foregroundColor: Colors.green, //글자색
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ],
      ),
    );
  }
}

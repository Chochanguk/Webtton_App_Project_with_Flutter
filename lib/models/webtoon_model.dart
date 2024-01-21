import 'package:flutter/material.dart';

//각 Json형태의 웹툰별 Dart클래스로 초기화 해주는 클래스
class WebtoonModel {
  final String id, thumb, title;
  //★★★named Constructor★★★
  /* 1.getTodaysToons()함수의 일부(dynamic형태로 줌.)
    final List<dynamic> Webtoons = jsonDecode(response.body);
    for (var webtoon in Webtoons) {
        WebtoonModel.fromJson(webtoon);
    }
  */
  //2. named Constructor의 이름을 fromJson이라고 지음.
  //3. 각각 <키(특성),data(dynamic)> 쌍으로 json을(객체) 받음. 따라서 Map 사용
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        thumb = json['thumb'],
        title = json['title'];
}

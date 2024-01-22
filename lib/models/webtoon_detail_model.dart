class WebtoonDetailModel {
  //api에 title,about(웹툰 간략 소개),genre,age값 받아오기
  final String title, about, genre, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}

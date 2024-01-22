//최근 에피소드를 표시해주는 위젯
import 'package:flutter/material.dart';
import 'package:mini_webtoon_app/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  final WebtoonEpisodeModel episode;
  final String webtoonId;
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  //★★★url_launcher사용
  //★★★해당 브라우저로 이동하는 메소드★★★
  onButtonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
    //launchUrl함수는 Future 함수를 갔다줌
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        //★★★각각의 요소에 margin 주는법: EgeInsets.only
        margin: const EdgeInsets.only(bottom: 10),
        //둥글게 하기 위해 짜름
        clipBehavior: Clip.hardEdge,
        //container로 이미지를 설정한 후 BoxDecoration에서
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade300,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(episode.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
              //">"이모양은 chevron이다.
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

# mini_webtoon_app
각 진행 내용은 총 3개로 나누었고, 가지를 만들어서 진행했습니다.
![image](https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/12930a76-0569-4559-ac15-1eb52274a11c)

## Json형태의 데이터의 API 데이터 확인(디버그 콘솔)
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/3c015228-ad3a-4f39-8f4c-68d653574693" width=70% height=50%/>

## 웹툰 제목 출력
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/bf746ad0-9968-49bf-b9fa-230c974462e8" width=70% height=50%/>


## 웹툰 card생성
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/8eb59d6b-929c-434e-ae2f-33fab69bf778" width=30% height=30%/>

## 화면 전환 및 애니메이션 추가(화면 전환: PageRouteBuilder(transitionsBuilder:~~,pageBuilder: (context, anmation, secondaryAnimation) => ~~),Hero위젯(container를 떠다니게 하는 위젯))
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/84a5cefb-2264-4b49-81b1-72eea33c1a2d" width=30% height=30%/>


# API서비스 및 로컬저장소에 저장
ApiService Class(웹툰정보 및 웹툰 불러오기),initPrefs(좋아요 기능),Navigator
=> ApiService클래스: 1.Url String 선언/ 2. Future 로 비동기 형태로 반환 repsone는 await/ 3. url은 Uri.Parse를 해서 선언/ 4. 코드가 성공이 (200)아니면 에러 처리/ 5. 각 인스턴스에 대해 변수로 받아서 return
## 최종 화면
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/ee2e2b6e-0641-4127-816f-22fc6b3282a3" width=30% height=30%/>
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/94c87925-f4bb-4980-828a-937dcd6d142c" width=30% height=30%/>
<img src="https://github.com/Chochanguk/Webtton_App_Project_with_Flutter/assets/119058637/ce7af623-cb2d-45e3-acf1-7978a9897b56" width=30% height=30%/>



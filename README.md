# CityWeather

<img width="18%" src="https://github.com/Greeddk/CityWeather/assets/116425551/f170b315-fa76-4d24-b001-f6e73ffe3e5e"/>
<img width="18%" src="https://github.com/Greeddk/CityWeather/assets/116425551/d852e232-45fe-4c90-a4fe-1cf7b40c175f"/>
<img width="18%" src="https://github.com/Greeddk/CityWeather/assets/116425551/252dd33d-e32f-438a-9e01-63ba2fb15cbf"/>
<img width="18%" src="https://github.com/Greeddk/CityWeather/assets/116425551/06aab6c1-6696-4561-b74a-e97c1f571b56"/>
<img width="18%" src="https://github.com/Greeddk/CityWeather/assets/116425551/6e301da3-f04f-4d46-9a9a-e3296a696c81"/>

## 개발 환경

### 개발 기간

- 2024.06.24 ~ 2024.06.26 (3일)

### Configuration

- 최소버전 15.0 / 라이트 모드 / 세로모드 / iOS전용

### 기술 스택

- UIKit / MVVM
- RxSwift / RxCoCoa
- CodeBaseUI / SnapKit
- Alamofire

## 구현 고려 사항

### 1. Locale과 timezone

- 여러 도시의 현지 시각 등을 고려하였습니다.
    - API에서 받아오는 timezone 값을 사용해 현지 시각으로 시간을 표현하였습니다.

### 2. 네트워크 단절

- API를 사용하는 앱이기 때문에 네트워크 단절에 대한 대응이 필요하다고 생각하였습니다.
- MWPathMonitor를 사용해 SceneDelegate에서 네트워크 단절 상황 및 재연결 상황을 모니터링합니다.
    - 네트워크 단절시 불투명한 네트워크 통신 에러 뷰를 화면에 띄웁니다.
    - 네트워크가 재연결되면 네트워크 통신 에러 뷰를 제거합니다.

### 3. 네트워크 에러 핸들링

- API에 따라 다양한 에러가 발생할 수 있으며, 에러가 발생했을 때 유저에게 이를 알려줄 필요가 있다고 판단했습니다.
- NetworkError를 만들고, case에 따라 보여줄 에러메시지를 정의하였습니다.
  - 네트워크 통신 중 에러가 발생하면 에러메시지를 사용자에게 alert로 띄어서 보여주게 하였습니다.

### 4. 네트워크 라우터 패턴 활용

- 만약 이것이 출시하는 프로젝트이고, 여러개의 API로 통신을 한다고 가정을 하였을 때, 유지보수성을 고려하였습니다.
  - URLRequestConvertible를 사용해서 Router 패턴으로 네트워크 통신을 할 수 있게 만들었습니다.

### 5. 커스텀 뷰

- 한 앱에서 같은 뷰 객체가 여러 곳에 사용되는 경우가 많고, 디자인 역시 일관성 있게 유지되는 경우를 고려하였습니다.
- 여러 곳에 쓰일 뷰 객체 혹은 설정이 많이 필요한 뷰 객체를 커스텀 뷰로 만들어서 사용하였습니다.

### 6. BaseURL 및 key 값들 gitignore 처리

- 실제 서비스로 가정했을 때 노출이 최소화 되어야 하는 값들을 gitignore 처리를 하였습니다.

### 7. 성능 최적화

- 성능 최적화를 위해 더 이상 상속하지 않는 class 앞에 final을 붙여, 스테틱 디스패치를 하게 만들었습니다.
- 프로퍼티와 메서드 앞에 접근 제어자를 붙여 성능을 최적화했습니다.

### 8. 사용자 입장을 고려한 UX

- 3시간 간격 일기예보의 스크롤을 오른쪽으로 이동시킨 후 다른 도시를 검색해서 다시 메인뷰로 돌아왔을 때, 오른쪽으로 이동된 채로 남아있게됩니다.
- 도시를 검색해서 다시 메인뷰로 돌아왔을 때, 제일 처음 일기예보부터 보이게 구현하였습니다.
    - ScrollToItem을 사용하여 컬렉션뷰가 첫번째 item으로 이동하게 설정하였습니다.

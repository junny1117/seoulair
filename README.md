# seoulair

## 개요
- Flutter 프레임워크를 사용한 서울시의 각 구별로 미세먼지 및 초미세먼지 농도를 실시간으로 확인할 수 있는 웹사이트 및 안드로이드 애플리케이션

## 사용 데이터
- [한국환경공단 에어코리아 대기오염정보](https://www.data.go.kr/data/15073861/openapi.do)
- [서울시 실시간 대기환경 평균 현황](https://data.seoul.go.kr/dataList/OA-1201/S/1/datasetView.do)

## 사용 도구/기술
- **Flutter**: SDK
- **Dart**: 개발언어
- **http/https**: API 통신
- **xml**: 데이터 파싱
- **Geolocatation**: 위치 정보 수집
- **Geocoding**: 좌표→주소 변환 
- **Android Studio**: IDE
- **Windows**: 운영체제

## 주요 기능
- **미세먼지 농도 표출**: 각 구별 미세먼지 및 초미세먼지 농도와 등급(좋음, 보통, 나쁨, 매우 나쁨) 표시
- **시각적 정보**: 미세먼지 농도에 따라 상태를 색상으로 구분 (초록: 좋음, 노랑: 보통, 주황: 나쁨, 빨강: 매우 나쁨)
- **서울시 평균 농도**: 애플리케이션 한정으로 서울시 전체 평균 미세먼지 농도를 표시
- **앱 다운로드 링크**: 웹사이트 한정으로 안드로이드 앱 다운로드 링크 제공

## 작동 과정
1. 사용자가 지역 선택(웹사이트) 또는 위치 기반 자동 선택(애플리케이션)
2. 선택된 구의 이름을 요청 인자로 넣어 한국환경공단 에어코리아 대가오염정보 API 호출 및 수신
3. 미세먼지 및 초미세먼지 농도를 등급별로 변환
4. 서울시 실시간 대기환경 평균 현황 API에서 서울시 평균 미세먼지 농도 수신 (애플리케이션 한정)
5. 상기 정보를 사용자에게 표출

## 웹사이트 / 애플리케이션 차이

| 항목                | 웹사이트                                | 애플리케이션                                      |
|---------------------|-----------------------------------|-----------------------------------------|
| **측정소 선택**      | 사용자가 직접 선택               | 사용자 위치 기반으로 자동 선택 (변경 불가) |
| **서울시 평균 데이터** | 제공하지 않음                    | 제공                                    |
| **기타**             | 안드로이드 앱 다운로드 링크 제공 | -                                       |
## UI 예시
- 웹사이트
![image](https://github.com/user-attachments/assets/9647495b-b833-4458-8663-770edfdc64e8)

- 애플리케이션

![image](https://github.com/user-attachments/assets/61cdb208-96cb-4e46-8bce-0e5f808639a3)

## 링크
- [웹사이트](https://junny1117.github.io/seoulair)
- [애플리케이션 다운로드 링크](https://drive.usercontent.google.com/download?id=1Cpr3Fg9AZmVUiZ_Ve3PRvR4zryAsnLtU&export=download&authuser=0&confirm=t&uuid=3cae1721-0bc4-4eea-a52e-20690fc70900&at=AO7h07fYoiSDLeY9r2Do4Tb7gSPT:1725624913381)

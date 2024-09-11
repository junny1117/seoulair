# seoulair

## 개요
- Flutter 프레임워크를 사용한 서울시의 각 구별로 미세먼지 정보를 실시간으로 확인할 수 있는 웹사이트와 앱
- 서울시 미세먼지 농도 데이터를 한국환경공단의 API를 통해 가져와서 화면에 표시.
- 미세먼지 농도와 초미세먼지 농도를 시각적으로 표시하며, 미세먼지 농도에 따라 색상으로 상태를 구분.
- 서울시 미세먼지 평균 농도 데이터를 서울시 열린데이터 광장의 API를 통해 가져와서 화면에 표시(앱 한정)
- 안드로이드 앱 다운로드 링크 제공(웹 한정)

## 목적
1. **실시간 미세먼지 확인**: 서울시 각 구별로 미세먼지(PM10) 및 초미세먼지(PM2.5) 농도를 실시간으로 확인 가능
2. **대기질 시각화**: 미세먼지 농도에 따라 색상과 아이콘으로 시각적 변화를 주어 대기 상태를 직관적으로 확인 가능

## 사용 기술
- **프레임워크**: Flutter
- **개발언어**: Dart
- **API 통신**: http
- **데이터 파싱**: xml
- **상태 관리**: setState

## API 통신
- **API**: 한국환경공단 및 서울시 열린데이터 광장의 미세먼지 정보 API
- **통신 방식**: http 패키지를 통해 API 호출 후 xml 데이터를 파싱
- **매개변수**: 서비스 키, 측정소 이름, 페이지 정보 등

## 상태 관리 및 데이터 처리
- 앱 시작 시 또는 구가 변경될 때 API 호출을 통해 데이터 수신
- 받아온 데이터는 `Map<String, dynamic>`에 저장되어 UI에 표시

## 에러 처리
- API 호출 실패 시 다이얼로그(AlertDialog)를 띄워 사용자에게 에러 메시지를 표시
- 데이터가 없거나 수신에 실패한 경우에도 사용자에게 적절한 메시지를 제공

## 주요 기능
- **UI**: MaterialApp을 사용하여 전체 UI를 구성, 카드 형식으로 미세먼지 및 초미세먼지 농도 표시
- **측정소 정보**: 각 구별 미세먼지 및 초미세먼지 농도와 그 상태(좋음, 보통, 나쁨, 매우 나쁨) 표시
- **시각적 정보**: 미세먼지 농도에 따라 상태를 색상과 텍스트로 구분 (초록: 좋음, 노랑: 보통, 주황: 나쁨, 빨강: 매우 나쁨)
- **서울시 평균 데이터**: 앱 한정으로 서울시 전체 평균 미세먼지 농도를 표시
- **앱 다운로드 링크**: 웹 한정으로 안드로이드 앱 다운로드 링크 제공

## UI 구성
- `_buildInfoCardWithIcon`: 아이콘과 함께 미세먼지 및 초미세먼지 농도를 표시
- `_buildInfoCard`: 서울시 평균 미세먼지 데이터를 간단한 텍스트 카드로 표시 (앱 한정)
- `_getCondition`: 미세먼지 등급에 따라 상태를 반환
- `_getGradeColor`: 미세먼지 등급에 따른 색상을 반환하여 UI에서 시각적 차별화 제공

## 작동 과정
1. 사용자가 지역 선택(웹) 또는 위치기반 자동 선택(앱)
2. 선택된 구의 이름을 API 요청 인자로 넣어 호출
3. 미세먼지 및 초미세먼지 농도를 등급별로 변환하여 표시
4. 서울시 평균 데이터 수신 및 표시 (앱 한정)

## 웹사이트 / 앱 차이

| 항목                | 웹                                | 앱                                      |
|---------------------|-----------------------------------|-----------------------------------------|
| **측정소 선택**      | 사용자가 직접 선택               | 사용자 위치 기반으로 자동 선택 (변경 불가) |
| **서울시 평균 데이터** | 제공하지 않음                    | 제공                                    |
| **기타**             | 안드로이드 앱 다운로드 링크 제공 | -                                       |
## UI 예시
- 안드로이드 앱

![image](https://github.com/user-attachments/assets/61cdb208-96cb-4e46-8bce-0e5f808639a3)

- 웹사이트
![image](https://github.com/user-attachments/assets/9647495b-b833-4458-8663-770edfdc64e8)

## 링크
- [웹사이트](https://junny1117.github.io/seoulair)
- [앱 다운로드 링크](https://drive.usercontent.google.com/download?id=1Cpr3Fg9AZmVUiZ_Ve3PRvR4zryAsnLtU&export=download&authuser=0&confirm=t&uuid=3cae1721-0bc4-4eea-a52e-20690fc70900&at=AO7h07fYoiSDLeY9r2Do4Tb7gSPT:1725624913381)

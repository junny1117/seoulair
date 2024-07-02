import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'dart:html' as html;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '서울시 미세먼지 현황',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AirQualityWidget(),
    );
  }
}

class AirQualityWidget extends StatefulWidget {
  @override
  _AirQualityWidgetState createState() => _AirQualityWidgetState();
}

class _AirQualityWidgetState extends State<AirQualityWidget> {
  final String airKoreaUrl =
      'https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty';
  final String airKoreaKey =
      'iCE57XnzdEmcsUE7tEDGpJHMXcxYCp1dxk8rw6syvPVHE8xix%2Bu9xHxP%2BmiryTcFgZTVY%2FDIOlw7bzrrPV65WQ%3D%3D';

  String _selectedDistrict = '강남구';
  Map<String, dynamic> _airQualityData = {};

  @override
  void initState() {
    super.initState();
    _fetchAirQualityData();
  }

  Future<void> _fetchAirQualityData() async {
    try {
      var response = await http.get(Uri.parse(
          '$airKoreaUrl?serviceKey=$airKoreaKey&dataTerm=DAILY&numOfRows=1&pageNo=1&ver=1.5&stationName=$_selectedDistrict'));
      if (response.statusCode == 200) {
        var document = XmlDocument.parse(response.body);
        var items = document.findAllElements('item');
        if (items.isNotEmpty) {
          var item = items.first;
          setState(() {
            _airQualityData = {
              'dataTime': item.findElements('dataTime').first.text,
              'stationName': item.findElements('stationName').first.text,
              'pm10Value': item.findElements('pm10Value').first.text,
              'pm25Value': item.findElements('pm25Value').first.text,
              'pm10Flag': item.findElements('pm10Flag').first.text,
              'pm25Flag': item.findElements('pm25Flag').first.text,
              'pm10Grade1h': item.findElements('pm10Grade1h').first.text,
              'pm25Grade1h': item.findElements('pm25Grade1h').first.text,
            };
          });
        } else {
          _showError('미세먼지 농도 정보를 가져오는 데 실패했습니다.');
        }
      } else {
        throw Exception('미세먼지 농도 정보를 가져오는 데 실패했습니다.');
      }
    } catch (e) {
      _showError('미세먼지 농도 정보를 가져오는 데 실패했습니다: $e');
    }
  }

  Widget _buildDistrictDropdown() {
    return DropdownButton<String>(
      value: _selectedDistrict,
      items: [
        '강남구',
        '강동구',
        '강북구',
        '강서구',
        '관악구',
        '광진구',
        '구로구',
        '금천구',
        '노원구',
        '도봉구',
        '동대문구',
        '동작구',
        '마포구',
        '서대문구',
        '서초구',
        '성동구',
        '성북구',
        '송파구',
        '양천구',
        '영등포구',
        '용산구',
        '은평구',
        '종로구',
        '중구',
        '중랑구',
      ].map((district) => DropdownMenuItem<String>(
        value: district,
        child: Text(district),
      )).toList(),
      onChanged: (district) {
        setState(() {
          _selectedDistrict = district!;
          _fetchAirQualityData();
        });
      },
    );
  }

  Widget _buildAirQualityInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoCard("측정소", _airQualityData['stationName'] ?? ''),
          _buildInfoCard("기준 일시", _airQualityData['dataTime'] ?? ''),
          _buildInfoCardWithIcon(
            "미세먼지 농도",
            "${_airQualityData['pm10Value']} ${_airQualityData['pm10Flag']} (${getCondition(_airQualityData, 'pm10Grade1h')})",
            _getGradeColor(_airQualityData, 'pm10Grade1h'),
            Icons.cloud,
          ),
          _buildInfoCardWithIcon(
            "초미세먼지 농도",
            "${_airQualityData['pm25Value']} ${_airQualityData['pm25Flag']} (${getCondition(_airQualityData, 'pm25Grade1h')})",
            _getGradeColor(_airQualityData, 'pm25Grade1h'),
            Icons.cloud,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCardWithIcon(String title, String value, Color color, IconData icon) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCondition(Map<String, dynamic> airQualityData, String gradeKey) {
    final int grade = int.tryParse(airQualityData[gradeKey] ?? '') ?? 0;
    switch (grade) {
      case 1:
        return '좋음';
      case 2:
        return '보통';
      case 3:
        return '나쁨';
      case 4:
        return '매우 나쁨';
      default:
        return '';
    }
  }

  Color _getGradeColor(Map<String, dynamic> airQualityData, String gradeKey) {
    final int grade = int.tryParse(airQualityData[gradeKey] ?? '') ?? 0;
    switch (grade) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('에러'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  // 다운로드 링크 처리
  void _downloadApk() {
    final anchor = html.AnchorElement(href:'https://drive.usercontent.google.com/download?id=1Cpr3Fg9AZmVUiZ_Ve3PRvR4zryAsnLtU&export=download&authuser=0&confirm=t&uuid=0484d5f1-61e2-4c8d-8427-96b70f6181a2&at=APZUnTWg-TUV9LgaaTeJSdInxp2Q:1715870006071')
      ..setAttribute('download', 'apk-release.apk');
    anchor.click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '서울시 미세먼지 현황',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDistrictDropdown(),
            SizedBox(height: 15),
            _airQualityData.isNotEmpty ? _buildAirQualityInfo() : CircularProgressIndicator(),
            SizedBox(height: 15),

            Text(
              '안드로이드 앱에서는 현재 위치의 측정 데이터와 서울시 평균 데이터를 추가로 지원합니다!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _downloadApk, // 다운로드 링크 핸들러 호출
              child: Text(
                '안드로이드 앱 다운로드하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              '데이터는 실시간 관측된 자료이며 측정소 현지사정이나 데이터의 수신상태에 따라 미수신 될 수 있음',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            Text(
              '데이터 출처: 한국환경공단',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '미세먼지',
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
  Map<String, dynamic> _airQualityData = {
    'dataTime': "2024-04-29 13:00",
    'stationName': "노원구",
    'pm10Value': "30",
    'pm25Value': "20",
    'pm10Flag': '',
    'pm25Flag': '',
    'pm10Grade1h': "1",
    'pm25Grade1h': "2",
  };

  Map<String, dynamic> _avgData = {
    'PM10': "65",
    'PM25': "35",
  };

  Widget _buildAirQualityInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoCard("측정소", _airQualityData['stationName'] ?? ''),
          _buildInfoCard("기준 일시", _airQualityData['dataTime'] ?? ''),
          _buildInfoCardWithIcon(
            "미세먼지 농도",
            "${_airQualityData['pm10Value']} ${_airQualityData['pm10Flag']} (${getCondition(_airQualityData['pm10Grade1h'])})",
            _getGradeColor(_airQualityData['pm10Grade1h']),
            Icons.cloud,
          ),
          _buildInfoCardWithIcon(
            "초미세먼지 농도",
            "${_airQualityData['pm25Value']} ${_airQualityData['pm25Flag']} (${getCondition(_airQualityData['pm25Grade1h'])})",
            _getGradeColor(_airQualityData['pm25Grade1h']),
            Icons.cloud,
          ),

          SizedBox(height: 10),
          Text(
            "서울시 평균",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          _buildInfoCard("미세먼지", _avgData['PM10'] ?? ''),
          _buildInfoCard("초미세먼지", _avgData['PM25'] ?? ''),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
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
            SizedBox(height: 5),
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
      margin: EdgeInsets.only(bottom: 10),
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
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
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

  String getCondition(String grade) {
    switch (grade) {
      case "1":
        return '좋음';
      case "2":
        return '보통';
      case "3":
        return '나쁨';
      case "4":
        return '매우 나쁨';
      default:
        return '';
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case "1":
        return Colors.green;
      case "2":
        return Colors.yellow;
      case "3":
        return Colors.orange;
      case "4":
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          '미세먼지 현황',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey,
        child: _airQualityData.isNotEmpty
            ? _buildAirQualityInfo()
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

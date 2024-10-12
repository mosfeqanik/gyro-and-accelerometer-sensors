import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/sensor_provider.dart';

class SensorDetailScreen extends StatefulWidget {
  const SensorDetailScreen({super.key});

  @override
  State<SensorDetailScreen> createState() => _SensorDetailScreenState();
}

class _SensorDetailScreenState extends State<SensorDetailScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SensorProvider>(context, listen: false).sensorIntialFunc(
      onError: (String errorMessage) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<SensorProvider>(context, listen: false).disposeStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
        elevation: 4,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Consumer<SensorProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      if (provider.alert)
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.red,
                          child: const Text(
                            'ALERT',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      sensorWidget(
                        sensorTitle: 'UserAccelerometer',
                        firstData:
                            provider.userAccelerometerEvent?.x.toStringAsFixed(1),
                        secondData:
                            provider.userAccelerometerEvent?.y.toStringAsFixed(1),
                        thirdData:
                            provider.userAccelerometerEvent?.z.toStringAsFixed(1),
                        dataList1: provider.userAccelDataX,
                        dataList2: provider.userAccelDataY,
                        dataList3: provider.userAccelDataZ,
                      ),
                    ],
                  );
                },
              ),
              Consumer<SensorProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      if (provider.alert)
                        Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.red,
                          child: const Text(
                            'ALERT',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      sensorWidget(
                        sensorTitle: 'gyro scope',
                        firstData:
                            provider.gyroscopeEvent?.x.toStringAsFixed(1),
                        secondData:
                            provider.gyroscopeEvent?.y.toStringAsFixed(1),
                        thirdData:
                            provider.gyroscopeEvent?.z.toStringAsFixed(1),
                        dataList1: provider.gyroDataX,
                        dataList2: provider.gyroDataY,
                        dataList3: provider.gyroDataZ,
                      ),
                    ],
                  );
                },
              ),
              Consumer<SensorProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      if (provider.alert)
                        Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.red,
                          child: Text(
                            'ALERT',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      sensorWidget(
                        sensorTitle: 'Accelerometer',
                        firstData:
                            provider.accelerometerEvent?.x.toStringAsFixed(1),
                        secondData:
                            provider.accelerometerEvent?.y.toStringAsFixed(1),
                        thirdData:
                            provider.accelerometerEvent?.z.toStringAsFixed(1),
                        dataList1: provider.accelDataX,
                        dataList2: provider.accelDataY,
                        dataList3: provider.accelDataZ,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sensorWidget(
      {String? sensorTitle,
      String? firstData,
      String? secondData,
      String? thirdData,
      List<FlSpot>? dataList1,
      List<FlSpot>? dataList2,
      List<FlSpot>? dataList3}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('$sensorTitle'),
        ),
        sensorDetailsRow(
            firstData: firstData, secondData: secondData, thirdData: thirdData),
        sensorGraph(dataList1!, dataList2!, dataList3!, "$sensorTitle"),
      ],
    );
  }

  Widget sensorDetailsRow(
      {String? firstData, String? secondData, String? thirdData}) {
    return Row(
      children: [
        textWidget(firstData),
        textWidget(secondData),
        textWidget(thirdData),
      ],
    );
  }

  Widget textWidget(String? firstData) => Text(firstData ?? '?');

  Widget sensorGraph(List<FlSpot> dataX, List<FlSpot> dataY, List<FlSpot> dataZ,
      String title) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: -1,
          maxY: 1,
          minX: dataX.first.x,
          maxX: dataX.last.x,
          lineTouchData: const LineTouchData(enabled: false),
          clipData: const FlClipData.all(),
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: dataX,
              isCurved: true,
              color: Colors.red,
              dotData: const FlDotData(show: true),
            ),
            LineChartBarData(
              spots: dataY,
              isCurved: true,
              color: Colors.green,
              dotData: const FlDotData(show: true),
            ),
            LineChartBarData(
              spots: dataZ,
              isCurved: true,
              color: Colors.blue,
              dotData: const FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}

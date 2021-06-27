
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pedometer/pedometer.dart';
import 'package:latlong/latlong.dart';

import 'components/Dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamSubscription _stepCountSubscription;
  int stepCount;

  StreamSubscription _locationSubscription;
  Position position;

  List<Position> historyPositions = [];

  @override
  void initState() {
    super.initState();
    initPedometer();
    initLocation();
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
    _locationSubscription.cancel();
  }

  void onStepCount(StepCount event) {
    setState(() {
      stepCount = event.steps;
    });
    debugPrint('stepCount = ${event.steps}');
  }

  void initPedometer() async {
    var stepCountStream = await Pedometer.stepCountStream;
    _stepCountSubscription = stepCountStream.listen(onStepCount);
  }

  void updateLocation(Position newPosition) {
    print("当前定位 $newPosition");
    setState(() {
      position = newPosition;
      historyPositions.add(newPosition);
    });
  }

  void initLocation() async {
    // Step1 定位权限检查
    GeolocationStatus permission =
      await Geolocator().checkGeolocationPermissionStatus();
    if (permission != GeolocationStatus.granted) {
      print('定位权限异常: ' + permission.toString());
      // 需弹出权限申请
    } else {
      print('定位权限正常');
    }

    // Step2 创建 Geolocator 对象
    Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;

    // Step3 获取最近一次定位坐标
    Position position = await geolocator.getLastKnownPosition();
    updateLocation(position);

    // Step4 订阅位置更新
    LocationOptions options = LocationOptions(
        timeInterval: 10,
        forceAndroidLocationManager: true
    );
    _locationSubscription = geolocator.getPositionStream(options)
      .listen(updateLocation);
  }

  Widget getMap() {
    if (position == null) return null;
    return FlutterMap(
      options: MapOptions(
          center: LatLng(position.latitude, position.longitude),
          zoom: 16
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: historyPositions.map((e) => LatLng(e.latitude, e.longitude)).toList(),
              strokeWidth: 4,
              color: Colors.red
            )
          ]
        ),
        MarkerLayerOptions(
            markers: [
              Marker(
                  width: 20,
                  height: 20,
                  point: LatLng(position.latitude, position.longitude),
                  builder: (ctx) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  )
              )
            ]
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              child: getMap(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Dashboard([
                DashBoardItem("步数", 78431.toString()),
                DashBoardItem("公里", '待开发'),
                DashBoardItem("千卡", '待开发')
              ]),
            )
          ],
        ),
      ),
    );
  }
}

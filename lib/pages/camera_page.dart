// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late StreamSubscription subscription;
  final wsUrl = Uri.parse('ws://192.168.0.1:8888');
  var channel;

  var isDeviceConnected = false;
  var state = false;
  // bool  = false;
  @override
  void initState() {
    super.initState();
    checkWifiInfo();
    connectWebSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: Icon(Icons.flash_on)),
                Expanded(child: SizedBox()),
                Expanded(
                    child: isDeviceConnected
                        ? Icon(Icons.network_wifi_outlined)
                        : Icon(Icons
                            .signal_wifi_connected_no_internet_4_outlined)),
              ],
            ),
          ),
        ),
        Expanded(
          child: isDeviceConnected
              ? state
                  ? Container(
                      color: Colors.grey,
                      child: sensorData(
                        channel: channel,
                      ),
                    )
                  : Container(
                      color: Colors.black, child: sensorData(channel: channel))
              : Container(
                  color: Colors.grey,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: checkWifiInfo, child: Text("Recheck WiFi")),
                  ),
                ),
        ),
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                color: state ? Colors.green : Colors.redAccent,
                height: 50,
                width: 50,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(60, 60),
                      backgroundColor: Colors.white,
                      shape: CircleBorder()),
                  onPressed: () {},
                  child: Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                color: Colors.grey,
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ],
    ));
  }

  StreamBuilder<dynamic> sensorData({required channel}) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Container(
            child: Image.memory(
              snapshot.data,
              gaplessPlayback: true,
              width: screenWidth,
              height: screenHeight,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  final info = NetworkInfo();
  void checkWifiInfo() async {
    String? wifi = await info.getWifiName();
    print(wifi);
    if (wifi == "\"PHARMA\"") {
      setState(() {
        isDeviceConnected = true;
      });
    }
  }

  void connectWebSocket() async {
    channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    print("jayesh");
    // print(channel.stream.listen);
    channel.stream.listen((message) {
      print(message);
      setState(() {
        if (message == "connected") {
          state = true;
        } else {
          state = false;
        }
      });
    });
  }
}

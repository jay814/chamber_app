// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    super.initState();
    checkWifiInfo();
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
          child: Container(
            color: Colors.grey,
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
                color: Colors.grey,
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
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:flutter/cupertino.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
    getConnectvity();
    super.initState();
  }

  getConnectvity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      final info = NetworkInfo();
      info.getWifiName();
      final wifiName = await info.getWifiName();
      print(wifiName);
      if ((wifiName == "redminote8pro") && (isAlertSet == false)) {
        isDeviceConnected = true;
        setState(() {
          isAlertSet = false;
        });
      } else {
        isDeviceConnected = false;
        showDailogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
    @override
    void dispose() {
      subscription.cancel();
      super.dispose();
    }
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
                Expanded(child: Icon(Icons.network_wifi_outlined)),
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

  showDailogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text("Not Connected"),
            content: const Text(
                "Please make sure you ar connected to te portable UV chamber"),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() {
                    isAlertSet = false;
                  });
                  final info = NetworkInfo();
                  info.getWifiName();
                  final wifiName = await info.getWifiName();
                  print(wifiName);
                  if ((wifiName == "redminote8pro") && (isAlertSet == false)) {
                    isDeviceConnected = true;
                    setState(() {
                      isAlertSet = false;
                    });
                  } else {
                    isDeviceConnected = false;
                    showDailogBox();
                    setState(() {
                      isAlertSet = true;
                    });
                  }
                },
                child: const Text("OK"),
              )
            ],
          ));
}

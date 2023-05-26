import 'package:flutter/material.dart';
import 'dart:async';

import 'package:security_device/security_device.dart';

void main() {
  runApp(const MyApp());
}

//SecurityDevice
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isSecurityDevice;
  bool? isJailbreakOrRoot;
  bool? isDeveloperMode;

  @override
  void initState() {
    super.initState();
    getSecurityDeviceInfo();
  }

  Future<void> getSecurityDeviceInfo() async {
    try {
      isSecurityDevice = await SecurityDevice.isSecurityDevice;
      isJailbreakOrRoot = await SecurityDevice.isJailbreakOrRoot;
      isDeveloperMode = await SecurityDevice.isDeveloperMode;
    } catch (error) {
      debugPrint('SecurityDevice catch error:${error.toString()}');
    }

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Security Device Info'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'isSecurityDevice: $isSecurityDevice',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isSecurityDevice == false ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'isJailbreakOrRoot: $isJailbreakOrRoot',
                style: TextStyle(
                  fontSize: 20,
                  color: isJailbreakOrRoot == true ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'isDeveloperMode: $isDeveloperMode',
                style: TextStyle(
                  fontSize: 20,
                  color: isDeveloperMode == true ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

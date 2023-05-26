
import 'package:flutter/services.dart';

class SecurityDevice {

  /// this package's channel
  static const MethodChannel _channel = MethodChannel('security_device');

  /// Quickly confirm that the device is security, just use isSecurityDevice.
  static Future<bool> get isSecurityDevice async {
    bool? isSecurityDevice = await _channel.invokeMethod<bool>('isSecurityDevice');
    return isSecurityDevice ?? true;
  }

  /// check Android is rooted, check iOS is jailbroken(JB)
  static Future<bool> get isJailbreakOrRoot async {
    bool? jailbroken = await _channel.invokeMethod<bool>('isJailbreakOrRoot');
    return jailbroken ?? true;
  }

  /// Android: ADB over USB is enabled, iOS: is Run In Emulator.
  static Future<bool> get isDeveloperMode async {
    bool? developerMode = await _channel.invokeMethod<bool>('isDeveloperMode');
    return developerMode ?? true;
  }

}


import 'package:flutter/services.dart';

class SecurityDevice {

  static const MethodChannel _channel = MethodChannel('security_device');

  static Future<bool> get isSecurityDevice async {
    bool? isSecurityDevice = await _channel.invokeMethod<bool>('isSecurityDevice');
    return isSecurityDevice ?? true;
  }

  static Future<bool> get isJailbreakOrRoot async {
    bool? jailbroken = await _channel.invokeMethod<bool>('isJailbreakOrRoot');
    return jailbroken ?? true;
  }

  static Future<bool> get isDeveloperMode async {
    bool? developerMode = await _channel.invokeMethod<bool>('isDeveloperMode');
    return developerMode ?? true;
  }

}

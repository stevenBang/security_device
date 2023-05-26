import Flutter
import UIKit
import IOSSecuritySuite

public class SwiftSecurityDevicePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "security_device", binaryMessenger: registrar.messenger())
    let instance = SwiftSecurityDevicePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isSecurityDevice":
            let jailbroken = IOSSecuritySuite.amIJailbroken()
            let developerMode = IOSSecuritySuite.amIRunInEmulator();
            result(!(jailbroken || developerMode))
            break
        case "isJailbreakOrRoot":
            let jailbroken = IOSSecuritySuite.amIJailbroken()
            result(jailbroken)
            break
        case "isDeveloperMode":
            let developerMode = IOSSecuritySuite.amIRunInEmulator();
            result(developerMode)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
  }
}

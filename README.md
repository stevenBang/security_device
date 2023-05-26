# Security Device

Utility to check the Device is Security or not.

### isSecurityDevice
Quickly confirm that the device is security, just use isSecurityDevice.

### isJailbreakOrRoot
Android: check is rooted using [RootBeer](https://github.com/scottyab/rootbeer)

iOS: check is jailbroken(JB) using [IOSSecuritySuite](https://github.com/securing/IOSSecuritySuite)

### isDeveloperMode
Android: ADB over USB is enabled.

iOS: is Run In Emulator.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  security_device: ^1.1.0
```


Import it:

```dart
import 'package:security_device/security_device.dart';
```
## Using it

```dart
Future<void> getSecurityDeviceInfo() async {
  try {
    isSecurityDevice = await SecurityDevice.isSecurityDevice;
    isJailbreakOrRoot = await SecurityDevice.isJailbreakOrRoot;
    isDeveloperMode = await SecurityDevice.isDeveloperMode;
  } catch (error) {
    debugPrint('SecurityDevice catch error:${error.toString()}');
  }
}
```
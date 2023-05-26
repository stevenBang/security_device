package com.security.device.security_device

import androidx.annotation.NonNull
import android.content.Context
import android.content.ContentResolver
import android.provider.Settings

import com.scottyab.rootbeer.RootBeer

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SecurityDevicePlugin */
class SecurityDevicePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var context: Context
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "security_device")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("isSecurityDevice")) {
      val isRooted = RootBeer(context).isRooted
      val developerMode = getDebugModeStatus(context.getContentResolver())
      result.success(!(isRooted || developerMode))
    }
    else if (call.method.equals("isJailbreakOrRoot")) {
      val rootBeer = RootBeer(context)
      result.success(rootBeer.isRooted)
    }
    else if (call.method.equals("isDeveloperMode")) {
      val developerMode = getDebugModeStatus(context.getContentResolver())
      result.success(developerMode)
    }
    else {
      result.notImplemented()
    }
  }

  fun getDebugModeStatus(contentResolver: ContentResolver): Boolean {
    return Settings.Global.getInt(contentResolver, Settings.Global.ADB_ENABLED, 0) != 0
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

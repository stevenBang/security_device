package com.security.device.security_device

import android.content.ContentResolver
import android.content.Context
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import com.scottyab.rootbeer.RootBeer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** SecurityDevicePlugin */
class SecurityDevicePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var context: Context
  private lateinit var channel : MethodChannel
  private val ONEPLUS = "oneplus"
  private val MOTO = "moto"
  private val XIAOMI = "xiaomi"
  private val LENOVO = "lenovo"

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "security_device")
    context = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("isSecurityDevice")) {
      val developerMode = getDebugModeStatus(context.contentResolver)
      result.success(!(isRooted() || developerMode))
    }
    else if (call.method.equals("isJailbreakOrRoot")) {
      result.success(isRooted())
    }
    else if (call.method.equals("isDeveloperMode")) {
      val developerMode = getDebugModeStatus(context.contentResolver)
      result.success(developerMode)
    }
    else {
      result.notImplemented()
    }
  }

  private fun isRooted(): Boolean {
    val rootBeer = RootBeer(context)
    val brand = Build.BRAND.lowercase()
    return if(brand.contains(ONEPLUS) || brand.contains(MOTO) || brand.contains(XIAOMI) || brand.contains(LENOVO)) {
      rootBeer.isRootedWithBusyBoxCheck
    } else {
      rootBeer.isRooted
    }
  }

  private fun getDebugModeStatus(contentResolver: ContentResolver): Boolean {
    return Settings.Global.getInt(contentResolver, Settings.Global.ADB_ENABLED, 0) != 0
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

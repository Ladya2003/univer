package com.example.laba6

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.lab6/channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getOrientation" -> {
                    val orientation = getOrientation()
                    if (orientation != null) {
                        result.success(orientation)
                    } else {
                        result.error("Ошибка", "Непонятная ориентация.", null)
                    }
                }
                "openBrowser" -> {
                    val url = call.argument<String>("url")
                    if (url != null) {
                        openBrowser(url)
                        result.success(null)
                    } else {
                        result.error("Ошибка", "URL не указан.", null)
                    }
                }
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("Ошибка", "Не удалось получить уровень заряда батареи.", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getOrientation(): String {
        return when (resources.configuration.orientation) {
            android.content.res.Configuration.ORIENTATION_LANDSCAPE -> "Горизонтальная"
            android.content.res.Configuration.ORIENTATION_PORTRAIT -> "Вертикальная"
            else -> "Unknown"
        }
    }


    private fun openBrowser(url: String) {
        val intent = Intent(Intent.ACTION_VIEW)
        intent.data = Uri.parse(url)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }


    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as android.os.BatteryManager
        return batteryManager.getIntProperty(android.os.BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}

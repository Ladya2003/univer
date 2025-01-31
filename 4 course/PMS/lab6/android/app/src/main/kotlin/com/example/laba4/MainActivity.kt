package com.example.laba4

import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.res.Configuration
import android.net.Uri
import android.os.BatteryManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.lab4/channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getOrientation") {
                val orientation = getOrientation()
                if (orientation != null) {
                    result.success(orientation)
                } else {
                    result.error("Ошибка", "Непонятная какая-то ориентация.", null)
                }
            } else if (call.method == "sendEmail") {
                val subject = call.argument<String>("subject")
                if (subject != null) {
                    sendEmail(subject)
                    result.success(null)
                } else {
                    result.error("Ошбика", "Тема сообщения не указана.", null)
                }
            } else if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("Ошибка", "Не удалось получить уровень заряда батареи.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getOrientation(): String {
        return when (resources.configuration.orientation) {
            Configuration.ORIENTATION_LANDSCAPE -> "Горизонтальная"
            Configuration.ORIENTATION_PORTRAIT -> "Вертикальная"
            else -> "Unknown"
        }
    }

    private fun sendEmail(subject: String) {
        val intent = Intent(Intent.ACTION_SENDTO).apply {
            data = Uri.parse("mailto:")
            putExtra(Intent.EXTRA_SUBJECT, subject)
        }
        if (intent.resolveActivity(packageManager) != null) {
            startActivity(intent)
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }

}
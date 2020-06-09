package com.example.personal_safety

import android.util.Log
import com.example.personal_safety.notification.service.NotificationChannelService
import com.example.personal_safety.utils.VersionChecker
import io.flutter.app.FlutterApplication

class TrackingApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        createChannelIfRequired()

        Log.e("SRI", "Hi there")
    }

    private fun createChannelIfRequired() {
        if (VersionChecker.isGreaterThanOrEqualToOreo()) {
            NotificationChannelService.createChannel(this)
        }
    }
}
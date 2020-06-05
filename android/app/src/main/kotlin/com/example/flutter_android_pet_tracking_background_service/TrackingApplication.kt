package com.example.flutter_android_pet_tracking_background_service

import android.util.Log
import com.example.flutter_android_pet_tracking_background_service.notification.service.NotificationChannelService
import com.example.flutter_android_pet_tracking_background_service.utils.VersionChecker
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class TrackingApplication : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()

        createChannelIfRequired()

        //FirebaseApp.initializeApp(this)

        FlutterFirebaseMessagingService.setPluginRegistrant(this)

        Log.e("SRI", "Hi there")
    }

    override fun registerWith(registry:PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry)
    }

    private fun createChannelIfRequired() {
        if (VersionChecker.isGreaterThanOrEqualToOreo()) {
            NotificationChannelService.createChannel(this)
        }
    }
}
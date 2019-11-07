package com.popupbits.achiver

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.androidalarmmanager.AlarmService
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

class Application: FlutterApplication(), PluginRegistrantCallback {
  override fun onCreate() {
    super.onCreate()
    AlarmService.setPluginRegistrant(this)
  }

  override fun registerWith(registry: PluginRegistry) {
      GeneratedPluginRegistrant.registerWith(registry)
  }
}
package com.shadabunique.flutter.blockz

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
      //Added below line as a workaround  SEE https://github.com/flutter/flutter/issues/14513
      //FlutterMain.startInitialization(this)
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}

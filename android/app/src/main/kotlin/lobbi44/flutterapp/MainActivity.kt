package lobbi44.flutterapp

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import android.Manifest;
import android.content.pm.PackageManager;

import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

const val MY_PERMISSIONS_REQUEST_READ_CONTACTS = 56

class MainActivity(): FlutterActivity() {
  private val CHANNEL = "annagram/filePermissions"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler{call, result ->
      if (call.method == "getFileAccess"){
        getFileAccess();
        result.success(true);
      }
    }
  }

  private fun getFileAccess(){
    // Here, thisActivity is the current activity
    if (ContextCompat.checkSelfPermission(this,
                    Manifest.permission.READ_EXTERNAL_STORAGE)
            != PackageManager.PERMISSION_GRANTED) {

      // Permission is not granted
      // Should we show an explanation?
      if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                      Manifest.permission.READ_EXTERNAL_STORAGE)) {
        // Show an explanation to the user *asynchronously* -- don't block
        // this thread waiting for the user's response! After the user
        // sees the explanation, try again to request the permission.
        print("First if")
      } else {
        // No explanation needed, we can request the permission.
        ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.READ_CONTACTS),
                MY_PERMISSIONS_REQUEST_READ_CONTACTS)

        // MY_PERMISSIONS_REQUEST_READ_CONTACTS is an
        // app-defined int constant. The callback method gets the
        // result of the request.
        print("First else")
      }
    } else {
      print("Already granted")
      // Permission has already been granted
    }
  }
}

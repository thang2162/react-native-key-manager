package com.keymanager

import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise

class KeyManagerModule(reactContext: ReactApplicationContext?) :
  ReactContextBaseJavaModule(reactContext) {
    override fun getName(): String {
      return NAME
    }

  @ReactMethod
  fun SetKey(alias: String, key: String, promise: Promise) = try {
    val context = reactApplicationContext
    val existingKey = SecureStorage().GetKey(alias, context)
    //promise.resolve(can)
    if (alias == "" || alias == null || key == "" || key == null) {
      promise.reject("Error: ", "Alias and Key cannot be blank.")
    } else if (existingKey[1] == "") {
      SecureStorage().SetKey(alias, key, context)
      val map = Arguments.createMap()
      map.putBoolean("success", true)
      map.putString("message", "Key set.")
      promise.resolve(map)
    } else {
      promise.reject("Error: ", "Key already set.")
    }

  } catch (e: Exception) {
    promise.reject(e)
  }

  @ReactMethod
  fun UpdateKey(alias: String, key: String?, promise: Promise) = try {
    val context = reactApplicationContext
    val existingKey = SecureStorage().GetKey(alias, context)
    //promise.resolve(can)
    if (alias == "" || alias == null || key == "" || key == null) {
      promise.reject("Error: ", "Alias and Key cannot be blank.")
    } else if (existingKey[0] != "" && existingKey[1] != "") {
      SecureStorage().SetKey(alias, key, context)
      val map = Arguments.createMap()
      map.putBoolean("success", true)
      map.putString("message", "Key set.")
      promise.resolve(map)
    } else {
      promise.reject("Error: ", "Key not set.")
    }

  } catch (e: Exception) {
    promise.reject(e)
  }

  @ReactMethod
  fun GetKey(alias: String, promise: Promise) = try {
    val context = reactApplicationContext
    val existingKey = SecureStorage().GetKey(alias, context)
    //promise.resolve(can)
    if (existingKey[1] == "") {
      promise.reject("Error: ", "Please set key.")
    } else {
      val map = Arguments.createMap()
      map.putBoolean("success", true)
      map.putString("key", SecureStorage().GetKey(alias, context)[1])
      map.putString("alias", alias)
      promise.resolve(map);
    }

  } catch (e: Exception) {
    promise.reject(e)
  }

  @ReactMethod
  fun DeleteKey(alias: String, promise: Promise) = try {
    val context = reactApplicationContext
    val existingKey = SecureStorage().GetKey(alias, context)
    //promise.resolve(can)
    if (existingKey[0] == "" && existingKey[1] == "") {
      promise.reject("Error: ", "Key not set.")
    } else {
      SecureStorage().DeleteKey(alias, context);
      val map = Arguments.createMap()
      map.putBoolean("success", true)
      map.putString("message", "Key deleted.")
      promise.resolve(map)
    }

  } catch (e: Exception) {
    promise.reject(e)
  }

  companion object {
    const val NAME = "KeyManager"
  }
}
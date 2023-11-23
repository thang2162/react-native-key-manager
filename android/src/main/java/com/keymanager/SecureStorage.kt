package com.keymanager

import android.content.Context
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey


class SecureStorage {

  fun SetKey(alias: String, key: String, context: Context) {
    val masterKeyAlias = MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()

    val sharedPreferences = EncryptedSharedPreferences.create(
            context,
      "SecureStorage",
      masterKeyAlias,
      EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
      EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )

    sharedPreferences.edit()
      .putString(alias, key)
      .apply()

  }

  fun GetKey(alias: String, context: Context): Array<String> {
    val masterKeyAlias = MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()

    val sharedPreferences = EncryptedSharedPreferences.create(
            context,
      "SecureStorage",
      masterKeyAlias,
      EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
      EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )

    val key: String = sharedPreferences.getString(alias, "").toString()

    return arrayOf(alias, key)
  }

  fun DeleteKey(alias: String, context: Context) {
    val masterKeyAlias = MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()

    val sharedPreferences = EncryptedSharedPreferences.create(
            context,
      "SecureStorage",
      masterKeyAlias,
      EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
      EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )

    sharedPreferences.edit()
      .remove(alias)
      .apply()
  }
}
//
//  SecureStorage.swift
//  react-native-key-manager
//
//  Created by Tone T. Thangsongcharoen on 11/22/2023.
//
import Security

class SecureStorage: NSObject {

    func GetAppId () -> String? {
        return "react-native-key-manager:store:\(Bundle.main.bundleIdentifier ?? "")"
    }

    func SetKey(alias: String, key: String) -> Bool? {
        // Set attributes
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: "react-native-key-manager:store:\(Bundle.main.bundleIdentifier ?? "")"  ,
            kSecAttrAccount as String: alias,
            kSecValueData as String: key.data(using: .utf8)!,
        ]

        let status = SecItemAdd(attributes as CFDictionary, nil)

        // Add Key
        if status == noErr {
            return true
        } else {
            print("Operation finished with status: \(status)")
            return false
        }
    }

    func GetKey(alias: String) -> Array<String>? {
        // Set query
        let query: [String: Any] = [
            kSecAttrAccount as String: alias,
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrGeneric as String: "react-native-key-manager:store:\(Bundle.main.bundleIdentifier ?? "")",
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?

        // Check if key exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let keyData = existingItem[kSecValueData as String] as? Data,
               let key = String(data: keyData, encoding: .utf8)
            {
                return [alias, key]
            }
        } else {
            print("Something went wrong trying to find the key in the keychain")
            return ["No Key Found"]
        }
        return []
    }

    func UpdateKey(alias: String, key: String) -> Bool? {
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrGeneric as String: "react-native-key-manager:store:\(Bundle.main.bundleIdentifier ?? "")",
      ]

      // Set attributes for the new password
      let attributes: [String: Any] = [
          kSecAttrAccount as String: alias,
          kSecValueData as String: key.data(using: .utf8)!,
      ]

      // Find key and update
      if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
        return true
      } else {
        return false
      }
    }

    func DeleteKey(alias: String) -> Bool? {
      // Set query
      let query: [String: Any] = [
        kSecAttrAccount as String: alias,
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrGeneric as String: "react-native-key-manager:store:\(Bundle.main.bundleIdentifier ?? "")",
      ]

      // Find key and delete
      if SecItemDelete(query as CFDictionary) == noErr {
        return true
      } else {
        return false
      }
    }

}
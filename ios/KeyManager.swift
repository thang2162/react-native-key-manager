@objc(KeyManager)
class KeyManager: NSObject {

  @objc(SetKey:withKey:withResolver:withRejecter:)
    func SetKey(alias: String? = nil, key: String? = nil, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {

        let data = SecureStorage().GetKey(alias: alias!) ?? []

            if (data.count == 2) {
                reject("Error: ", "Key already set.", nil)
            } else if (data.count <= 1) {
                if (alias != nil && alias != "" && key != nil && key != "") {
                  let saveRes: Bool? = SecureStorage().SetKey(alias: alias ?? "", key: key ?? "");
                  if (saveRes == true) {
                    let formattedData: NSDictionary = [
                        "success" : NSNumber(value: true),
                        "message" :"Key set."
                    ]
                    resolve(formattedData)
                  } else {
                    reject("Error: ", "Error setting Key.", nil)
                  }
                } else {
                  reject("Error: ", "Alias and Key cannot be blank.", nil)
                }
            }
    }

    @objc(UpdateKey:withKey:withResolver:withRejecter:)
    func UpdateKey(alias: String? = nil, key: String? = nil, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {

        let data = SecureStorage().GetKey(alias: alias!) ?? []

            if (data.count == 2) {
              if (alias != nil && alias != "" && key != nil && key != "") {
                let saveRes: Bool? = SecureStorage().UpdateKey(alias: alias ?? "", key: key ?? "");
                if (saveRes == true) {
                  let formattedData: NSDictionary = [
                      "success" : NSNumber(value: true),
                      "message" :"Key updated."
                  ]
                  resolve(formattedData)
                } else {
                  reject("Error: ", "Error updating key.", nil)
                }
              } else {
                reject("Error: ", "Alias and Key cannot be blank.", nil)
              }
            } else if (data.count <= 1) {
              reject("Error: ", "Please set key.", nil)
            }
    }

    @objc(GetKey:withResolver:withRejecter:)
    func GetKey(alias: String? = nil, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        let data = SecureStorage().GetKey(alias: alias!) ?? []

      if (data.count == 2) {
          let formattedData: NSDictionary = [
              "success" : NSNumber(value: true),
              "alias" : data[0],
              "key" : data[1]
          ]
          resolve(formattedData)
      } else {
        reject("Error: ", "Please set key.", nil)
      }
    }

    @objc(DeleteKey:withResolver:withRejecter:)
    func DeleteKey(alias: String? = nil, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        let data = SecureStorage().GetKey(alias: alias!) ?? []

      if (data.count == 2) {
          let saveRes: Bool? = SecureStorage().DeleteKey(alias: alias!);
        if (saveRes == true) {
          let formattedData: NSDictionary = [
              "success" : NSNumber(value: true),
              "message" :"Key deleted."
          ]
          resolve(formattedData)
        } else {
          reject("Error: ", "Error deleting key.", nil)
        }
      } else {
        reject("Error: ", "Please set key.", nil)
      }
    }
}

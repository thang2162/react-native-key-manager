import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-key-manager' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const KeyManager = NativeModules.KeyManager
  ? NativeModules.KeyManager
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function SetKey(alias: string, key: string): Promise<any> {
  return KeyManager.SetKey(alias, key);
}

export function UpdateKey(alias: string, key: string): Promise<any> {
  return KeyManager.UpdateKey(alias, key);
}

export function GetKey(alias: string): Promise<any> {
  return KeyManager.GetKey(alias);
}

export function DeleteKey(alias: string): Promise<any> {
  return KeyManager.DeleteKey(alias);
}

export function GenerateKey(length: number = 8) {
  let pass = '';
  let str =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' + 'abcdefghijklmnopqrstuvwxyz0123456789@#$';

  for (let i = 1; i <= length; i++) {
    let char = Math.floor(Math.random() * str.length + 1);

    pass += str.charAt(char);
  }

  return pass;
}

export async function CreateOrGetKey(alias: string, length: number = 32) {
  try {
    const Key = await KeyManager.GetKey(alias);
    return Key;
  } catch (e) {
    console.log(e);
    await KeyManager.SetKey(alias, GenerateKey(length));
    const Key = await KeyManager.GetKey(alias);
    return Key;
  }
}
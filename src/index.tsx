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

export type KeyManagerRepsonseType = {
  success: boolean;
  alias?: string;
  key?: string;
  message?: string;
};

const defaultCharSet =
  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@#$';

export function SetKey(
  alias: string,
  key: string
): Promise<KeyManagerRepsonseType> {
  return KeyManager.SetKey(alias, key);
}

export function UpdateKey(
  alias: string,
  key: string
): Promise<KeyManagerRepsonseType> {
  return KeyManager.UpdateKey(alias, key);
}

export function GetKey(alias: string): Promise<KeyManagerRepsonseType> {
  return KeyManager.GetKey(alias);
}

export function DeleteKey(alias: string): Promise<KeyManagerRepsonseType> {
  return KeyManager.DeleteKey(alias);
}

export function GenerateKey(length?: number, characterSet?: string) {
  let pass = '';
  let str = characterSet ?? defaultCharSet;
  const len = length ?? 8;

  for (let i = 1; i <= len; i++) {
    let char = Math.floor(Math.random() * str.length + 1);

    pass += str.charAt(char);
  }

  return pass;
}

export async function CreateOrGetKey(
  alias: string,
  length?: number,
  characterSet?: string
): Promise<KeyManagerRepsonseType> {
  try {
    const Key: KeyManagerRepsonseType = await KeyManager.GetKey(alias);
    return Key;
  } catch (e) {
    console.log(e);
    await KeyManager.SetKey(
      alias,
      GenerateKey(length ?? 32, characterSet ?? defaultCharSet)
    );
    const Key: KeyManagerRepsonseType = await KeyManager.GetKey(alias);
    return Key;
  }
}

# react-native-key-mamager

A package for securely generating and mananging keys in React-Native.

## Installation

```sh
npm install react-native-key-manager --save

cd ios && pod install && cd ..
```

or

```sh
yarn add react-native-key-manager

cd ios && pod install && cd ..
```

## Usage

```js
import {
  CreateOrGetKey,
  GenerateKey,
  GetKey,
  DeleteKey,
  UpdateKey,
  SetKey,
} from 'react-native-key-manager';

// ...

const result = await GenerateKey();
```

## API

1. SetKey(alias: string, key: string) - Save the key.
   Returns: Promise that resolves with object {success: true, message: response_text} if success or rejects with message if fail.

2. UpdateUser(alias: string, key: string) - Update the key.
   Returns: Promise that resolves with object {success: true, message: response_text} if success or rejects with message if fail.

3. GetKey(alias: string) - Gets the key.
   Returns: Promise that resolves with object {success: true, alias: "alias", key: "key"} if success or rejects with message if fail.

4. DeleteUser(alias: string) - Deletes the alias.
   Returns: Promise that resolves with object {success: true, message: response_text} if success or rejects with message if fail.

5. CreateOrGetKey(alias: string, length: number (Optional)) - Creates or Rertives a Key.
   Returns: Promise that resolves with object {success: true, alias: "alias", key: "key"} if success or rejects with message if fail.

6. GenerateKey(length: number (Optional)) - Creates a Key.
   Returns: String of a random key of desired length.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

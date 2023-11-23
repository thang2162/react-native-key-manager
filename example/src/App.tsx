import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { CreateOrGetKey } from 'react-native-key-manager';

export default function App() {
  const [key, setKey] = React.useState<string | undefined>();

  React.useEffect(() => {
    CreateOrGetKey('testKey').then((res) => {
      setKey(res.key);
    });
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {key}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});

import React, { useState } from "react";
import {
  Image,
  NativeModules,
  Platform,
  SafeAreaView,
  StyleSheet,
  Text,
  TextInput,
  View
} from "react-native";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";
import AwesomeButton from "react-native-really-awesome-button";
import { RootSiblingParent } from "react-native-root-siblings";
import Toast from "react-native-root-toast";
import SharedGroupPreferences from "react-native-shared-group-preferences";
import WidgetBridge from "react-native-widget-bridge";

const group = "group.dev.imam.rnwidget.streak";

const SharedStorage = NativeModules.SharedStorage;

const App = () => {
  const [text, setText] = useState("");
  const widgetData = {
    text: `${text} days`
  };

  const handleSubmit = async () => {
    if (Platform.OS === "ios") {
      try {
        // iOS
        await SharedGroupPreferences.setItem("widgetKey", widgetData, group);
        await WidgetBridge.reloadWidget("StreakWidget");
      } catch (error) {
        console.log({ error });
      }
    } else if (Platform.OS === "android") {
      const value = `${text} days`;
      // Android
      SharedStorage?.set(JSON.stringify({ text: value }));
      // ToastAndroid?.show("Change value successfully!", ToastAndroid.SHORT);
    }

    // Add a Toast on screen.
    Toast.show("Change value successfully!", {
      duration: Toast.durations.SHORT,
      position: Toast.positions.BOTTOM,
      shadow: true,
      animation: true,
      hideOnPress: true,
      delay: 0,
      onShow: () => {
        // calls on toast\`s appear animation start
      },
      onShown: () => {
        // calls on toast\`s appear animation end.
      },
      onHide: () => {
        // calls on toast\`s hide animation start.
      },
      onHidden: () => {
        // calls on toast\`s hide animation end.
      }
    });
  };

  return (
    <RootSiblingParent>
      <SafeAreaView style={styles.safeAreaContainer}>
        <KeyboardAwareScrollView
          enableOnAndroid
          extraScrollHeight={100}
          keyboardShouldPersistTaps="handled"
        >
          <View style={styles.container}>
            <Text style={styles.heading}>Change Widget Value</Text>
            <View style={styles.bodyContainer}>
              <View style={styles.instructionContainer}>
                <View style={styles.thoughtContainer}>
                  <Text style={styles.thoughtTitle}>
                    Enter the value that you want to display on your home widget
                  </Text>
                </View>
                <View style={styles.thoughtPointer}></View>
                <Image
                  source={require("./assets/bea.png")}
                  style={styles.avatarImg}
                />
              </View>

              <TextInput
                style={styles.input}
                onChangeText={(newText) => setText(newText)}
                value={text}
                keyboardType="decimal-pad"
                placeholder="Enter the text to display..."
              />

              <AwesomeButton
                backgroundColor={"#33b8f6"}
                height={50}
                // @ts-expect-error - should allow string
                width={"100%"}
                backgroundDarker={"#eeefef"}
                backgroundShadow={"#f1f1f0"}
                style={styles.actionButton}
                onPress={handleSubmit}
              >
                Submit
              </AwesomeButton>
            </View>
          </View>
        </KeyboardAwareScrollView>
      </SafeAreaView>
    </RootSiblingParent>
  );
};

export default App;

const styles = StyleSheet.create({
  safeAreaContainer: {
    flex: 1,
    width: "100%",
    backgroundColor: "#fafaf3"
  },
  container: {
    flex: 1,
    width: "100%",
    padding: 12
  },
  heading: {
    fontSize: 24,
    color: "#979995",
    textAlign: "center"
  },
  input: {
    width: "100%",
    // fontSize: 20,
    minHeight: 50,
    borderWidth: 1,
    borderColor: "#c6c6c6",
    borderRadius: 8,
    padding: 12
  },
  bodyContainer: {
    flex: 1,
    margin: 18
  },
  instructionContainer: {
    margin: 25,
    paddingHorizontal: 20,
    paddingTop: 30,
    borderWidth: 1,
    borderRadius: 12,
    backgroundColor: "#ecedeb",
    borderColor: "#bebfbd",
    marginBottom: 35
  },
  avatarImg: {
    height: 180,
    width: 180,
    resizeMode: "contain",
    alignSelf: "flex-end"
  },
  thoughtContainer: {
    minHeight: 50,
    borderRadius: 12,
    borderWidth: 1,
    padding: 12,
    backgroundColor: "#ffffff",
    borderColor: "#c6c6c6"
  },
  thoughtPointer: {
    width: 0,
    height: 0,
    borderStyle: "solid",
    overflow: "hidden",
    borderTopWidth: 12,
    borderRightWidth: 10,
    borderBottomWidth: 0,
    borderLeftWidth: 10,
    borderTopColor: "blue",
    borderRightColor: "transparent",
    borderBottomColor: "transparent",
    borderLeftColor: "transparent",
    marginTop: -1,
    marginLeft: "50%"
  },
  thoughtTitle: {
    fontSize: 14
  },
  actionButton: {
    marginTop: 40
  }
});

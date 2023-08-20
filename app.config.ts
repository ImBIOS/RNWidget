import { type ConfigContext, type ExpoConfig } from "expo/config";
import { type PluginConfigType } from "expo-build-properties/build/pluginConfig";

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: "React Native Widget",
  slug: "RNWidget",
  version: "0.1.0",
  orientation: "portrait",
  icon: "./assets/icon.png",
  userInterfaceStyle: "light",
  splash: {
    image: "./assets/splash.png",
    resizeMode: "contain",
    backgroundColor: "#ffffff"
  },
  assetBundlePatterns: ["**/*"],
  ios: {
    supportsTablet: true,
    bundleIdentifier: "dev.imam.rnwidget"
  },
  android: {
    adaptiveIcon: {
      foregroundImage: "./assets/adaptive-icon.png",
      backgroundColor: "#ffffff"
    },
    package: "dev.imam.rnwidget"
  },
  web: {
    favicon: "./assets/favicon.png"
  },
  plugins: [
    [
      "expo-build-properties",
      {
        android: {
          compileSdkVersion: 33,
          targetSdkVersion: 33,
          buildToolsVersion: "33.0.0"
        },
        ios: {
          deploymentTarget: "13.0"
        }
      } satisfies PluginConfigType
    ]
  ]
});

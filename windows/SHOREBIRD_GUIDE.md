# Shorebird Usage Guide

Shorebird allows you to build your app and instantly push updates over the air without going through the App Store or Google Play Store. Here is how to use it for iOS and Android.

## Building a Release (First Time to the Store)

When you are ready to put your app on the App Store or Google Play Store, you **must build it using Shorebird** so it includes the Shorebird engine.

### Android
To build an Android App Bundle (AAB) for the Play Store:
```bash
shorebird release android
```
*This command is currently running in the background to verify your setup.*

### iOS
To build an iOS release (an `.xcarchive` or `.ipa`) for the App Store:
```bash
shorebird release ios
```
*Note: iOS requires a Mac and properly configured code signing in Xcode.*

## Pushing an Update (Over the Air)

Once users have downloaded your Shorebird release from the store, you can push instant updates to them.

1. Make your code changes in Dart.
2. Run the patch command for the platform you want to update.

By default, running `shorebird patch <platform>` will patch the *most recently created release* for that platform. 

### Why you should explicitly use `--release-version`

It's a best practice to specify **exactly which version** you are patching. 

Let's say you have version `1.0.8+12` live on the store, and you just started working on version `1.0.9+13` which is partially complete. If you encounter a bug in `1.0.8+12` that you need to hot-fix urgently, you only want to send the patch to users on `1.0.8+12`.

If your `pubspec.yaml` currently says `1.0.9+13`, but you want to fix `1.0.8+12`, you can use:

### Android
```bash
shorebird patch android --release-version 1.0.8+12
```

### iOS
```bash
shorebird patch ios --release-version 1.0.8+12
```

Shorebird will analyze your changes, generate a patch, and instantly deploy it. The next time users open the app, it will download the patch in the background and apply it on the next launch.

> [!NOTE]
> Shorebird patches can only contain code changes (Dart code). If you add new native plugins, change native Java/Swift code, or change assets, you must create a new full `release` and submit it to the stores.

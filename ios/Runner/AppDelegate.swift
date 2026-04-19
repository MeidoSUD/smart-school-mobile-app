import Flutter
import UIKit
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Do NOT call FirebaseApp.configure() here when Firebase is initialized
    // from Dart via Firebase.initializeApp(...). Calling both can cause
    // double-initialization crashes in Firebase native SDKs.
    // GeneratedPluginRegistrant will still register plugins below.
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

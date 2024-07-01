import Flutter
import UIKit

public class FlutterAccessorysetupPlugin: NSObject, FlutterPlugin {
  static let sharedStream = FlutterAccessorysetupStream()
  let setupSession: AccessorysetupSession

  override init() {
      setupSession = AccessorysetupSession(sink: { Self.sharedStream.send(event: $0) })
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(
      name: "com.withintent.flutter.package.flutter_accessorysetup.methods",
      binaryMessenger: registrar.messenger()
    )
    let pluginInstance = FlutterAccessorysetupPlugin()
    registrar.addMethodCallDelegate(pluginInstance, channel: methodChannel)

    let eventChannel = FlutterEventChannel(
      name: "com.withintent.flutter.package.flutter_accessorysetup.events",
      binaryMessenger: registrar.messenger()
    )
    
    eventChannel.setStreamHandler(sharedStream)

    // for the debug purposes
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { 
      sharedStream.send(event: "Hello from Swift!")
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "activate":
      setupSession.activate()
      result(nil)
    case "showPicker":
      setupSession.showPicker()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

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
        case "showBlePicker":
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "No Arguments", details: nil))
                return
            }
            guard let name = args["name"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "name should be provided", details: nil))
                return
            }
            guard let asset = args["asset"] as? String,
                  let image = loadImage(asset: asset) else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "image asset should be provided", details: nil))
                return
            }
            let serviceUUID = args["serviceUUID"] as? String
            let nameSubstring = args["nameSubstring"] as? String
            guard serviceUUID != nil || nameSubstring != nil else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "serviceUUID or nameSubstring should be provided", details: nil))
                return
            }
            setupSession.showBlePicker(
                name: name,
                image: image,
                serviceUUID: serviceUUID?.uppercased(),
                nameSubstring: nameSubstring
            )
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func loadImage(asset: String) -> UIImage? {
        let assetPath = Bundle.main.path(
            forResource: FlutterDartProject.lookupKey(forAsset: asset),
            ofType: nil
        )
        guard let path = assetPath else { return nil }
        return UIImage(contentsOfFile: path)
    }
}

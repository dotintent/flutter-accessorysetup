import AccessorySetupKit
import CoreBluetooth

class AccessorysetupSession {
    typealias Sink = (Any?) -> Void
    private let session = ASAccessorySession()
    private let sink: Sink

    private static let duckDevice: ASPickerDisplayItem = {
        let descriptor = ASDiscoveryDescriptor()
        descriptor.bluetoothServiceUUID = CBUUID(string: "149e9e42-33ad-41ad-8665-70d153533ec1")
        //            descriptor.bluetoothNameSubstring = "KITCHENSINK"

        return ASPickerDisplayItem(
            name: "My Duck",
            productImage: UIImage(systemName: "moon.dust")!,
            descriptor: descriptor
        )
    }()

    init(sink: @escaping Sink) {
        self.sink = sink
    }

    func activate() {
        session.activate(on: .main, eventHandler: handle(event:))
    }

    func showPicker() {
        session.showPicker(for: [Self.duckDevice]) { error in
            if let error {
                self.sink("showPicker failed: \(error)")
            }
        }
    }

    func handle(event: ASAccessoryEvent) {
        print("got ASAccessorySession event: \(event.eventType) ")
        switch event.eventType {
        case .accessoryAdded: break
        case .accessoryChanged:
            sink("accessoryChanged")
            print("changed: \(String(describing: event.accessory)) \(String(describing: event.error))")
        case .accessoryRemoved: break
        case .activated:
            print("activated \(session.accessories)")
            sink("activated")
        case .invalidated:
            sink("invalidated")
        case .migrationComplete: break
        case .pickerDidDismiss: break
        case .pickerDidPresent:
            sink("pickerDidPresent")
        case .unknown: break
        @unknown default:
            print("got unknown default type event: \(event.eventType) ")
        }
    }
}


#if DEBUG

extension ASAccessoryEventType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .accessoryAdded: "accessoryAdded"
        case .accessoryChanged: "accessoryChanged"
        case .accessoryRemoved: "accessoryRemoved"
        case .activated: "activated"
        case .invalidated: "invalidated"
        case .migrationComplete: "migrationComplete"
        case .pickerDidDismiss: "pickerDidDismiss"
        case .pickerDidPresent: "pickerDidPresent"
        case .unknown: "unknown"
        @unknown default:
            "unknown default"
        }
    }
}

#endif

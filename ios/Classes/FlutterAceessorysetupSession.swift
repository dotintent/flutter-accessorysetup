import AccessorySetupKit
import CoreBluetooth

class AccessorysetupSession {
    typealias Sink = (Any?) -> Void
    private let session = ASAccessorySession()
    private let sink: Sink

    init(sink: @escaping Sink) {
        self.sink = sink
    }

    func activate() {
        session.activate(on: .main, eventHandler: handle(event:))
    }

    func showBlePicker(
        name: String,
        image: UIImage,
        serviceUUID: String?,
        nameSubstring: String?
    ) {
        let descriptor = ASDiscoveryDescriptor()
        if let serviceUUID {
            descriptor.bluetoothServiceUUID = CBUUID(string: serviceUUID)
        }
        if let nameSubstring {
            descriptor.bluetoothNameSubstring = nameSubstring
        }
        let item = ASPickerDisplayItem(
            name: name,
            productImage: image,
            descriptor: descriptor
        )
        session.showPicker(for: [item]) { error in
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

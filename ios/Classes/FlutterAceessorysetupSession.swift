import AccessorySetupKit
import CoreBluetooth

class AccessorysetupSession {
    typealias Sink = (_ json: String) -> Void
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
        session.showPicker(for: [item]) { [weak self] error in
            if let error {
                self?.send(error: error, description: "failed to show picker")
            }
        }
    }

    func handle(event: ASAccessoryEvent) {
        var accessories = [ASAccessory]()

        switch event.eventType {
        case .accessoryAdded, .accessoryChanged, .accessoryRemoved, .migrationComplete:
            if let accessory = event.accessory {
                accessories.append(accessory)
            }
        case .activated:
            accessories.append(contentsOf: session.accessories)
        case .invalidated, .pickerDidDismiss, .pickerDidPresent, .unknown: break
        @unknown default:
            send(
                error: AccessorysetupCodeError.gotUnknownDefaultCase,
                description: "got unknown default type of the event: \(event.eventType)"
            )
        }
        let event = AccessorysetupEvent(
            eventType: event.eventType,
            accessories: accessories.map { AccessorysetupAccessory($0) }
        )
        do {
            let eventJson = try JSONEncoder().encode(event)
            sink(try eventJson.jsonString())
        } catch {
            send(error: error, description: "failed to encode event \(event.type)")
        }
    }

    private func send(error: Error, description: String) {
        do {
            let errorJson = try JSONEncoder().encode(
                AccessorysetupError(error, description: description)
            )
            sink(try errorJson.jsonString())
        } catch {
            // crash debug build here
            assert(false)
        }
    }
}

enum AccessorysetupCodeError: Error {
    case gotUnknownDefaultCase
    case failedStringConversion
}

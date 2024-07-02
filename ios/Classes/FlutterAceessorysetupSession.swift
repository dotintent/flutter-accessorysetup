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
        print("got ASAccessorySession event: \(event.eventType.jsonString) ")
        var accessories = [ASAccessory]()

        switch event.eventType {
        case .accessoryAdded, .accessoryChanged, .accessoryRemoved, .migrationComplete:
            if let accessory = event.accessory {
                accessories.append(accessory)
            }
        case .activated:
            accessories.append(contentsOf: session.accessories)
        case .invalidated, .pickerDidDismiss, .pickerDidPresent, .unknown: send(error: AccessorysetupCodeError.failedStringConversion, description: "failed string")
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
            print("failed to send error: \(description), \(error)")
            // crash debug build here
            assert(false)
        }
    }
}

enum AccessorysetupCodeError: Error {
    case gotUnknownDefaultCase
    case failedStringConversion
}

struct AccessorysetupError: Encodable {
    let a = "ERROR" // Make an Easy to read JSON
    let error: String
    let description: String

    init(_ error: Error, description: String) {
        self.error = "\(error)"
        self.description = description
    }
}

struct AccessorysetupEvent: Encodable {
    let a = "EVENT" // Make an Easy to read JSON 
    let type: String
    let accessories: [AccessorysetupAccessory]

    init(eventType: ASAccessoryEventType, accessories: [AccessorysetupAccessory]) {
        type = eventType.jsonString
        self.accessories = accessories
    }
}

struct AccessorysetupAccessory: Encodable {
    enum State: String, Encodable {
        case unauthorized
        case awaitingAuthorization
        case authorized
        case unknown

        init(accessoryState: ASAccessory.AccessoryState) {
            switch accessoryState {
            case .authorized: self = .authorized
            case .awaitingAuthorization: self = .awaitingAuthorization
            case .unauthorized: self = .unauthorized
            @unknown default:
                print("got unsupported case \(accessoryState)")
                // crash debug build here
                assert(false)
                self = .unknown
            }
        }
    }

    let displayName: String
    let state: State
    let bluetoothIdentifier: UUID?
    let ssid: String?

    init(_ accessory: ASAccessory) {
        displayName = accessory.displayName
        state = State(accessoryState: accessory.state)
        bluetoothIdentifier = accessory.bluetoothIdentifier
        ssid = accessory.ssid
    }
}

extension Data {
    func jsonString() throws -> String {
        guard let string = String(data: self, encoding: .utf8) else {
            throw AccessorysetupCodeError.failedStringConversion
        }
        return string
    }
}

extension ASAccessoryEventType {
    public var jsonString: String {
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

import AccessorySetupKit

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

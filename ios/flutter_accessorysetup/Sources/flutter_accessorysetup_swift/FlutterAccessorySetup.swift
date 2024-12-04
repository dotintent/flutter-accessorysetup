import AccessorySetupKit
//import os

/// Copy of the ASAccessorySession, with interfaces improved for Dart FFI import
@objc(FFIAccessorySession)
public final class FFIAccessorySession: NSObject {

    private let session = ASAccessorySession()
    private var delegate: FFIAccessorySessionDelegate?
    private var myLogs: [String] = []

    override public init() {
        super.init()
    }

    @objc(logs)
    public var logs: [String] {
        return myLogs
    }

    @objc(accessories)
    public var accessories: [ASAccessory] {
        myLogs.append("get accessories")
        return session.accessories
    }

    @objc(setDelegate:)
    public func set(delegate: FFIAccessorySessionDelegate) {
        myLogs.append("set delegate")
        self.delegate = delegate
    }

    @objc(activate)
    public func activate() {
        session.activate(on: .main) { [weak self] event in
            self?.myLogs.append("received event \(event), error: \(String(describing: event.error))")
            self?.delegate?.handle(event: event)
        }
    }

    @objc(invalidate)
    public func invalidate() {
        session.invalidate()
    }

    @objc(showPicker)
    public func showPicker() {
        session.showPicker { [weak self] error in
            self?.delegate?.didShowPicker(error: error)
        }
    }

    @objc(showPickerForItems:)
    public func showPicker(for items: [ASPickerDisplayItem]) {
        session.showPicker(for: items) { [weak self] error in
            self?.delegate?.didShowPicker(error: error)
        }
    }

    @objc(renameAccessory:options:)
    public func renameAccessory(
        _ accessory: ASAccessory,
        options: ASAccessory.RenameOptions
    ) {
        session.renameAccessory(accessory, options: options) { [weak self] error in
            self?.delegate?.didRenameAccessory(accessory: accessory, error: error)
        }
    }

    @objc(removeAccessory:)
    public func removeAccessory(_ accessory: ASAccessory) {
        session.removeAccessory(accessory) { [weak self] error in
            self?.delegate?.didRemoveAccessory(accessory: accessory, error: error)
        }
    }

    @objc(finishAuthorizationForAccessory:settings:)
    public func finishAuthorization(
        for accessory: ASAccessory,
        settings: ASAccessorySettings
    ) {
        session.finishAuthorization(for: accessory, settings: settings) { [weak self] error in
            self?.delegate?.didFinishAuthorization(accessory: accessory, error: error)
        }
    }

    @objc(failAuthorizationForAccessory:)
    public func failAuthorization(for accessory: ASAccessory) {
        session.failAuthorization(for: accessory) { [weak self] error in
            self?.delegate?.didFailAuthorization(accessory: accessory, error: error)
        }
    }
}

@objc(FFIAccessorySessionDelegate)
public protocol FFIAccessorySessionDelegate {

    @objc(handleEvent:)
    func handle(event: ASAccessoryEvent)

    @objc(didShowPickerWithError:)
    func didShowPicker(error: (any Error)?)

    @objc(didRenameAccessory:withError:)
    func didRenameAccessory(accessory: ASAccessory, error: (any Error)?)

    @objc(didRemoveAccessory:withError:)
    func didRemoveAccessory(accessory: ASAccessory, error: (any Error)?)

    @objc(didFinishAuthorizationForAccessory:withError:)
    func didFinishAuthorization(accessory: ASAccessory, error: (any Error)?)

    @objc(didFailAuthorizationForAccessory:withError:)
    func didFailAuthorization(accessory: ASAccessory, error: (any Error)?)
}

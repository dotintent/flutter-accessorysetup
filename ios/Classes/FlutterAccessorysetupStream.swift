import Flutter

public class FlutterAccessorysetupStream: NSObject, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }

  public func send(json: String) {
    eventSink?(json)
  }
}

enum AccessoryState {
  unauthorized('unauthorized'),
  awaitingAuthorization('awaitingAuthorization'),
  authorized('authorized'),
  unknown('unknown');

  final String value;

  const AccessoryState(this.value);
}

class Accessory {
  final String displayName;
  final AccessoryState state;
  final String? bluetoothIdentifier;
  final String? ssid;

  const Accessory({
      required this.displayName,
      required this.state,
      this.bluetoothIdentifier,
      this.ssid
  });

  factory Accessory.fromJson(Map<String, dynamic> json) => Accessory(
      displayName: json['displayName'],
      state: AccessoryState.values.firstWhere((state) => json['state'] == state.value, orElse: () => AccessoryState.unknown),
      bluetoothIdentifier: json['bluetoothIdentifier'],
      ssid: json['ssid'],
    );

  @override
  String toString() {
    return 'Accessory{name: $displayName, state: $state, uuid: $bluetoothIdentifier, ssid: $ssid}';
  }
}

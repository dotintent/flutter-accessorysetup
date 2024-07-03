import 'package:flutter_accessorysetup/flutter_accessorysetup_accessory.dart';

abstract class FlutterAccessorysetupSessionEvent {}

class FlutterAccessorysetupEvent implements FlutterAccessorysetupSessionEvent {
  final AccessoryEventType type;
  final List<Accessory> accessories;

  FlutterAccessorysetupEvent({required this.type, required this.accessories});

  factory FlutterAccessorysetupEvent.fromJson(Map<String, dynamic> json) => FlutterAccessorysetupEvent(
      type: AccessoryEventType.values.firstWhere((type) => json['type'] == type.value, orElse: () => AccessoryEventType.unknown),
      accessories: (json['accessories'] as List).map((item) => Accessory.fromJson(item)).toList(),
    );

  @override
  String toString() {
    return 'FlutterAccessorysetupEvent{type: $type, accessories: $accessories}';
  }
}

enum AccessoryEventType {
  accessoryAdded('accessoryAdded'),
  accessoryChanged('accessoryChanged'),
  accessoryRemoved('accessoryRemoved'),
  activated('activated'),
  invalidated('invalidated'),
  migrationComplete('migrationComplete'),
  pickerDidDismiss('pickerDidDismiss'),
  pickerDidPresent('pickerDidPresent'),
  unknown('unknown');

  final String value;

  const AccessoryEventType(this.value);
}

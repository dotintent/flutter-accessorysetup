import 'package:flutter_accessorysetup/flutter_accessorysetup_event.dart';

class FlutterAccessorysetupError implements FlutterAccessorysetupSessionEvent {
  final String error;
  final String description;

  FlutterAccessorysetupError({required this.error, required this.description});

  factory FlutterAccessorysetupError.fromJson(Map<String, dynamic> json) =>
      FlutterAccessorysetupError(
        error: json['error'],
        description: json['description'],
      );

  @override
  String toString() {
    return 'FlutterAccessorysetupError{description: $description, error: $error}';
  }
}

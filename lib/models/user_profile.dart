import 'package:flutter/material.dart';

enum BloodType { a, b, ab, o }

extension BloodTypeExtension on BloodType {
  String get displayName {
    switch (this) {
      case BloodType.a:
        return 'Type A (Sensible & Methodical)';
      case BloodType.b:
        return 'Type B (Passionate & Independent)';
      case BloodType.ab:
        return 'Type AB (Rational & Dualistic)';
      case BloodType.o:
        return 'Type O (Ambitious & Confident)';
    }
  }

  String get shortName {
    switch (this) {
      case BloodType.a:
        return 'A';
      case BloodType.b:
        return 'B';
      case BloodType.ab:
        return 'AB';
      case BloodType.o:
        return 'O';
    }
  }

  static BloodType fromString(String? value) {
    if (value == null) return BloodType.o;
    switch (value.toUpperCase()) {
      case 'A':
        return BloodType.a;
      case 'B':
        return BloodType.b;
      case 'AB':
        return BloodType.ab;
      case 'O':
      default:
        return BloodType.o;
    }
  }
}

class UserProfile {
  final String name;
  final DateTime birthDate;
  final TimeOfDay birthTime;
  final BloodType bloodType;
  final String cityName;
  final double timezoneOffsetHours;
  final String gender;

  const UserProfile({
    required this.name,
    required this.birthDate,
    required this.birthTime,
    required this.bloodType,
    this.cityName = 'Tokyo, Japan',
    this.timezoneOffsetHours = 9.0,
    this.gender = 'Non-specified',
  });

  UserProfile copyWith({
    String? name,
    DateTime? birthDate,
    TimeOfDay? birthTime,
    BloodType? bloodType,
    String? cityName,
    double? timezoneOffsetHours,
    String? gender,
  }) {
    return UserProfile(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      bloodType: bloodType ?? this.bloodType,
      cityName: cityName ?? this.cityName,
      timezoneOffsetHours: timezoneOffsetHours ?? this.timezoneOffsetHours,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthDate': birthDate.toIso8601String(),
      'birthHour': birthTime.hour,
      'birthMinute': birthTime.minute,
      'bloodType': bloodType.shortName,
      'cityName': cityName,
      'timezoneOffsetHours': timezoneOffsetHours,
      'gender': gender,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String? ?? 'Seeker',
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : DateTime(2000, 1, 1),
      birthTime: TimeOfDay(
        hour: json['birthHour'] as int? ?? 12,
        minute: json['birthMinute'] as int? ?? 0,
      ),
      bloodType: BloodTypeExtension.fromString(json['bloodType'] as String?),
      cityName: json['cityName'] as String? ?? 'Tokyo, Japan',
      timezoneOffsetHours: (json['timezoneOffsetHours'] as num?)?.toDouble() ?? 9.0,
      gender: json['gender'] as String? ?? 'Non-specified',
    );
  }
}

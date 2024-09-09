import 'dart:convert'; // For JSON encoding/decoding

class User {
  int? id;
  String? username;
  String? email;
  String? password;
  String? gender;
  String? weight;
  String? waterGoalPercentage; // daily goal (value+unit) for example : 2000 ml
  int? currentWaterPercentage;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.gender,
    this.weight,
    this.waterGoalPercentage,
    this.currentWaterPercentage
  });

  // Convert a User object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'gender': gender,
      'weight': weight,
      'waterGoalPercentage': waterGoalPercentage,
      'currentWaterPercentage': currentWaterPercentage
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      gender: map['gender'],
      weight: map['weight'],
      waterGoalPercentage: map['waterGoalPercentage'],
      currentWaterPercentage: map['currentWaterPercentage']
    );
  }

  // Convert User object to JSON
  String toJson() => json.encode(toMap());

  // Create User object from JSON
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

}
import 'dart:convert'; // For JSON encoding/decoding


class Accomplishement{
  int? userid;
  String? percentageDate;
  int? percentageWaterValue;

  Accomplishement({
    this.userid,
    this.percentageDate,
    this.percentageWaterValue
  });

  // Convert an Accomplishement object to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'userId': userid,
      'percentageDate': percentageDate,
      'percentageWaterValue': percentageWaterValue
    };
  }

  // Create a Accomplishement object from a Map
  factory Accomplishement.fromMap(Map<String, dynamic> map) {
    return Accomplishement(
      userid: map['id'],
      percentageDate: map['percentageDate'],
      percentageWaterValue: map['percentageWaterValue']
    );
  }

  // Convert User object to JSON
  String toJson() => json.encode(toMap());

  // Create User object from JSON
  factory Accomplishement.fromJson(String source) => Accomplishement.fromMap(json.decode(source));
  
}
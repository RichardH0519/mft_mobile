// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerFeedback _$CustomerFeedbackFromJson(Map<String, dynamic> json) {
  return CustomerFeedback(
    customerUsername: json['customerUsername'] as String,
    farmerUsername: json['farmerUsername'] as String,
    feedback: json['feedback'] as String,
  );
}

Map<String, dynamic> _$CustomerFeedbackToJson(CustomerFeedback instance) =>
    <String, dynamic>{
      'customerUsername': instance.customerUsername,
      'farmerUsername': instance.farmerUsername,
      'feedback': instance.feedback,
    };

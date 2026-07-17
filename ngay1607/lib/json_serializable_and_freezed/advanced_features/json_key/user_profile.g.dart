// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: (json['usr_id'] as num).toInt(),
      fullName: json['usr_full_name'] as String,
      isActive: json['is_active_status'] as bool,
      email: json['contact_email_address'] as String,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'usr_id': instance.id,
      'usr_full_name': instance.fullName,
      'is_active_status': instance.isActive,
      'contact_email_address': instance.email,
    };

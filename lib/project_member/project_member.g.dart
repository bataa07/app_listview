// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProjectMember _$$_ProjectMemberFromJson(Map<String, dynamic> json) =>
    _$_ProjectMember(
      id: json['id'] as int?,
      employeeId: json['employeeId'] as int,
      avatarUrl: json['avatarUrl'] as String?,
      nickname: json['nickname'] as String?,
      role: json['role'] as int,
      cost: (json['cost'] as num).toDouble(),
      createdAt: json['createdAt'] as String?,
      position: json['position'] as String?,
    );

Map<String, dynamic> _$$_ProjectMemberToJson(_$_ProjectMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'avatarUrl': instance.avatarUrl,
      'nickname': instance.nickname,
      'role': instance.role,
      'cost': instance.cost,
      'createdAt': instance.createdAt,
      'position': instance.position,
    };

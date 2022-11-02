// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProjectList _$$_ProjectListFromJson(Map<String, dynamic> json) =>
    _$_ProjectList(
      data: ProjectListData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_ProjectListToJson(_$_ProjectList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

_$_ProjectListData _$$_ProjectListDataFromJson(Map<String, dynamic> json) =>
    _$_ProjectListData(
      items: (json['items'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecords: json['totalRecords'] as int,
    );

Map<String, dynamic> _$$_ProjectListDataToJson(_$_ProjectListData instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totalRecords': instance.totalRecords,
    };

_$_Project _$$_ProjectFromJson(Map<String, dynamic> json) => _$_Project(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      organizationId: json['organizationId'] as int,
      budget: json['budget'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      status: json['status'] as int,
      createdAt: json['createdAt'] as String,
      currentStep: json['currentStep'] as int,
      progress: (json['progress'] as num).toDouble(),
      members: (json['members'] as List<dynamic>)
          .map((e) => ProjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      subProjects: (json['subProjects'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      isParent: json['isParent'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ProjectToJson(_$_Project instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'organizationId': instance.organizationId,
      'budget': instance.budget,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'status': instance.status,
      'createdAt': instance.createdAt,
      'currentStep': instance.currentStep,
      'progress': instance.progress,
      'members': instance.members,
      'subProjects': instance.subProjects,
      'isParent': instance.isParent,
      'isLoading': instance.isLoading,
    };

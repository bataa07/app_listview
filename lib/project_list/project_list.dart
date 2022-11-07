import 'package:app_listview/project_member/project_member.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_list.freezed.dart';
part 'project_list.g.dart';

@freezed
class ProjectList with _$ProjectList {
  const factory ProjectList({
    required ProjectListData data,
    required String status,
  }) = _ProjectList;

  factory ProjectList.fromJson(Map<String, dynamic> json) =>
      _$ProjectListFromJson(json);
}

@freezed
class ProjectListData with _$ProjectListData {
  const factory ProjectListData({
    required List<Project> items,
    required int totalRecords,
  }) = _ProjectListData;

  factory ProjectListData.fromJson(Map<String, dynamic> json) =>
      _$ProjectListDataFromJson(json);
}

@freezed
class Project with _$Project {
  const factory Project({
    required int id,
    required String name,
    required String description,
    required int organizationId,
    required int budget,
    required DateTime startDate,
    DateTime? endDate,
    required int status,
    required String createdAt,
    required int currentStep,
    required List<ProjectMember> members,
    @Default(false) bool isParent,
    int? parentId,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

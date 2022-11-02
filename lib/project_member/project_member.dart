import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_member.freezed.dart';
part 'project_member.g.dart';

@freezed
class ProjectMember with _$ProjectMember {
  const factory ProjectMember({
    int? id,
    required int employeeId,
    String? avatarUrl,
    String? nickname,
    required int role,
    required double cost,
    String? createdAt,
    String? position,
  }) = _ProjectMember;

  factory ProjectMember.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberFromJson(json);
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProjectMember _$ProjectMemberFromJson(Map<String, dynamic> json) {
  return _ProjectMember.fromJson(json);
}

/// @nodoc
mixin _$ProjectMember {
  int? get id => throw _privateConstructorUsedError;
  int get employeeId => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  int get role => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectMemberCopyWith<ProjectMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectMemberCopyWith<$Res> {
  factory $ProjectMemberCopyWith(
          ProjectMember value, $Res Function(ProjectMember) then) =
      _$ProjectMemberCopyWithImpl<$Res, ProjectMember>;
  @useResult
  $Res call(
      {int? id,
      int employeeId,
      String? avatarUrl,
      String? nickname,
      int role,
      double cost,
      String? createdAt,
      String? position});
}

/// @nodoc
class _$ProjectMemberCopyWithImpl<$Res, $Val extends ProjectMember>
    implements $ProjectMemberCopyWith<$Res> {
  _$ProjectMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? employeeId = null,
    Object? avatarUrl = freezed,
    Object? nickname = freezed,
    Object? role = null,
    Object? cost = null,
    Object? createdAt = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectMemberCopyWith<$Res>
    implements $ProjectMemberCopyWith<$Res> {
  factory _$$_ProjectMemberCopyWith(
          _$_ProjectMember value, $Res Function(_$_ProjectMember) then) =
      __$$_ProjectMemberCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int employeeId,
      String? avatarUrl,
      String? nickname,
      int role,
      double cost,
      String? createdAt,
      String? position});
}

/// @nodoc
class __$$_ProjectMemberCopyWithImpl<$Res>
    extends _$ProjectMemberCopyWithImpl<$Res, _$_ProjectMember>
    implements _$$_ProjectMemberCopyWith<$Res> {
  __$$_ProjectMemberCopyWithImpl(
      _$_ProjectMember _value, $Res Function(_$_ProjectMember) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? employeeId = null,
    Object? avatarUrl = freezed,
    Object? nickname = freezed,
    Object? role = null,
    Object? cost = null,
    Object? createdAt = freezed,
    Object? position = freezed,
  }) {
    return _then(_$_ProjectMember(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectMember implements _ProjectMember {
  const _$_ProjectMember(
      {this.id,
      required this.employeeId,
      this.avatarUrl,
      this.nickname,
      required this.role,
      required this.cost,
      this.createdAt,
      this.position});

  factory _$_ProjectMember.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectMemberFromJson(json);

  @override
  final int? id;
  @override
  final int employeeId;
  @override
  final String? avatarUrl;
  @override
  final String? nickname;
  @override
  final int role;
  @override
  final double cost;
  @override
  final String? createdAt;
  @override
  final String? position;

  @override
  String toString() {
    return 'ProjectMember(id: $id, employeeId: $employeeId, avatarUrl: $avatarUrl, nickname: $nickname, role: $role, cost: $cost, createdAt: $createdAt, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, employeeId, avatarUrl,
      nickname, role, cost, createdAt, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectMemberCopyWith<_$_ProjectMember> get copyWith =>
      __$$_ProjectMemberCopyWithImpl<_$_ProjectMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectMemberToJson(
      this,
    );
  }
}

abstract class _ProjectMember implements ProjectMember {
  const factory _ProjectMember(
      {final int? id,
      required final int employeeId,
      final String? avatarUrl,
      final String? nickname,
      required final int role,
      required final double cost,
      final String? createdAt,
      final String? position}) = _$_ProjectMember;

  factory _ProjectMember.fromJson(Map<String, dynamic> json) =
      _$_ProjectMember.fromJson;

  @override
  int? get id;
  @override
  int get employeeId;
  @override
  String? get avatarUrl;
  @override
  String? get nickname;
  @override
  int get role;
  @override
  double get cost;
  @override
  String? get createdAt;
  @override
  String? get position;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectMemberCopyWith<_$_ProjectMember> get copyWith =>
      throw _privateConstructorUsedError;
}

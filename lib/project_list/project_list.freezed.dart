// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProjectList _$ProjectListFromJson(Map<String, dynamic> json) {
  return _ProjectList.fromJson(json);
}

/// @nodoc
mixin _$ProjectList {
  ProjectListData get data => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectListCopyWith<ProjectList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectListCopyWith<$Res> {
  factory $ProjectListCopyWith(
          ProjectList value, $Res Function(ProjectList) then) =
      _$ProjectListCopyWithImpl<$Res, ProjectList>;
  @useResult
  $Res call({ProjectListData data, String status});

  $ProjectListDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ProjectListCopyWithImpl<$Res, $Val extends ProjectList>
    implements $ProjectListCopyWith<$Res> {
  _$ProjectListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProjectListData,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectListDataCopyWith<$Res> get data {
    return $ProjectListDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProjectListCopyWith<$Res>
    implements $ProjectListCopyWith<$Res> {
  factory _$$_ProjectListCopyWith(
          _$_ProjectList value, $Res Function(_$_ProjectList) then) =
      __$$_ProjectListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProjectListData data, String status});

  @override
  $ProjectListDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_ProjectListCopyWithImpl<$Res>
    extends _$ProjectListCopyWithImpl<$Res, _$_ProjectList>
    implements _$$_ProjectListCopyWith<$Res> {
  __$$_ProjectListCopyWithImpl(
      _$_ProjectList _value, $Res Function(_$_ProjectList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? status = null,
  }) {
    return _then(_$_ProjectList(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProjectListData,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectList implements _ProjectList {
  const _$_ProjectList({required this.data, required this.status});

  factory _$_ProjectList.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectListFromJson(json);

  @override
  final ProjectListData data;
  @override
  final String status;

  @override
  String toString() {
    return 'ProjectList(data: $data, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectList &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectListCopyWith<_$_ProjectList> get copyWith =>
      __$$_ProjectListCopyWithImpl<_$_ProjectList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectListToJson(
      this,
    );
  }
}

abstract class _ProjectList implements ProjectList {
  const factory _ProjectList(
      {required final ProjectListData data,
      required final String status}) = _$_ProjectList;

  factory _ProjectList.fromJson(Map<String, dynamic> json) =
      _$_ProjectList.fromJson;

  @override
  ProjectListData get data;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectListCopyWith<_$_ProjectList> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectListData _$ProjectListDataFromJson(Map<String, dynamic> json) {
  return _ProjectListData.fromJson(json);
}

/// @nodoc
mixin _$ProjectListData {
  List<Project> get items => throw _privateConstructorUsedError;
  int get totalRecords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectListDataCopyWith<ProjectListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectListDataCopyWith<$Res> {
  factory $ProjectListDataCopyWith(
          ProjectListData value, $Res Function(ProjectListData) then) =
      _$ProjectListDataCopyWithImpl<$Res, ProjectListData>;
  @useResult
  $Res call({List<Project> items, int totalRecords});
}

/// @nodoc
class _$ProjectListDataCopyWithImpl<$Res, $Val extends ProjectListData>
    implements $ProjectListDataCopyWith<$Res> {
  _$ProjectListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalRecords = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Project>,
      totalRecords: null == totalRecords
          ? _value.totalRecords
          : totalRecords // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectListDataCopyWith<$Res>
    implements $ProjectListDataCopyWith<$Res> {
  factory _$$_ProjectListDataCopyWith(
          _$_ProjectListData value, $Res Function(_$_ProjectListData) then) =
      __$$_ProjectListDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Project> items, int totalRecords});
}

/// @nodoc
class __$$_ProjectListDataCopyWithImpl<$Res>
    extends _$ProjectListDataCopyWithImpl<$Res, _$_ProjectListData>
    implements _$$_ProjectListDataCopyWith<$Res> {
  __$$_ProjectListDataCopyWithImpl(
      _$_ProjectListData _value, $Res Function(_$_ProjectListData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalRecords = null,
  }) {
    return _then(_$_ProjectListData(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Project>,
      totalRecords: null == totalRecords
          ? _value.totalRecords
          : totalRecords // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectListData implements _ProjectListData {
  const _$_ProjectListData(
      {required final List<Project> items, required this.totalRecords})
      : _items = items;

  factory _$_ProjectListData.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectListDataFromJson(json);

  final List<Project> _items;
  @override
  List<Project> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalRecords;

  @override
  String toString() {
    return 'ProjectListData(items: $items, totalRecords: $totalRecords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectListData &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalRecords, totalRecords) ||
                other.totalRecords == totalRecords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), totalRecords);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectListDataCopyWith<_$_ProjectListData> get copyWith =>
      __$$_ProjectListDataCopyWithImpl<_$_ProjectListData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectListDataToJson(
      this,
    );
  }
}

abstract class _ProjectListData implements ProjectListData {
  const factory _ProjectListData(
      {required final List<Project> items,
      required final int totalRecords}) = _$_ProjectListData;

  factory _ProjectListData.fromJson(Map<String, dynamic> json) =
      _$_ProjectListData.fromJson;

  @override
  List<Project> get items;
  @override
  int get totalRecords;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectListDataCopyWith<_$_ProjectListData> get copyWith =>
      throw _privateConstructorUsedError;
}

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
mixin _$Project {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get organizationId => throw _privateConstructorUsedError;
  int get budget => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  List<ProjectMember> get members => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res, Project>;
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      int organizationId,
      int budget,
      DateTime startDate,
      DateTime? endDate,
      int status,
      String createdAt,
      int currentStep,
      double progress,
      List<ProjectMember> members,
      bool isLoading});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res, $Val extends Project>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? organizationId = null,
    Object? budget = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? currentStep = null,
    Object? progress = null,
    Object? members = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ProjectMember>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$$_ProjectCopyWith(
          _$_Project value, $Res Function(_$_Project) then) =
      __$$_ProjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String description,
      int organizationId,
      int budget,
      DateTime startDate,
      DateTime? endDate,
      int status,
      String createdAt,
      int currentStep,
      double progress,
      List<ProjectMember> members,
      bool isLoading});
}

/// @nodoc
class __$$_ProjectCopyWithImpl<$Res>
    extends _$ProjectCopyWithImpl<$Res, _$_Project>
    implements _$$_ProjectCopyWith<$Res> {
  __$$_ProjectCopyWithImpl(_$_Project _value, $Res Function(_$_Project) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? organizationId = null,
    Object? budget = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? currentStep = null,
    Object? progress = null,
    Object? members = null,
    Object? isLoading = null,
  }) {
    return _then(_$_Project(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as int,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<ProjectMember>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Project implements _Project {
  const _$_Project(
      {required this.id,
      required this.name,
      required this.description,
      required this.organizationId,
      required this.budget,
      required this.startDate,
      this.endDate,
      required this.status,
      required this.createdAt,
      required this.currentStep,
      required this.progress,
      required final List<ProjectMember> members,
      this.isLoading = false})
      : _members = members;

  factory _$_Project.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final int organizationId;
  @override
  final int budget;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final int status;
  @override
  final String createdAt;
  @override
  final int currentStep;
  @override
  final double progress;
  final List<ProjectMember> _members;
  @override
  List<ProjectMember> get members {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'Project(id: $id, name: $name, description: $description, organizationId: $organizationId, budget: $budget, startDate: $startDate, endDate: $endDate, status: $status, createdAt: $createdAt, currentStep: $currentStep, progress: $progress, members: $members, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Project &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      organizationId,
      budget,
      startDate,
      endDate,
      status,
      createdAt,
      currentStep,
      progress,
      const DeepCollectionEquality().hash(_members),
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      __$$_ProjectCopyWithImpl<_$_Project>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectToJson(
      this,
    );
  }
}

abstract class _Project implements Project {
  const factory _Project(
      {required final int id,
      required final String name,
      required final String description,
      required final int organizationId,
      required final int budget,
      required final DateTime startDate,
      final DateTime? endDate,
      required final int status,
      required final String createdAt,
      required final int currentStep,
      required final double progress,
      required final List<ProjectMember> members,
      final bool isLoading}) = _$_Project;

  factory _Project.fromJson(Map<String, dynamic> json) = _$_Project.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get description;
  @override
  int get organizationId;
  @override
  int get budget;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  int get status;
  @override
  String get createdAt;
  @override
  int get currentStep;
  @override
  double get progress;
  @override
  List<ProjectMember> get members;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectCopyWith<_$_Project> get copyWith =>
      throw _privateConstructorUsedError;
}

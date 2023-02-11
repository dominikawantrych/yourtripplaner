// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WishModel {
  String get id => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WishModelCopyWith<WishModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishModelCopyWith<$Res> {
  factory $WishModelCopyWith(WishModel value, $Res Function(WishModel) then) =
      _$WishModelCopyWithImpl<$Res, WishModel>;
  @useResult
  $Res call({String id, String imageURL, String title});
}

/// @nodoc
class _$WishModelCopyWithImpl<$Res, $Val extends WishModel>
    implements $WishModelCopyWith<$Res> {
  _$WishModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageURL = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WishModelCopyWith<$Res> implements $WishModelCopyWith<$Res> {
  factory _$$_WishModelCopyWith(
          _$_WishModel value, $Res Function(_$_WishModel) then) =
      __$$_WishModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String imageURL, String title});
}

/// @nodoc
class __$$_WishModelCopyWithImpl<$Res>
    extends _$WishModelCopyWithImpl<$Res, _$_WishModel>
    implements _$$_WishModelCopyWith<$Res> {
  __$$_WishModelCopyWithImpl(
      _$_WishModel _value, $Res Function(_$_WishModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageURL = null,
    Object? title = null,
  }) {
    return _then(_$_WishModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WishModel implements _WishModel {
  _$_WishModel({required this.id, required this.imageURL, required this.title});

  @override
  final String id;
  @override
  final String imageURL;
  @override
  final String title;

  @override
  String toString() {
    return 'WishModel(id: $id, imageURL: $imageURL, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WishModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, imageURL, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WishModelCopyWith<_$_WishModel> get copyWith =>
      __$$_WishModelCopyWithImpl<_$_WishModel>(this, _$identity);
}

abstract class _WishModel implements WishModel {
  factory _WishModel(
      {required final String id,
      required final String imageURL,
      required final String title}) = _$_WishModel;

  @override
  String get id;
  @override
  String get imageURL;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$_WishModelCopyWith<_$_WishModel> get copyWith =>
      throw _privateConstructorUsedError;
}

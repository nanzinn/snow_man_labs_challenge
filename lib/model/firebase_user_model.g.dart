// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_firebase_user_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FirebaseUserModel> _$firebaseUserModelSerializer =
    new _$FirebaseUserModelSerializer();

class _$FirebaseUserModelSerializer
    implements StructuredSerializer<FirebaseUserModel> {
  @override
  final Iterable<Type> types = const [FirebaseUserModel, _$FirebaseUserModel];
  @override
  final String wireName = 'FirebaseUserModel';

  @override
  Iterable<Object> serialize(Serializers serializers, FirebaseUserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.displayName != null) {
      result
        ..add('displayName')
        ..add(serializers.serialize(object.displayName,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.uid != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(object.uid,
            specifiedType: const FullType(String)));
    }
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  FirebaseUserModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FirebaseUserModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FirebaseUserModel extends FirebaseUserModel {
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String uid;
  @override
  final String error;

  factory _$FirebaseUserModel(
          [void Function(FirebaseUserModelBuilder) updates]) =>
      (new FirebaseUserModelBuilder()..update(updates)).build();

  _$FirebaseUserModel._({this.displayName, this.email, this.uid, this.error})
      : super._();

  @override
  FirebaseUserModel rebuild(void Function(FirebaseUserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FirebaseUserModelBuilder toBuilder() =>
      new FirebaseUserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FirebaseUserModel &&
        displayName == other.displayName &&
        email == other.email &&
        uid == other.uid &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, displayName.hashCode), email.hashCode), uid.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FirebaseUserModel')
          ..add('displayName', displayName)
          ..add('email', email)
          ..add('uid', uid)
          ..add('error', error))
        .toString();
  }
}

class FirebaseUserModelBuilder
    implements Builder<FirebaseUserModel, FirebaseUserModelBuilder> {
  _$FirebaseUserModel _$v;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  FirebaseUserModelBuilder();

  FirebaseUserModelBuilder get _$this {
    if (_$v != null) {
      _displayName = _$v.displayName;
      _email = _$v.email;
      _uid = _$v.uid;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FirebaseUserModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FirebaseUserModel;
  }

  @override
  void update(void Function(FirebaseUserModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FirebaseUserModel build() {
    final _$result = _$v ??
        new _$FirebaseUserModel._(
            displayName: displayName, email: email, uid: uid, error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

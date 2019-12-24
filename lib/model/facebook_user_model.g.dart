// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_facebook_user_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FacebookUserModel> _$facebookUserModelSerializer =
    new _$FacebookUserModelSerializer();

class _$FacebookUserModelSerializer
    implements StructuredSerializer<FacebookUserModel> {
  @override
  final Iterable<Type> types = const [FacebookUserModel, _$FacebookUserModel];
  @override
  final String wireName = 'FacebookUserModel';

  @override
  Iterable<Object> serialize(Serializers serializers, FacebookUserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.firstName != null) {
      result
        ..add('first_name')
        ..add(serializers.serialize(object.firstName,
            specifiedType: const FullType(String)));
    }
    if (object.lastName != null) {
      result
        ..add('last_name')
        ..add(serializers.serialize(object.lastName,
            specifiedType: const FullType(String)));
    }
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
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
  FacebookUserModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FacebookUserModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'first_name':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_name':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
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

class _$FacebookUserModel extends FacebookUserModel {
  @override
  final String name;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String id;
  @override
  final String error;

  factory _$FacebookUserModel(
          [void Function(FacebookUserModelBuilder) updates]) =>
      (new FacebookUserModelBuilder()..update(updates)).build();

  _$FacebookUserModel._(
      {this.name,
      this.email,
      this.firstName,
      this.lastName,
      this.id,
      this.error})
      : super._();

  @override
  FacebookUserModel rebuild(void Function(FacebookUserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FacebookUserModelBuilder toBuilder() =>
      new FacebookUserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FacebookUserModel &&
        name == other.name &&
        email == other.email &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        id == other.id &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, name.hashCode), email.hashCode),
                    firstName.hashCode),
                lastName.hashCode),
            id.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FacebookUserModel')
          ..add('name', name)
          ..add('email', email)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('id', id)
          ..add('error', error))
        .toString();
  }
}

class FacebookUserModelBuilder
    implements Builder<FacebookUserModel, FacebookUserModelBuilder> {
  _$FacebookUserModel _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  FacebookUserModelBuilder();

  FacebookUserModelBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _email = _$v.email;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _id = _$v.id;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FacebookUserModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FacebookUserModel;
  }

  @override
  void update(void Function(FacebookUserModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FacebookUserModel build() {
    final _$result = _$v ??
        new _$FacebookUserModel._(
            name: name,
            email: email,
            firstName: firstName,
            lastName: lastName,
            id: id,
            error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

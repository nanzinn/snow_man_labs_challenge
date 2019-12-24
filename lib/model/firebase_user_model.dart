library built_firebase_user_model;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert';
import 'serializers.dart';

part 'firebase_user_model.g.dart';

abstract class FirebaseUserModel implements Built<FirebaseUserModel, FirebaseUserModelBuilder> {
  @nullable
  String get displayName;
  @nullable
  String get email;
  @nullable
  String get uid;
  @nullable
  String get error;

  static FirebaseUserModel fromJson(String jsonString) {
    return serializers.deserializeWith(
        FirebaseUserModel.serializer, json.decode(jsonString));
  }

  String toJson() {
    return json.encode(serializers.serializeWith(FirebaseUserModel.serializer, this));
  }

  static Serializer<FirebaseUserModel> get serializer => _$firebaseUserModelSerializer;

  FirebaseUserModel._();
  factory FirebaseUserModel([void Function(FirebaseUserModelBuilder) updates]) = _$FirebaseUserModel;
}


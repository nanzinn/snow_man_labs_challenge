library built_facebook_user_model;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert';
import 'serializers.dart';

part 'facebook_user_model.g.dart';

abstract class FacebookUserModel implements Built<FacebookUserModel, FacebookUserModelBuilder> {
  @nullable
  String get name;
  @nullable
  String get email;
  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;
  @nullable
  @BuiltValueField(wireName: 'last_name')
  @nullable
  String get lastName;
  @nullable
  String get id;
  @nullable
  String get error;

  static FacebookUserModel fromJson(String jsonString) {
    return serializers.deserializeWith(
        FacebookUserModel.serializer, json.decode(jsonString));
  }
  static Serializer<FacebookUserModel> get serializer => _$facebookUserModelSerializer;

  FacebookUserModel._();
  factory FacebookUserModel([void Function(FacebookUserModelBuilder) updates]) = _$FacebookUserModel;
}


//{
//"name": "Iiro Krankka",
//"first_name": "Iiro",
//"last_name": "Krankka",
//"email": "iiro.krankka\u0040gmail.com",
//"id": "<user id here>"
//}


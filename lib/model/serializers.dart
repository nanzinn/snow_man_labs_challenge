library serializers;
import 'package:built_value/serializer.dart';
import 'package:snowmanlabs_challenge/model/facebook_user_model.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:snowmanlabs_challenge/model/firebase_user_model.dart';

part 'serializers.g.dart';

/// Example of how to use built_value serialization.
///
/// Declare a top level [Serializers] field called serializers. Annotate it
/// with [SerializersFor] and provide a `const` `List` of types you want to
/// be serializable.
///
/// The built_value code generator will provide the implementation. It will
/// contain serializers for all the types asked for explicitly plus all the
/// types needed transitively via fields.
///
/// You usually only need to do this once per project.
@SerializersFor([
  FacebookUserModel,
  FirebaseUserModel
])
final Serializers serializers =
(
    _$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
).build();


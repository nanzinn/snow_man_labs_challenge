import 'package:flutter/material.dart';
import 'package:snowmanlabs_challenge/bloc/login_bloc.dart';
import 'package:snowmanlabs_challenge/common_widgets/base_body.dart';
import 'package:snowmanlabs_challenge/ui/login/login_body.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBLoC _loginBLoC;

  @override
  void didChangeDependencies() {
    _loginBLoC ??= LoginBLoC();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
      child: Provider(create: (_)=> _loginBLoC, child: LoginBody()),
    );
  }

  @override
  void dispose() {
    _loginBLoC?.dispose();
    super.dispose();
  }
}

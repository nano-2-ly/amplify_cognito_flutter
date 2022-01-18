import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginData _data;
  bool _isSignedIn = false;

  Future<String> _onLogin(LoginData data) async {


    try {
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );

      _data = data;
      _isSignedIn = res.isSignedIn;
      return "";
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        await Amplify.Auth.signOut();
        return 'Problem logging in. Please try again.';
      }

      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String> _onRecoverPassword(BuildContext context, String email) async {
    try {
      final res = await Amplify.Auth.resetPassword(username: email);

      if (res.nextStep.updateStep == 'CONFIRM_RESET_PASSWORD_WITH_CODE') {
        Get.toNamed(
          '/confirm-reset',
          arguments: LoginData(name: email, password: ''),
        );

      }
      return "";
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String> _onSignup(LoginData data) async {
    try {
      await Amplify.Auth.signUp(
        username: data.name,
        password: data.password,
        options: CognitoSignUpOptions(userAttributes: {
          'email': data.name,
        }),
      );

      _data = data;

      return "";
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(

      onLogin: _onLogin,
      onRecoverPassword: (String email) => _onRecoverPassword(context, email),
      onSignup: _onSignup,
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: () {
        print(_data);
        Get.offAndToNamed(
          _isSignedIn ? '/dashboard' : '/confirm',
          arguments: _data,
        );
      },
      messages: LoginMessages(
        userHint: '이메일',
        passwordHint: '비밀번호',
        confirmPasswordHint: '비밀번호 확인',
        loginButton: '로그인',
        signupButton: '회원가입',
        forgotPasswordButton: '비밀번호를 잊으셨나요?',
        recoverPasswordButton: '비밀번호 재설정',
        goBackButton: '뒤로가기',
        confirmPasswordError: '비밀번호가 다릅니다.',
        recoverPasswordDescription:
        '비밀번호를 재설정합니다.',
        recoverPasswordSuccess: '비밀번호가 재설정되었습니다.',
      ),
    );
  }
}

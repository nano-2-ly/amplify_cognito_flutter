import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ConfirmScreen extends StatefulWidget {
  final LoginData data = Get.arguments;


  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _controller = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }


  void initUser() async{
    var session = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true)) as CognitoAuthSession;
    print(session.userPoolTokens!.accessToken.toString());
    print(session);
    print(Amplify.Auth.fetchAuthSession().toString());
    print("Amplify.Auth.fetchAuthSession().toString()");
    var _currentUser = await Amplify.Auth.getCurrentUser();

    var userInitURI =
    Uri.parse('https://6hlig5bzq0.execute-api.ap-northeast-2.amazonaws.com/default/iorilock-signup-setting');

    final response = await http.post(userInitURI,
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Accept": "*/*",
        'email': _currentUser.username,
        'uid' : _currentUser.userId,
        'AccessToken' : session.userPoolTokens!.accessToken.toString()
      },
      body: '{}',
    );

    print(response.body);

  }


  void _verifyCode(BuildContext context, LoginData data, String code) async {

    try {
      initUser();

      final res = await Amplify.Auth.confirmSignUp(
        username: data.name,
        confirmationCode: code,
      );

      if (res.isSignUpComplete) {
        // Login user
        final user = await Amplify.Auth.signIn(
            username: data.name, password: data.password);


        if (user.isSignedIn) {
          Get.toNamed('/dashboard');
        }
      }
    } on AuthException catch (e) {
      _showError(context, e.message);
    }
  }

  void _resendCode(BuildContext context, LoginData data) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: data.name);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text('Confirmation code resent. Check your email',
              style: TextStyle(fontSize: 15)),
        ),
      );
    } on AuthException catch (e) {
      _showError(context, e.message);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          message,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Enter confirmation code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        onPressed: _isEnabled
                            ? () {
                                _verifyCode(
                                    context, widget.data, _controller.text);
                              }
                            : null,
                        elevation: 4,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.deepPurple.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'VERIFY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _resendCode(context, widget.data);
                        },
                        child: Text(
                          'Resend code',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

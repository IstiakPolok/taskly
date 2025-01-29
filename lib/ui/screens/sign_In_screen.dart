import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskly/data/models/user_model.dart';
import 'package:taskly/data/services/network_caller.dart';
import 'package:taskly/ui/controllers/auth_controller.dart';
import 'package:taskly/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:taskly/ui/screens/main_bottom_nav_screen.dart';
import 'package:taskly/ui/screens/sign_up_screen.dart';
import 'package:taskly/ui/utils/app_colors.dart';
import 'package:taskly/ui/widgets/center_circular_prograss_indicator.dart';
import 'package:taskly/ui/widgets/screen_background.dart';
import 'package:taskly/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text('Get Started With', style: textTheme.titleLarge),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: _signInProgress == false,
                      replacement: const CenterCircularPrograssIndicator(),
                      child: ElevatedButton(
                          onPressed: _onTapSignInButton,
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ForgotPasswordVerifyEmailScreen.name);
                            },
                            child: const Text('Forget Password'),
                          ),
                          _buildSignUpSelection(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _onTapSignInButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.loginUrl, body: requestBody);

    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    } else {
      _signInProgress = false;
      setState(() {});
      if (response.statusCode == 401) {
        showSnackBarMessage(context, "Wrong Email Or Password");
      } else {
        showSnackBarMessage(context, response.errorMessage);
      }
    }
  }

  Widget _buildSignUpSelection() {
    return RichText(
        text: TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text: "Sign up",
                style: const TextStyle(
                  color: AppColors.themeColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, SignUpScreen.name);
                  },
              )
            ]));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}

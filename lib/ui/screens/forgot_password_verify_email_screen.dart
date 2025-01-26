import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskly/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:taskly/ui/screens/sign_up_screen.dart';
import 'package:taskly/ui/utils/app_colors.dart';
import 'package:taskly/ui/widgets/screen_background.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot-password/verify-email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {

  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                Text('Your Email Address', style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('6 digit verification code will sent to your mail', style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),),

                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPasswordVerifyOtpScreen.name);
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined)),
                const SizedBox(height: 50),
                Center(
                  child: _buildSignInSelection(),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildSignInSelection() {
    return RichText(
                      text: TextSpan(
                          text: "Have an account? ",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          children: [
                        TextSpan(
                            text: "Sign In",
                            style: const TextStyle(
                              color: AppColors.themeColor,
                            ),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Navigator.pop(context);
                              },
                        )
                      ]
                      )
                  );
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}

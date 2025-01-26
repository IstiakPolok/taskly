import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskly/ui/screens/sign_In_screen.dart';
import 'package:taskly/ui/utils/app_colors.dart';
import 'package:taskly/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String name = '/forgot-password/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newpasswordTEController =
      TextEditingController();
  final TextEditingController _confirmpasswordTEController =
      TextEditingController();

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
                Text('Set Password', style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(
                  'Maximun length of password is 9 character with letter and number combained',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _newpasswordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'New Password'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _confirmpasswordTEController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(hintText: 'Confirm New Password'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Confirm')),
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
                color: Colors.black54, fontWeight: FontWeight.w600),
            children: [
          TextSpan(
            text: "Sign In",
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.name, (value) => false);
              },
          )
        ]));
  }

  @override
  void dispose() {
    _newpasswordTEController.dispose();
    _confirmpasswordTEController.dispose();
    super.dispose();
  }
}

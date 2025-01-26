import 'package:flutter/material.dart';
import 'package:taskly/ui/screens/add_new_task_screen.dart';
import 'package:taskly/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:taskly/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:taskly/ui/screens/main_bottom_nav_screen.dart';
import 'package:taskly/ui/screens/reset_password_screen.dart';
import 'package:taskly/ui/screens/sign_in_screen.dart';
import 'package:taskly/ui/screens/sign_up_screen.dart';
import 'package:taskly/ui/screens/splash_screen.dart';
import 'package:taskly/ui/screens/update_profile_screen.dart';
import 'package:taskly/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.name, // Set initial route here.
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;


        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == ForgotPasswordVerifyEmailScreen.name) {
    widget = const ForgotPasswordVerifyEmailScreen();
        }else if (settings.name == ForgotPasswordVerifyOtpScreen.name) {
          widget = const ForgotPasswordVerifyOtpScreen();
        }else if (settings.name == ResetPasswordScreen.name) {
          widget = const ResetPasswordScreen();
        }else if (settings.name == MainBottomNavScreen.name) {
          widget = const MainBottomNavScreen();
        }else if (settings.name == AddNewTaskScreen.name) {
          widget = const AddNewTaskScreen();
        }else if (settings.name == UpdateProfileScreen.name) {
          widget = const UpdateProfileScreen();
        }


        else {

          widget = const UndefinedRouteScreen();
        }

        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}

// A fallback screen for undefined routes.
class UndefinedRouteScreen extends StatelessWidget {
  const UndefinedRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(
        child: Text(
          'Page not found!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/screens/splash_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 500,
            ),
            const Text('This is login page'),
            ElevatedButton(
                onPressed: () async {
                  var SharedPref = await SharedPreferences.getInstance();
                  SharedPref.setBool(SplashScreenState.KEYLOGIN, true);
                },
                child: const Text("login"))
          ],
        ),
      ),
    );
  }
}

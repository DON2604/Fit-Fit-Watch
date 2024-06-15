import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/screens/splash_screen.dart';
import 'package:watch/screens/tabs.dart';

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
                  await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TabsScreen(),
                      ));
                },
                child: const Text("login"))
          ],
        ),
      ),
    );
  }
}

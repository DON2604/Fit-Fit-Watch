import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/screens/splash_screen.dart';
import 'package:watch/screens/tabs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();

  final genderController = TextEditingController();

  final ageController = TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.white,
              Colors.lightBlueAccent.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Registration',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  'Create your new account',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: nameController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.purple,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: DropdownButtonFormField<String>(
                          value: selectedGender,
                          items: genderOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.female,
                              color: Colors.purple,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                                floatingLabelBehavior: FloatingLabelBehavior.never
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              Icons.timelapse_rounded,
                              color: Colors.purple,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                                floatingLabelBehavior: FloatingLabelBehavior.never
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: nameController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'Disease',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.medical_information_rounded,
                        color: Colors.purple,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var name = nameController.text.toString();
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString("name", name);

                    var age = ageController.text.toString();
                    var prefs2 = await SharedPreferences.getInstance();
                    prefs2.setString("age", age);

                    var gender = genderController.text.toString();
                    var prefs3 = await SharedPreferences.getInstance();
                    prefs3.setString("gender", gender);

                    var sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TabsScreen(),
                      ),
                    );
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

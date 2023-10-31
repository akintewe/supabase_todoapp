import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/src/app/services/googleAuthService.dart';
import 'package:todoapp/src/app/services/usernameAuthService.dart';
import 'package:todoapp/src/app/views/onboarding/login/loginScreen.dart';
import 'package:todoapp/src/app/widgets/regTitle.dart';
import 'package:todoapp/src/app/widgets/textfieldwidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final UserNameAuthService _userNameauthService = UserNameAuthService();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const RegTitle(
              title: 'Email',
            ),
            TextFieldWidget(
              hint: 'Enter your Email',
              obscure: false,
              controller: _usernameController,
            ),
            const RegTitle(title: 'Password'),
            TextFieldWidget(
              hint: '. . . . . . . .',
              obscure: true,
              controller: _passwordController,
            ),
            const RegTitle(title: 'Confirm Password'),
            TextFieldWidget(
              hint: '. . . . . . . .',
              obscure: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });

                          String email = _usernameController.text.trim();
                          String password = _passwordController.text.trim();
                          String confirmPassword =
                              _confirmPasswordController.text.trim();

                          if (password == confirmPassword) {
                            User? user = await _userNameauthService
                                .registerWithEmailAndPassword(email, password);

                            if (user != null) {
                              // Registration successful, navigate to the next screen or perform necessary actions
                              print(
                                  'User registered successfully: ${user.email}');
                              // Navigate to the next screen or perform actions here
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Email is badly formatted or email has been registered')),
                              );
                              // Registration failed, handle it appropriately
                              print('Registration failed');
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Passwords do not match')),
                            );
                            // Passwords do not match, show an error message or handle it as needed
                            print('Passwords do not match');
                          }

                          setState(() {
                            _isLoading = false;
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: const Color.fromRGBO(136, 117, 255, 1),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '-------------------------or-------------------------',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                    onPressed: () async {
                      User? user = await _authService.signInWithGoogle();

                      if (user != null) {
                        // Google sign-in successful, navigate to the next screen or perform necessary actions
                        print(
                            'User signed in with Google: ${user.displayName}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        // Navigate to the next screen or perform actions here
                      } else {
                        // Google sign-in failed or user cancelled, handle it appropriately
                        print('Google sign-in failed');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color.fromRGBO(136, 117, 255, 1), width: 2),
                        borderRadius: BorderRadius.circular(
                            8), // Set your desired border radius here
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/gg.png'),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Register with Google',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: Color.fromRGBO(151, 151, 151, 1),
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.87),
                        fontSize: 16,
                      ),
                      // Add your registration logic here
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/src/app/services/googleAuthService.dart';
import 'package:todoapp/src/app/services/usernameAuthService.dart';
import 'package:todoapp/src/app/views/homeScreen/todoScreen.dart';
import 'package:todoapp/src/app/views/onboarding/register/registerScreen.dart';
import 'package:todoapp/src/app/widgets/regTitle.dart';
import 'package:todoapp/src/app/widgets/textfieldwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final UserNameAuthService _userNameauthService = UserNameAuthService();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkButton);
    _passwordController.addListener(_checkButton);
  }

  void _checkButton() {
    final email = _usernameController.text;
    final password = _passwordController.text;

    setState(() {
      _isButtonEnabled = email.isNotEmpty && password.isNotEmpty;
    });
  }

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
              height: 20,
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
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          String email = _usernameController.text
                              .trim(); // Assuming email is used as username
                          String password = _passwordController.text.trim();

                          // Attempt to sign in the user
                          User? user = await _userNameauthService
                              .signInWithEmailAndPassword(email, password);

                          if (user != null) {
                            // Login successful, navigate to the next screen or perform necessary actions
                            print('User logged in successfully: ${user.email}');
                          

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TodoScreen(
                                          userId: user.uid,
                                        )));
                            // Navigate to the next screen or perform actions here
                          } else {
                            // Login failed, show an error message or handle it as needed
                            print('Login failed');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Login Failed',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text(
                                      'Invalid username or password. Please try again or register an account.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                          // Do something when the button is clicked
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: _isButtonEnabled
                        ? const Color.fromRGBO(136, 117, 255, 1)
                        : Color.fromARGB(255, 159, 158, 158),
                    // Set the button's background color
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Login',
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
                          'Login with Google',
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
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    color: Color.fromRGBO(151, 151, 151, 1),
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register',
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
                                  builder: (context) => RegisterScreen()));
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

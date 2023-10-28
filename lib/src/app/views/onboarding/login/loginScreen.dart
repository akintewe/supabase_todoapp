import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/src/app/services/googleAuthService.dart';
import 'package:todoapp/src/app/widgets/regTitle.dart';
import 'package:todoapp/src/app/widgets/textfieldwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
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
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
            SizedBox(
              height: 30,
            ),
            RegTitle(
              title: 'Username',
            ),
            TextFieldWidget(
              hint: 'Enter your Username',
              obscure: false,
              controller: _usernameController,
            ),
            RegTitle(title: 'Password'),
            TextFieldWidget(
              hint: '. . . . . . . .',
              obscure: true,
              controller: _passwordController,
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Do something when the button is clicked
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      primary: Color.fromRGBO(136, 117, 255, 1)
                      // Set the button's background color
                      ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '-------------------------or-------------------------',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            SizedBox(
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
                        side: BorderSide(
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
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

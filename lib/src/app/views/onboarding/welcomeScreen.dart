import 'package:flutter/material.dart';
import 'package:todoapp/src/app/views/onboarding/login/loginScreen.dart';
import 'package:todoapp/src/app/views/onboarding/register/registerScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome to StoreTodo',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Please login to your account or create',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'new account to continue',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 130,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Set your desired border radius here
                    ),
                    backgroundColor: Color.fromRGBO(136, 117, 255, 1),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
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
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

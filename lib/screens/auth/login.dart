import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/models.dart';
import '../../repository/repository.dart';
import '../widgets/widgets.dart';
import 'auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: 'dilshanramesh81@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123');

  bool isVisible = true;
  String? error;
  String? token;

  Future<void> handleForm() async {
    if (_formKey.currentState!.validate()) {
      APIResponse response = await AuthRepository().login(
        _emailController.text,
        _passwordController.text,
        token,
      );
      if (response.status) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/my-vehicle', (route) => false);
      } else {
        setState(() {
          error = response.message;
        });
      }
    }
  }

  getToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      setState(() {
        token = fcmToken;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.10,
                ),
                SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: GoogleFonts.urbanist(
                          fontSize: size.width * 0.060,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Glad to see you, Again...!',
                        style: GoogleFonts.urbanist(
                          fontSize: size.width * 0.060,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.050,
                ),
                CustomInput(
                  hintLabel: "Enter your email",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'E-mail is required';
                    }
                    if (value.isNotEmpty && !value.contains('@')) {
                      return 'E-mail is badly formatted';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                CustomInput(
                  hintLabel: "Enter your password",
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  obscureText: isVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Icon(
                      !isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  errorText: error,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.urbanist(
                          color: const Color(0xff35C2C1),
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                CustomButton(
                  title: "Sign In",
                  onPressed: handleForm,
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Register Now",
                        style: GoogleFonts.urbanist(
                          color: const Color(0xff35C2C1),
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

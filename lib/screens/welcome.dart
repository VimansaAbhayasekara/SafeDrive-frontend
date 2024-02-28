import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:safedrive/services/token_service.dart';

import 'auth/register.dart';
import 'widgets/widgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  TokenService tokenService = TokenService();

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer() async {
    final LocalStorage storage = LocalStorage('Safedrive');
    await storage.ready;
    await Future.delayed(const Duration(seconds: 1)).then((value) => _navigate());
  }

  Future<void> _navigate() async {
    if(await tokenService.validateToken()) {
      _navigateToHome();
    }else{
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
  }

  void _navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil("/my-vehicle", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.10,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "EMPOWERING YOUR",
                      style: GoogleFonts.sarpanch(
                        fontSize: size.width * 0.060,
                      ),
                    ),
                    Text(
                      "VEHICLE’S JOURNEY...",
                      style: GoogleFonts.sarpanch(
                        fontSize: size.width * 0.060,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/car.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Embark on a journey of",
                    style: GoogleFonts.urbanist(
                      fontSize: size.width * 0.050,
                    ),
                  ),
                  Text(
                    "automotive excellence with us...",
                    style: GoogleFonts.urbanist(
                      fontSize: size.width * 0.050,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              CustomButton(
                title: "Create Account",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account? ",
                    style: GoogleFonts.urbanist(
                      fontSize: size.width * 0.045,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      "Log in",
                      style: GoogleFonts.urbanist(
                        color: const Color(0xff35C2C1),
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

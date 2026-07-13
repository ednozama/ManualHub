import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: const Color(0xFF08111F),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Spacer(),

            const Icon(
              Icons.menu_book_rounded,
              color: Color(0xFF1EB6FF),
              size: 90,
            ),

            const SizedBox(height: 25),

            const Text(
              "Manual Hub",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Dein digitales Gerätearchiv",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 60),

            SizedBox(
              width: 240,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20),
                minHeight: 8,
              ),
            ),

            const Spacer(),

            Image.asset(
              "assets/images/gworks_logo.png",
              width: 180,
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
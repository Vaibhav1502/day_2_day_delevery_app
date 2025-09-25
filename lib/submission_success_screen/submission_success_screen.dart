import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../BottomNavigation_main_screen/main_screen.dart';


class SubmissionSuccessScreen extends StatefulWidget {
  const SubmissionSuccessScreen({super.key});

  @override
  State<SubmissionSuccessScreen> createState() => _SubmissionSuccessScreenState();
}

class _SubmissionSuccessScreenState extends State<SubmissionSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset('assets/images/Verified Badge.json',height: 300,width: 120,),
                const SizedBox(height: 32.0),

                // Success message title
                const Text(
                  'Registration Successful',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Subtitle message
                Text(
                  'Please wait and check your application status under My Application',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 40.0),

                OutlinedButton(
                  onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                    //Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.amber.shade300, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Go to home screen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber[800],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                // ElevatedButton(
                //  style: ElevatedButton.styleFrom(
                //    backgroundColor: Colors.amber.shade300,
                //    padding: const EdgeInsets.symmetric(vertical: 14),
                //    side: BorderSide(color: Colors.amber.shade300, width: 1.5),
                //    shape: RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(30.0),
                //    ),
                //  ),
                //  onPressed:  () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationStatusScreen()));
                //   },
                //   child: const Text(
                //     'Check Application Status',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontSize: 16.0,
                //       color: Colors.black,
                //       height: 1.4,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
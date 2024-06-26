import 'dart:async';
import 'package:codesphere/screens/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = true;
  late Timer? timer; // dummy timer to initialize.
  bool _isLoading = false; // to show loading indicator

  @override
  void initState() {
    super.initState();

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      isEmailVerified = currentUser.emailVerified;

      if (!isEmailVerified) {
        sendVerificationEmail();

        timer = Timer.periodic(
          const Duration(seconds: 5),
          (_) => checkEmailVerified(),
        );
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> sendVerificationEmail() async {
    try {
      setState(() {
        _isLoading = true;
      });

      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent successfully.'),
        ),
      );

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } on Exception catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send verification email.'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    await user!.reload();

    setState(() {
      isEmailVerified = user.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Provide your details'),
            ),
            body: const ProfileSection(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Verify Email'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Please verify your email.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text('Resend Email'),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            canResendEmail ? Colors.blue : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    if (_isLoading) const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
  }
}

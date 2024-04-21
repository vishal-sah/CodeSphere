import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  // Fetch these data
  /* 
    Name
    Profile Picture
    github
    linkedin
    bio
    skills
    college name
    year of graduation
    degree
  */

  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              const CircleAvatar(
                radius: 50,
                // backgroundImage: AssetImage('assets/images/.png'),
              ),

              const SizedBox(height: 20),
              const Text(
                'User Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.05,
                ),
                child: const Text(
                  'View and edit your profile information.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                color: const Color.fromARGB(255, 115, 175, 224),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const Text(
                'Your Profile Information:',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.start,
              ),
              // Add a list of user profile information here
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HackathonOrganizePage extends StatelessWidget {
  const HackathonOrganizePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Organize a Hackathon',
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
                'Organize a hackathon to bring together developers, designers, and entrepreneurs to build and launch a product in a short amount of time.',
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
              child: const Text('Organize a Hackathon'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            const Text(
              'Hackathons organized by you:',
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.start,
            ),

            // Add a list of hackathons tiles here

          ],
        ),
      ),
    );
  }
}

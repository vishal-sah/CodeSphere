import 'package:codesphere/landingPage/features.dart';
import 'package:codesphere/landingPage/footer.dart';
import 'package:codesphere/landingPage/our_team.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Features(),
          OurTeam(),
          Footer(),
        ],
      ),
    );
  }
}

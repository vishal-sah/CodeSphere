import 'package:flutter/material.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 750;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.yellow.shade100,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Why CodeSphere?',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 45),
          ),
          if (isLargeScreen)
            const SizedBox(
              height: 40,
            ),
          isLargeScreen
              ? const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        featureTile(
                          number: 1,
                          heading: 'Build a Public profile with resume',
                          description:
                              'You can create your profile here and showcase your qualifications, innovations, projects and many more...',
                          button: 'Build your Profile',
                        ),
                        featureTile(
                          number: 2,
                          heading: 'Showcase your innovative projects',
                          description:
                              'Add Projects to your profile to let the world know how fine you are...',
                          button: 'Add your Projects',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        featureTile(
                          number: 3,
                          heading: 'Don\'t miss any of the global Hackathons',
                          description:
                              'Explore, participate and organise Hackathons globally and showcase your development skills...',
                          button: 'Explore Hackathons',
                        ),
                        featureTile(
                          number: 4,
                          heading: 'Connect, Collaborate and Innovate ',
                          description:
                              'Connect with Developers World-wide. Create teams and shape together Awesome Ideas...',
                          button: 'Explore CodeSphere',
                        )
                      ],
                    )
                  ],
                )
              : const Column(
                  children: [
                    featureTile(
                      number: 1,
                      heading: 'Build a Public profile with resume',
                      description:
                          'You can create your profile here and showcase your qualifications, innovations, projects and many more...',
                      button: 'Build your Profile',
                    ),
                    featureTile(
                      number: 2,
                      heading: 'Showcase your innovative projects',
                      description:
                          'Add Projects to your profile to let the world know how fine you are...',
                      button: 'Add your Projects',
                    ),
                    featureTile(
                      number: 3,
                      heading: 'Don\'t miss any of the global Hackathons',
                      description:
                          'Explore, participate and organise Hackathons globally and showcase your development skills...',
                      button: 'Explore Hackathons',
                    ),
                    featureTile(
                      number: 4,
                      heading: 'Connect, Collaborate and Innovate ',
                      description:
                          'Connect with Developers World-wide. Create teams and shape together Awesome Ideas...',
                      button: 'Explore CodeSphere',
                    )
                  ],
                )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class featureTile extends StatelessWidget {
  final int number;
  final String heading;
  final String description;
  final String button;
  const featureTile({
    super.key,
    required this.number,
    required this.heading,
    required this.description,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black87,
              ),
              child: Center(
                  child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                ),
              )),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                width: 250,
                child: Text(
                  heading,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              padding: const EdgeInsets.all(20),
              color: Colors.blue.shade100,
              hoverColor: Colors.blue,
              onPressed: () {},
              child: Text(button),
            )
          ],
        ),
      ),
    );
  }
}

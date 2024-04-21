import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/landingPage/faqPage.dart';
import 'package:codesphere/landingPage/landing_page.dart';
import 'package:codesphere/screens/code_of_conduct.dart';
import 'package:codesphere/screens/create_hackathon_page.dart';
import 'package:codesphere/screens/explore_hackathon.dart';
import 'package:codesphere/screens/organise_hackathon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 750;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.yellow.shade100,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              isLargeScreen
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'We love software\nand the people who\nbuild them.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            SocialMediaIcons()
                          ],
                        ),
                        _buildLinks(context)
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'We love software\nand the people who\nbuild them.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            SocialMediaIcons()
                          ],
                        ),
                        _buildLinks(context)
                      ],
                    ),
              const SizedBox(
                height: 25,
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(
                height: 25,
              ),
              isLargeScreen
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CodeSphere',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        Text(
                            'Built at 2586 Labs. Made with Heart Gatsby.js, Framer Motion \n'
                            'and a bunch of other libraries that help making beautiful \n'
                            'things on the internet possible. We are forever in your debt.')
                      ],
                    )
                  : const Column(
                      children: [
                        Text(
                          'CodeSphere',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        Text(
                            'Built at 2586 Labs. Made with Heart Gatsby.js, Framer Motion \n'
                            'and a bunch of other libraries that help making beautiful \n'
                            'things on the internet possible. We are forever in your debt.')
                      ],
                    ),
              const SizedBox(
                height: 35,
              ),
              const Text('© 2024, NSB Classic PTE LTD')
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _buildColumnTitle('COMMUNITY'),
            //_buildTextButton('About us', () {}),
            _buildTextButton('Organize Hackathon', () {
              if (auth.getCurentUser() != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateHackathonPage()));
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('You are not Signed in!'),
                        content: Text(
                            'Please first Signin or create a new account then you can organise Hackathons'),
                      );
                    });
              }
            }),
            _buildTextButton('Explore Hackathons', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(),
                            body: ExploreHackathonPage(),
                          )));
            }),
            _buildTextButton('Code of Conduct', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CodeOfConductPage()));
            }),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            _buildColumnTitle(
              'SUPPORT',
            ),
            _buildTextButton('FAQs', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(),
                            body: FAQsPage(),
                          )));
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const LandingPage(initialPage: 2)));
            }),
            _buildTextButton('Help & Support', () async {
              const email =
                  'codespere01@email.com'; // Replace this with your email address
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: email,
              );
              try {
                await launchUrl(emailLaunchUri);
              } catch (e) {
                throw 'Could not launch email';
              }
            }),
            _buildTextButton('Contact us', () async {
              const email =
                  'codespere01@email.com'; // Replace this with your email address
              final Uri emailLaunchUri0 = Uri(
                scheme: 'mailto',
                path: email,
              );
              try {
                await launchUrl(emailLaunchUri0);
              } catch (e) {
                throw 'Could not launch email';
              }
            }),
          ],
        ),
      ],
    );
  }
}

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialIcon(
          name: 'linkedin',
          link: 'https://www.linkedin.com/in/nihal-yadav-7400a9262/',
        ),
        SizedBox(
          width: 7,
        ),
        SocialIcon(
          name: 'github',
          link: 'https://github.com/',
        ),
        SizedBox(
          width: 7,
        ),
        SocialIcon(
          name: 'facebook',
          link: 'https://www.facebook.com/',
        ),
        SizedBox(
          width: 7,
        ),
        SocialIcon(
          name: 'instagram',
          link: 'https://www.instagram.com/nihal.yadav.000/',
        ),
        SizedBox(
          width: 7,
        ),
        SocialIcon(
          name: 'twitter',
          link: 'https://www.facebook.com/',
        ),
        SizedBox(
          width: 7,
        ),
        SocialIcon(
          name: 'youtube',
          link: 'https://www.youtube.com/channel/UCg0J0hP0vs67cZS4AvTjcZg',
        ),
        SizedBox(
          width: 7,
        ),
        SocialIcon(
          name: 'telegram',
          link: 'https://t.me/+_oLt2QoszWMyZDg9',
        )
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String name;
  final String link;
  const SocialIcon({super.key, required this.name, required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // ignore: deprecated_member_use
        await launch(link);
      },
      child: Image.asset('assets/images/$name.png'),
    );
  }
}

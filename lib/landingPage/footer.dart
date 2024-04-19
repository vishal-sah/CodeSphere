import 'package:codesphere/landingPage/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isLargeScreen = MediaQuery.of(context).size.width > 750;
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.yellow.shade100,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              _isLargeScreen ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'We love software\nand the people who\nbuild them.',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      SocialMediaIcons()
                    ],
                  ),
                  _buildLinks(context)
                ],
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'We love software\nand the people who\nbuild them.',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      SocialMediaIcons()
                    ],
                  ),
                  _buildLinks(context)
                ],
              ),
              const SizedBox(height: 25,),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 25,),
              _isLargeScreen ?
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('CodeSphere', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                  Text('Built at 2586 Labs. Made with Heart Gatsby.js, Framer Motion \n'
                      'and a bunch of other libraries that help making beautiful \n'
                      'things on the internet possible. We are forever in your debt.')
                ],
              ) :
              const Column(
                children: [
                  Text('CodeSphere', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
                  Text('Built at 2586 Labs. Made with Heart Gatsby.js, Framer Motion \n'
                      'and a bunch of other libraries that help making beautiful \n'
                      'things on the internet possible. We are forever in your debt.')
                ],
              ),
              const SizedBox(height: 35,),
              const Text('© 2024, NSB Classic PTE LTD')
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildColumnTitle(String title) {
    return Text(title, style: TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _buildLinks(BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: 30,),
            _buildColumnTitle('COMMUNITY'),
            _buildTextButton('About us', () {}),
            _buildTextButton('Organize Hackathon', () {}),
            _buildTextButton('Explore Hackathons', () {}),
            _buildTextButton('Code of Conduct', () {}),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 30,),
            _buildColumnTitle('SUPPORT'),
            _buildTextButton(
              'FAQs',
              () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage(initialPage: 2)));
              }
            ),
            _buildTextButton(
              'Help & Support',
              () async {
                const email = 'codespere01@email.com'; // Replace this with your email address
                final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                );
                try {
                  await launchUrl(_emailLaunchUri);
                }
                catch (e){
                  throw 'Could not launch email';
                }
              }
            ),
            _buildTextButton(
              'Contact us',
                  () async {
                const email = 'codespere01@email.com'; // Replace this with your email address
                final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                );
                try {
                  await launchUrl(_emailLaunchUri);
                }
                catch (e){
                  throw 'Could not launch email';
                }
              }
            ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialIcon(
          name: 'linkedin',
          link: 'https://www.linkedin.com/in/nihal-yadav-7400a9262/',
        ),
        const SizedBox(width: 7,),
        SocialIcon(
          name: 'github',
          link: 'https://github.com/',
        ),
        const SizedBox(width: 7,),
        SocialIcon(
          name: 'facebook',
          link: 'https://www.facebook.com/',
        ),
        const SizedBox(width: 7,),
        SocialIcon(
          name: 'instagram',
          link: 'https://www.instagram.com/nihal.yadav.000/',
        ),
        const SizedBox(width: 7,),
        SocialIcon(
          name: 'twitter',
          link: 'https://www.facebook.com/',
        ),
        const SizedBox(width: 7,),
        SocialIcon(
          name: 'youtube',
          link: 'https://www.youtube.com/channel/UCg0J0hP0vs67cZS4AvTjcZg',
        ),
        const SizedBox(width: 7,),
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
  SocialIcon({
    super.key,
    required this.name,
    required this.link
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await launch(link);
      },
      child: Image.asset('assets/images/${name}.png'),
    );
  }
}

import 'package:codesphere/screens/hackathon_details_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:codesphere/cards/hackathon_card.dart';

class ExploreHackathonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Hackathons'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HackathonCard(
              hackathon: Hackathon(
                name: 'Sample Hackathon 1',
                about: 'Sample Hackathon 1 Description',
                imageUrl: 'https://via.placeholder.com/300',
                hackathonName: 'Hackathon 1',
                instagramLink: 'https://www.instagram.com/',
                linkedinLink: 'https://www.linkedin.com/',
                website: 'https://www.example.com/',
              ),
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => HackathonDetailPage()
                  )
                );
              },
            ),
            HackathonCard(
              hackathon: Hackathon(
                name: 'Sample Hackathon 2',
                about: 'Sample Hackathon 2 Description',
                imageUrl: 'https://via.placeholder.com/300',
                hackathonName: 'Hackathon 2',
                instagramLink: 'https://www.instagram.com/',
                linkedinLink: 'https://www.linkedin.com/',
                website: 'https://www.example.com/',
              ),
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => HackathonDetailPage()
                  )
                );
              },
            ),
            HackathonCard(
              hackathon: Hackathon(
                name: 'Sample Hackathon 3',
                about: 'Sample Hackathon 3 Description',
                imageUrl: 'https://via.placeholder.com/300',
                hackathonName: 'Hackathon 3',
                instagramLink: 'https://www.instagram.com/',
                linkedinLink: 'https://www.linkedin.com/',
                website: 'https://www.example.com/',
              ),
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => const HackathonDetailPage()
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch URL
  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hackathon {
  final String name;
  final String about;
  final String imageUrl;
  final String hackathonName;
  final String website;
  final String instagramLink;
  final String linkedinLink;

  Hackathon({
    required this.name,
    required this.about,
    required this.imageUrl,
    required this.hackathonName,
    required this.instagramLink,
    required this.linkedinLink,
    required this.website,
  });
}

class HackathonCard extends StatelessWidget {
  final Hackathon hackathon;
  final Function() onTap;

  const HackathonCard({super.key, required this.hackathon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        borderOnForeground: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                hackathon.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                color: Colors.lightBlueAccent[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      hackathon.name,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      hackathon.about,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    Container(height: 10),
                    Container(height: 10),
                    Row(
                      children: [
                        Container(width: 10),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(hackathon.instagramLink); // Launch Instagram URL
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.link,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Container(width: 10),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(hackathon.linkedinLink); // Launch LinkedIn URL
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.link,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Container(width: 10),
                        GestureDetector(
                          onTap: () {
                            _launchUrl(hackathon.website); // Launch website URL
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.link,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to launch URL
  void _launchUrl(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

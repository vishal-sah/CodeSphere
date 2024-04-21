import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesphere/landingPage/footer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:codesphere/cards/hackathon_card.dart';
import 'package:codesphere/screens/hackathon_details_page.dart';

class ExploreHackathonPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Hackathons'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: firestore.collection('hackathons').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<QueryDocumentSnapshot> hackathonDocs =
                        snapshot.data!.docs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: hackathonDocs.map((document) {
                        Map<String, dynamic> hackathonData =
                            document.data() as Map<String, dynamic>;
                        String uid = document.id;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          child: HackathonCard(
                            hack: hackathonData,
                            uid: uid
                          ),
                        );
                      }).toList(),
                    );
                  }
                }
              },
            ),
            Footer()
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

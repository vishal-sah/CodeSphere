import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/screens/hackathon_details_page.dart';
import 'package:codesphere/screens/team_creation_page.dart';
import 'package:codesphere/widgets/schedule_container.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HackathonCard extends StatelessWidget {
  final Map<String, dynamic> hack;
  final String uid;

  HackathonCard({Key? key, required this.hack, required this.uid})
      : super(key: key);
  final AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    String name = hack['name'] ?? '';
    String about = hack['about'] ?? '';
    String instagramLink = hack['instagramLink'] ?? '';
    String linkedinLink = hack['linkedinLink'] ?? '';
    String website = hack['website'] ?? '';

    return SizedBox(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            // Navigate to HackathonDetailPage with the hackathon's UID
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HackathonDetailPage(hack: hack),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            color: Colors.blue.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ScheduleContainer(
                      astart: hack['applicationStartDate'].toDate(),
                      aend: hack['applicationEndDate'].toDate(),
                      start: hack['hackathonStartDate'].toDate(),
                      end: hack['hackathonEndDate'].toDate(),
                      mid: hack['midEvaluationDate'].toDate(),
                      result: hack['resultDate'].toDate(),
                    ),
                    Column(
                      children: [
                        SocialIcon(
                          name: 'instagram',
                          link: instagramLink,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SocialIcon(
                          name: 'linkedin',
                          link: linkedinLink,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SocialIcon(
                          name: 'link',
                          link: website,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  color: Colors.blue,
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamCreationPage(
                                hackathonDocId: uid,
                                currentUserId: auth.getCurentUser()!.uid)));
                  },
                  child: Text('Apply Now'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String name;
  final String link;

  const SocialIcon({Key? key, required this.name, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launch(link);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset('assets/images/$name.png'),
      ),
    );
  }
}

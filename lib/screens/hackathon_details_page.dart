import 'package:codesphere/screens/code_of_conduct.dart';
import 'package:flutter/material.dart';
import 'package:codesphere/landingPage/faqPage.dart';
import 'package:codesphere/landingPage/footer.dart';
import 'package:codesphere/widgets/responsive_widget.dart';
import 'package:codesphere/widgets/schedule_container.dart';
import 'package:url_launcher/url_launcher.dart';

class HackathonDetailPage extends StatelessWidget {
  final Map<String, dynamic> hack;

  const HackathonDetailPage({super.key, required this.hack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(hack['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            ResponsiveWidget(
              children: [
                // Apply button
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                      horizontal: MediaQuery.of(context).size.width * 0.20),
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 115, 175, 224),
                    onPressed: () {},
                    child: const Text('Apply Now'),
                  ),
                ),
                // Schedule container
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ScheduleContainer(
                    astart: hack['applicationStartDate'].toDate(),
                    aend: hack['applicationEndDate'].toDate(),
                    start: hack['hackathonStartDate'].toDate(),
                    end: hack['hackathonEndDate'].toDate(),
                    mid: hack['midEvaluationDate'].toDate(),
                    result: hack['resultDate'].toDate(),
                  ),
                ),
                // About hackathon
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    hack['about'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                // Prizes
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Prizes', style: TextStyle(fontSize: 24)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        hack['prize'],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                // Themes
                Column(
                  children: [
                    const Text('Themes', style: TextStyle(fontSize: 24)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: hack['theme'].map<Widget>((theme) {
                          return Text(
                            theme,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Rules
            const Text('Rules'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CodeOfConductPage()));
                  },
                  child: const Text('Code of Conduct'),
                ),
              ],
            ),
            // FAQs
            Column(
              children: [
                const Text('FAQs'),
                ...hack['faqs'].split(',').map((faq) {
                  List<String> parts = faq.split(':');
                  return FAQTile(question: parts[0], answer: parts[1]);
                }).toList(),
              ],
            ),
            // Sponsors
            // Text('Sponsors'),
            // ResponsiveWidget(
            //   children: hack['partners'].map((sponsor) {
            //     String name = sponsor['name'];
            //     String link = sponsor['link'];
            //     return SponsorTile(name: name, link: link);
            //   }).toList(),
            // ),
            Footer()
          ],
        ),
      ),
    );
  }
}

class SponsorTile extends StatelessWidget {
  final String name;
  final String link;

  const SponsorTile({Key? key, required this.name, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text('Sponsor: $name'),
          TextButton(
            onPressed: () {
              launch(link); // Open sponsor link
            },
            child: Text(link),
          ),
        ],
      ),
    );
  }

  // void launchh(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}

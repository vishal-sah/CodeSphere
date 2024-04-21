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
                const Icon(
                  Icons.person,
                  size: 20,
                ),
                Text(hack['name']),
              ],
            ),
            ResponsiveWidget(
              children: [
                // Cover image
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 150,
                  color: Colors.blue,
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
                  padding: const EdgeInsets.all(10),
                  child: Text(hack['about']),
                ),
                // Prizes
                Column(
                  children: [
                    const Text('Prizes'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(hack['prize']),
                    ),
                  ],
                ),
                // Themes
                Column(
                  children: [
                    const Text('Themes'),
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
                            style: TextStyle(
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
              children: [
                const Text('Please refer to FAQs'),
                TextButton(
                  onPressed: () {},
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

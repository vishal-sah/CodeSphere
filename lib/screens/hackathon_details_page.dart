import 'package:codesphere/landingPage/faqPage.dart';
import 'package:codesphere/landingPage/footer.dart';
import 'package:codesphere/widgets/responsive_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HackathonDetailPage extends StatefulWidget {
  const HackathonDetailPage({super.key});

  @override
  State<HackathonDetailPage> createState() => _HackathonDetailPageState();
}

class _HackathonDetailPageState extends State<HackathonDetailPage> {

  @override
  void initState() {
    print('shdgc');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, size: 20,),
                Text('Name'),
              ],
            ),
            ResponsiveWidget(
                children: [
                  //cover image
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 150,
                    color: Colors.blue,
                  ),
                  // schedule
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text('Application Time'),
                        Text(DateFormat('dd-MM-yyyy').format(DateTime.now())+' - '+DateFormat('dd-MM-yyyy').format(DateTime.now())),
                        Text('Submission Time'),
                        Text(DateFormat('dd-MM-yyyy').format(DateTime.now())+' - '+DateFormat('dd-MM-yyyy').format(DateTime.now())),
                        Text('Result Declaration'),
                        Text(DateFormat('dd-MM-yyyy').format(DateTime.now())+' - '+DateFormat('dd-MM-yyyy').format(DateTime.now())),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      width: MediaQuery.of(context).size.width * 0.4, height: 100, child: Text('Our project aims to develop a comprehensive platform for hackathon enthusiasts, providing a seamless experience from registration and profile creation to project submission and networking. This platform will facilitate user engagement through features such as user authentication, profile management, hackathon organization, project submission, and profile sharing. By integrating these functionalities, we intend to empower developers and innovators to showcase their skills, collaborate on projects, and participate in hackathons with ease.')),
                  Column(
                    children: [
                      Text('Prizes'),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4, height: 100, child: Text('Our project aims to develop a comprehensive platform for hackathon enthusiasts, providing a seamless experience from registration and profile creation to project submission and networking. This platform will facilitate user engagement through features such as user authentication, profile management, hackathon organization, project submission, and profile sharing. By integrating these functionalities, we intend to empower developers and innovators to showcase their skills, collaborate on projects, and participate in hackathons with ease.')),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Themes'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: themes.map((e) => Text(e)).toList(),
                        ),
                      )
                    ],
                  )
                ]
            ),
            Text('Rules'),
            Row(
              children: [
                Text('Please refer to FAQs'),
                TextButton(
                  onPressed: (){

                  },
                  child: Text('Code of Conduct'),
                )
              ],
            ),
            ResponsiveWidget(
                children: [
                  LinkTile(name: 'instagram', link: 'link to instagram'),
                  LinkTile(name: 'instagram', link: 'link to instagram'),
                  LinkTile(name: 'linkedin', link: 'link to instagram'),
                  LinkTile(name: 'telegram', link: 'link to instagram'),
                ]
            ),
            Column(
              children: [
                Text('FAQs'),
                ...userFaqs.map((e) => FAQTile(question: e[0], answer: e[1]))
              ],
            ),
            Text('Sponsors'),
            ResponsiveWidget(children: [SponsorTile(), SponsorTile(), SponsorTile()]),
            Footer(),
          ],
        ),
      ),
    );
  }
}

List<String> themes = ['sdjh', 'aishdfu', 'shdgfkj', 'asdgfkajshd', 'ashdf', 'ashdgf'];

class LinkTile extends StatelessWidget {
  final String name;
  final String link;
  const LinkTile({super.key, required this.name, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/images/$name.png'),
            Text(link),
          ],
        ),
      ),
    );
  }
}

class SponsorTile extends StatelessWidget {
  const SponsorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      width: 100,
      height: 100,
      child: Center(
        child: Column(
          children: [
            Text('Sponsor'),
            TextButton(onPressed: (){}, child: Text('www.sponsor.com/linktothesponsorsite'),)
          ],
        ),
      ),
    );
  }
}
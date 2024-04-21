import 'package:codesphere/landingPage/footer.dart';
import 'package:codesphere/screens/explore_hackathon.dart';
import 'package:codesphere/widgets/schedule_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HackathonPage extends StatelessWidget {
  const HackathonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // GestureDetector(
          //   onTap: (){},
          //   child: Container(
          //     color: Colors.blue,
          //     height: 120,
          //     width: 120,
          //     child: const Center(
          //       child: Text('Explore Hackathons'),
          //     ),
          //   ),
          // ),
          MaterialButton(
            color: Colors.blue,
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExploreHackathonPage()),
              );
            },
            child: const Text('Explore Ongoing Hackathon'),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text('Your Hackathons'),
          Column(
            children: teams.map((e) => TeamTile(team: e)).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Footer()
        ],
      ),
    );
  }
}

class TeamTile extends StatelessWidget {
  final Map<String, dynamic> team;

  const TeamTile({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    Color color;
    Color bgcolor;
    bool isAccepted = false;
    if (team['status'].toString().toLowerCase() == 'accepted') {
      color = Colors.green;
      bgcolor = Colors.green.shade100;
      isAccepted = true;
    } else if (team['status'].toString().toLowerCase() == 'rejected') {
      color = Colors.red;
      bgcolor = Colors.red.shade100;
    } else {
      color = Colors.black;
      bgcolor = Colors.grey.shade300;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              team['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: bgcolor),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  team['status'].toString().toUpperCase(),
                  style: TextStyle(color: color),
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Nihal Yadav'),
                          Text('Vishal Sah'),
                          Text('Shubham Kumar')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: isAccepted ? Colors.blue : Colors.grey,
                      child: const Text('Start Submission'),
                    )
                  ],
                ),
                Column(
                  children: [
                    ScheduleContainer(
                      start: DateTime.now(),
                      astart: DateTime.now(),
                      aend: DateTime.now(),
                      end: DateTime.now(),
                      result: DateTime.now(),
                      mid: DateTime.now(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> teams = [
  {
    'id': 'id',
    'name': 'Widget Warrior',
    'status': 'Accepted',
    'score': 100,
    'members': [
      ['url', 'Nihal Yadav'],
      ['url', 'Shubham Kumar'],
      ['url', 'Vishal Sah']
    ],
    'submissionId': 'id',
  },
  {
    'id': 'abc123',
    'name': 'Code Crushers',
    'status': 'Pending',
    'score': 85,
    'members': [
      ['url', 'Alice Johnson'],
      ['url', 'Bob Smith'],
      ['url', 'Charlie Brown']
    ],
    'submissionId': 'def456',
  },
  {
    'id': 'xyz789',
    'name': 'Tech Titans',
    'status': 'Rejected',
    'score': 60,
    'members': [
      ['url', 'Emma Watson'],
      ['url', 'David Lee'],
      ['url', 'Sophia Taylor']
    ],
    'submissionId': 'ghi987',
  },
  {
    'id': 'pqr321',
    'name': 'Byte Brigade',
    'status': 'Accepted',
    'score': 95,
    'members': [
      ['url', 'Michael Chen'],
      ['url', 'Jennifer Adams'],
      ['url', 'Kevin Patel']
    ],
    'submissionId': 'stu654',
  },
  {
    'id': 'mno555',
    'name': 'Pixel Pirates',
    'status': 'Accepted',
    'score': 78,
    'members': [
      ['url', 'Lily Garcia'],
      ['url', 'Samuel Green'],
      ['url', 'Eva Martinez']
    ],
    'submissionId': 'qrs222',
  },
  {
    'id': 'ijk444',
    'name': 'Bug Busters',
    'status': 'Pending',
    'score': 70,
    'members': [
      ['url', 'Oliver Johnson'],
      ['url', 'Isabella White'],
      ['url', 'Daniel Kim']
    ],
    'submissionId': 'lmn777',
  }
];

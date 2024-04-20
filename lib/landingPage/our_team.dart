import 'package:flutter/material.dart';

class OurTeam extends StatelessWidget {
  const OurTeam({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 750;

    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60,),
            const Text(
              'Our Team',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 45
              ),
            ),
            if(isLargeScreen) const SizedBox(height: 40,),
            !isLargeScreen ? const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ourTeamTile(
                  name: 'Nihal Yadav',
                  position: 'Developer Team',
                  imageurl: 'assets/images/demo_user.jpg',
                ),
                _ourTeamTile(
                  name: 'Nihal Yadav',
                  position: 'Developer Team',
                  imageurl: 'assets/images/demo_user.jpg',
                ),
                _ourTeamTile(
                  name: 'Nihal Yadav',
                  position: 'Developer Team',
                  imageurl: 'assets/images/demo_user.jpg',
                )
              ],
            ) :
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ourTeamTile(
                  name: 'Vishal Sah',
                  position: 'Developer Team',
                  imageurl: 'assets/images/demo_user.jpg',
                ),
                _ourTeamTile(
                  name: 'Shubham kumar',
                  position: 'Developer Team',
                  imageurl: 'assets/images/demo_user.jpg',
                ),
                _ourTeamTile(
                  name: 'Nihal Yadav',
                  position: 'Developer Team',
                  imageurl: 'assets/images/demo_user.jpg',
                )
              ],
            ),
            const SizedBox(height: 60,)
          ],
        )
    );
  }
}

// ignore: camel_case_types
class _ourTeamTile extends StatelessWidget {
  final String name;
  final String position;
  final String imageurl;
  const _ourTeamTile({
    required this.name,
    required this.position,
    required this.imageurl,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 40,
            minRadius: 40,
            backgroundImage: AssetImage(imageurl),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(name, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
          Text(position, style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}

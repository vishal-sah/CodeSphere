  import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveWidget({required this.children});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600; // Example threshold for large screen

    return isLargeScreen ? _buildLargeScreenLayout() : _buildSmallScreenLayout(context);
  }

  Widget _buildLargeScreenLayout() {
    int totalWidgets = children.length;
    int halfCount = (totalWidgets + 1) ~/ 2;

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: children.sublist(0, halfCount).map(
                  (e) => Padding(
                padding: EdgeInsets.all(10),
                child: e,
              ),
            ).toList(),
          ),
          Column(
            children: children.sublist(halfCount).map(
                  (e) => Padding(
                padding: EdgeInsets.all(10),
                child: e,
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreenLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children.map(
              (e) => Padding(
            padding: EdgeInsets.all(10),
            child: _buildFullWidthCard(context, e),
          ),
        ).toList(),
      ),
    );
  }

  Widget _buildFullWidthCard(BuildContext context, Widget child) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth - 40; // Subtracting 20 for padding (10 left + 10 right)

    return Container(
      width: cardWidth,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}

class Try extends StatelessWidget {
  const Try({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      children: List.generate(
        10,
            (index) => _ourTeamTile(
          name: 'Shubham kumar',
          position: 'Developer Team',
          imageurl: 'assets/images/demo_user.jpg',
        ),
      ),
    );
  }
}

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
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 40,
          minRadius: 40,
          backgroundImage: AssetImage(imageurl),
        ),
        SizedBox(height: 20),
        Text(
          name,
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          position,
          style: TextStyle(fontSize: 17, color: Colors.grey),
        ),
      ],
    );
  }
}
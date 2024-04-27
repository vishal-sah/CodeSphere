import 'package:codesphere/cards/hackathon_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Portfolio extends StatelessWidget {
  final String userId;

  const Portfolio({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return _buildProfileView(userData);
        },
      ),
    );
  }

  Widget _buildProfileView(Map<String, dynamic> userData) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userData['photo'] ?? ''),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    userData['name'] ?? '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    userData['bio'] ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Skills:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: (userData['skills'] as List<dynamic>? ?? [])
                        .map<Widget>((skill) => Chip(label: Text(skill)))
                        .toList(),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Social Media:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      SocialIcon(name: 'linkedin', link: userData['linkedin']),
                      SocialIcon(name: 'github', link: userData['github'])
                      // Add more social media links as needed
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Projects:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (userData['projects'] as List<dynamic>? ?? [])
                  .map<Widget>((project) => ProjectTile(project: project))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectTile extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectTile({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        project['name'] ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project['tagline'] ?? ''),
          Text(project['techstack'] ?? ''),
          Text(project['description'] ?? ''),
        ],
      ),
      onTap: () {
        // Navigate to project details page
        // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectDetailsPage(project: project)));
      },
    );
  }
}

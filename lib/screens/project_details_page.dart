import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget {
  final Map<String, dynamic> projectData;

  const ProjectDetailPage({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(projectData['cover']),
            const SizedBox(height: 20),
            Text(
              projectData['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              projectData['about'],
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              projectData['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tech Stack',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: projectData['techStack']
                  .map<Widget>((tech) => Chip(label: Text(tech)))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'GitHub Link',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              projectData['github'],
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              'YouTube Link',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              projectData['youtube'],
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            const Text(
              'Screenshots',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: projectData['screenshots']
                  .map<Widget>((screenshot) => Image.network(screenshot))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Platforms',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              projectData['platforms'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Links',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: projectData['links']
            //     .map<Widget>(
            //       (link) => ListTile(
            //         title: Text(link[0]),
            //         subtitle: Text(link[1]),
            //         onTap: () {
            //           // Handle link tap
            //         },
            //       ),
            //     )
            //     .toList(),
            // ),
          ],
        ),
      ),
    );
  }
}

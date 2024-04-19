import 'package:flutter/material.dart';

class Project {
  final String name;
  final String description;
  final String teamName;
  final String imageUrl;
  final String hackathonName;

  Project({
    required this.name,
    required this.description,
    required this.teamName,
    required this.imageUrl,
    required this.hackathonName,
  });
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final Function() onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        borderOnForeground: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                project.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                color: Colors.lightBlueAccent[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      project.name,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      'Team: ${project.teamName}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      'Hackathon: ${project.hackathonName}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

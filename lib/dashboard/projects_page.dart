import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/screens/add_project.dart';
import 'package:codesphere/screens/project_details_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices auth = AuthServices();
  late Future<List<DocumentSnapshot>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = _fetchProjects();
  }

  Future<List<DocumentSnapshot>> _fetchProjects() async {
    String userId = auth.getCurentUser()!.uid;
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      List<String> projectIds = List<String>.from(userSnapshot['projects']);

      List<Future<DocumentSnapshot>> projectFutures = projectIds
          .map((projectId) =>
              _firestore.collection('projects').doc(projectId).get())
          .toList();

      return Future.wait(projectFutures);
    } else {
      return [];
    }
  }

  void _updateProjectList() {
    setState(() {
      _projectsFuture = _fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProject(
                    onProjectSaved: () {
                      _updateProjectList();
                    },
                  ),
                ),
              );
            },
            child: const Text('Add New Project'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: _projectsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<DocumentSnapshot> projects = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        // Build UI for each project
                        return ListTile(
                          title: Text(projects[index]['name']),
                          subtitle: Text(projects[index]['about']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailPage(
                                  projectData: projects[index].data()
                                      as Map<String, dynamic>,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TeamCreationPage extends StatefulWidget {
  final String hackathonDocId;
  final String currentUserId;

  const TeamCreationPage({
    Key? key,
    required this.hackathonDocId,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _TeamCreationPageState createState() => _TeamCreationPageState();
}

class _TeamCreationPageState extends State<TeamCreationPage> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _teamIdController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Creation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showCreateTeamDialog();
              },
              child: Text('Create Team'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _teamIdController,
              decoration: InputDecoration(
                labelText: 'Enter Team ID to Join',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _joinTeam(_teamIdController.text);
              },
              child: Text('Join Team'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateTeamDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Team'),
          content: TextField(
            controller: _teamNameController,
            decoration: InputDecoration(
              labelText: 'Team Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _createTeam(_teamNameController.text);
                Navigator.of(context).pop();
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createTeam(String teamName) async {
    try {
      DocumentReference teamRef = _firestore.collection('teams').doc();
      String teamId = teamRef.id;

      await teamRef.set({
        'name': teamName,
        'memberIds': [widget.currentUserId],
        'teamLeaderId': widget.currentUserId,
        'hackathonDocId': widget.hackathonDocId,
        'status': 'pending',
        'score': 0,
        'maxSize': 4, // Change as needed
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _firestore
          .collection('hackathons')
          .doc(widget.hackathonDocId)
          .update({
        'teams': FieldValue.arrayUnion([teamId]),
      });

      await _firestore.collection('users').doc(widget.currentUserId).update({
        'teams': FieldValue.arrayUnion([teamId]),
      });

      _showTeamIdAlert(teamId);
    } catch (error) {
      print('Error creating team: $error');
    }
  }

  Future<void> _joinTeam(String teamId) async {
    try {
      final teamData = await _firestore.collection('teams').doc(teamId).get();
      List<String> memberIds = List<String>.from(teamData['memberIds']);

      if (memberIds.length < teamData['maxSize']) {
        memberIds.add(widget.currentUserId);

        await _firestore.collection('teams').doc(teamId).update({
          'memberIds': memberIds,
        });

        await _firestore.collection('users').doc(widget.currentUserId).update({
          'teams': FieldValue.arrayUnion([teamId]),
        });

        Fluttertoast.showToast(msg: 'Successfully joined the team');
      } else {
        Fluttertoast.showToast(msg: 'Team is full');
      }
    } catch (error) {
      print('Error joining team: $error');
    }
  }

  void _showTeamIdAlert(String teamId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Team Created'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Team ID: $teamId'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _copyToClipboard(teamId);
                  Navigator.of(context).pop();
                },
                child: Text('Copy to Clipboard'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(msg: 'Team ID copied to clipboard');
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _teamIdController.dispose();
    super.dispose();
  }
}

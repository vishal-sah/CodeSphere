import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesphere/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServices {
  //instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  //get current user
  User? getCurentUser() {
    return auth.currentUser;
  }

  // get current user image and name
  Future<List<String>> getUserTile({required String uid}) async {
    List<String> data = [];
    data[0] = await firestore
        .collection('users')
        .doc(uid)
        .collection('imageUrl')
        .get() as String;
    data[1] = await firestore
        .collection('users')
        .doc(uid)
        .collection('username')
        .get() as String;

    return data;
  }

  // get data of current user
  // this will be used to get user data with uid as a map
  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    Map<String, dynamic> data = await firestore
        .collection('users')
        .doc(uid)
        .get() as Map<String, dynamic>;
    return data;
  }

  //signout
  Future<void> signOut() async {
    return await auth.signOut();
  }

  //user login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // check if user exists
  Future<UserCredential> signup(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // if no error, then return userCredentials
      return userCredential;
    } on FirebaseAuthException catch (error) {
      // read from firebase auth and handle all errors.
      throw Exception(error.code);
    }
  }

  // save photo
  Future<String> savePhoto(File imageFile, String userId) async {
    try {
      // file name according to user id
      String fileName = '${userId}_photo';
      // referwnce to the storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userId)
          .child(fileName);

      // upload image
      await firebaseStorageRef.putFile(imageFile);

      String downloadURL = await firebaseStorageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }

  // save resume
  Future<String> saveResume(File pdfFile, String userId) async {
    try {
      // Get the file name
      String fileName = '${userId}_resume';
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userId)
          .child(fileName);

      // Upload the file to Firebase Storage
      await firebaseStorageRef.putFile(pdfFile);

      // Get the download URL of the uploaded file
      String downloadURL = await firebaseStorageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading PDF to Firebase Storage: $e');
      return '';
    }
  }

  // after user successful signup, save his data in firestore
  Future<void> saveData(
      { //required UserCredential userCredential,
      required String name,
      required String username,
      required String email,
      required String gender,
      required String bio,
      required String tShirtSize,
      required String degree,
      required String college,
      required String field,
      required String passingYear,
      required List<String> skills,
      required String linkedin,
      required String github,
      required String photo,
      required String resume}) async {
    try {
      //add user to the list of users
      firestore.collection('users').doc(getCurentUser()!.uid).set({
        'uid': getCurentUser()!.uid,
        'email': email,
        'name': name,
        'username': username,
        'gender': gender,
        'bio': bio,
        'size': tShirtSize,
        'degree': degree,
        'college': college,
        'field': field,
        'passyear': passingYear,
        'skills': skills,
        'linkedin': linkedin,
        'github': github,
        'photo': photo,
        'resume': resume,
      });
      return;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // project section
  Future<String> addProject({
    required String name,
    required String about,
    required String description,
    required List<String> techStack,
    required String github,
    required String youtube,
    required String logo,
    required String cover,
    required List<String> screenshots,
    required String platforms,
    required String teamUid,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference projectRef = firestore.collection('projects').doc();

      await projectRef.set({
        'name': name,
        'about': about,
        'description': description,
        'techStack': techStack,
        'github': github,
        'youtube': youtube,
        'logo': logo,
        'cover': cover,
        'screenshots': screenshots,
        'platforms': platforms,
        'teamUid': teamUid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update user's projects list
      await firestore.collection('users').doc(getCurentUser()!.uid).update({
        'projects': FieldValue.arrayUnion([projectRef.id]),
      });

      return projectRef.id;
    } catch (error) {
      throw error;
    }
  }

  // create hackathon
  Future<String> addHackathon({
    required String name,
    required String organiserUserId,
    required String collegeName,
    required String about,
    required List<String> theme,
    required String prize,
    required int maxTeamSize,
    required int minTeamSize,
    required List<String> links,
    required DateTime applicationStartDate,
    required DateTime applicationEndDate,
    required DateTime hackathonStartDate,
    required DateTime hackathonEndDate,
    required DateTime midEvaluationDate,
    required DateTime resultDate,
    required String partners,
    required String faqs,
    required String coverImageUrl,
    required String email,
  }) async {
    try {
      DocumentReference ref = await firestore.collection('hackathons').add({
        'name': name,
        'organiserUserId': organiserUserId,
        'collegeName': collegeName,
        'about': about,
        'theme': theme,
        'prize': prize,
        'maxTeamSize': maxTeamSize,
        'minTeamSize': minTeamSize,
        'links': links,
        'applicationStartDate': applicationStartDate,
        'applicationEndDate': applicationEndDate,
        'hackathonStartDate': hackathonStartDate,
        'hackathonEndDate': hackathonEndDate,
        'midEvaluationDate': midEvaluationDate,
        'resultDate': resultDate,
        'partners': partners,
        'faqs': faqs,
        'coverImageUrl': coverImageUrl,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await firestore.collection('users').doc(organiserUserId).update({
        'organized': FieldValue.arrayUnion([ref.id])
      });
      return ref.id;
    } catch (error) {
      rethrow;
    }
  }

  // get list of all the hacks
  Future<dynamic> getHackathons() async {
    return await firestore.collection('hackathons').get();
  }

  // get all the teams and their hackathons
  // Retrieve user's teams data from Firestore
  Future<List<Map<String, dynamic>>> getHackathonPageData(
      {required String uid}) async {
    List<Map<String, dynamic>> result = [];

    try {
      // Retrieve the user document to access the 'teams' field
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(uid).get();
      final temp = userSnapshot.data() as Map<String, dynamic>;
      List<dynamic> teamIds = temp['teams'] ?? [];

      // Iterate through each team ID and fetch corresponding team details
      for (String teamId in teamIds) {
        // Retrieve the team document based on the team ID
        DocumentSnapshot teamSnapshot =
            await firestore.collection('teams').doc(teamId).get();
        Map<String, dynamic> teamData =
            teamSnapshot.data() as Map<String, dynamic>;

        // Retrieve the hackathon details associated with the team
        String hackathonDocId = teamData['hackathonDocId'];
        DocumentSnapshot hackathonSnapshot =
            await firestore.collection('hackathons').doc(hackathonDocId).get();
        Map<String, dynamic> hackathonData =
            hackathonSnapshot.data() as Map<String, dynamic>;

        // Prepare the team information to be added to the result list
        Map<String, dynamic> teamInfo = {
          'score': teamData['score'],
          'status': teamData['status'],
          'name': hackathonData['name'],
          'hackathonId': hackathonDocId,
          'applicationStartDate': hackathonData['applicationStartDate'],
          'applicationEndDate': hackathonData['applicationEndDate'],
          'hackathonStartDate': hackathonData['hackathonStartDate'],
          'hackathonEndDate': hackathonData['hackathonEndDate'],
          'midEvaluationDate': hackathonData['midEvaluationDate'],
          'resultDate': hackathonData['resultDate'],
          'members': [], // Placeholder for team members (to be populated later)
        };

        // Retrieve member details for the team
        List<dynamic> memberIds = teamData['memberIds'] ?? [];
        List<List<String>> members = [];

        for (String memberId in memberIds) {
          DocumentSnapshot memberSnapshot =
              await firestore.collection('users').doc(memberId).get();
          Map<String, dynamic> memberData =
              memberSnapshot.data() as Map<String, dynamic>;
          String memberName = memberData['name'] ?? 'Unknown';
          String memberImageUrl = memberData['imageUrl'] ??
              ''; // Add logic to fetch member image URL
          members.add([memberImageUrl, memberName]);
        }

        // Update the team information with member details
        teamInfo['members'] = members;
        result.add(teamInfo);
      }

      return result;
    } catch (error) {
      print('Error fetching hackathon page data: $error');
      throw error;
    }
  }

  // on organiser side get all the list of organised hackathons
  // it will return the complete list of data not id
  Future<List<Map<String, dynamic>>> getOrganiseHacks() async {
    List<Map<String, dynamic>> list = [];
    final data =
        await firestore.collection('users').doc(getCurentUser()!.uid).get();
    for (String a in data['organized']) {
      Map<String, dynamic> temp;
      final hacks = await firestore.collection('hackathons').doc(a).get();
      temp = hacks.data()!;
      list.add(temp);
    }
    return list;
  }

  // addTeam
  Future<String> addTeam({
    required String name,
    required List<String> memberIds,
    required String teamLeaderId,
    required String hackathonDocId,
    required String status,
    required int score,
    required int maxSize,
  }) async {
    try {
      DocumentReference ref = await firestore.collection('teams').add({
        'name': name,
        'memberIds': memberIds,
        'teamLeaderId': teamLeaderId,
        'hackathonDocId': hackathonDocId,
        'status': status,
        'score': score,
        'maxSize': maxSize,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await firestore.collection('hackathons').doc(hackathonDocId).update({
        'teams': FieldValue.arrayUnion([ref.id])
      });
      return ref.id;
    } catch (error) {
      rethrow;
    }
  }

  // join team
  Future<String> joinTeam({
    required String teamId,
    required String userId,
  }) async {
    try {
      final teamData = await firestore.collection('teams').doc(teamId).get();
      if (teamData['memberIds'].length < teamData['maxSize']) {
        await firestore.collection('teams').doc(teamId).update({
          'memberIds': FieldValue.arrayUnion([userId]),
        });
        return 'success';
      } else {
        return 'full';
      }
    } catch (error) {
      throw 'Error joining team';
    }
  }

  // update team score or status
  Future<void> updateTeamStatusAndScore({
    required String teamId,
    required String newStatus,
    required int newScore,
  }) async {
    try {
      await firestore.collection('teams').doc(teamId).update({
        'status': newStatus,
        'score': newScore,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      rethrow;
    }
  }
}

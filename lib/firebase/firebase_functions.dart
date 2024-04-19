import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServices{

  //instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  //get current user
  User? getCurentUser (){
    return auth.currentUser;
  }

  // get data of current user
  // this will be used to get user data with uid as a map
  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    Map<String, dynamic> data = await firestore.collection('users').doc(uid).get() as Map<String, dynamic>;
    return data;
  }

  //signout
  Future<void> signOut () async {
    return await auth.signOut();
  }

  //user login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // check if user exists
  Future<UserCredential> signup({
    required String email,
    required String password
  }) async {
    try {
      UserCredential userCredential =  await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // if no error, then return userCredentials
      return userCredential;
    }
    on FirebaseAuthException catch (error) {
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
      Reference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child('users')
          .child(userId)
          .child(fileName);

      // upload image
      await firebaseStorageRef.putFile(imageFile);

      String downloadURL = await firebaseStorageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      //print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }

  // save resume
  Future<String> saveResume(File pdfFile, String userId) async {
    try {
      // Get the file name
      String fileName = '${userId}_resume';
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child('users')
          .child(userId)
          .child(fileName);

      // Upload the file to Firebase Storage
      await firebaseStorageRef.putFile(pdfFile);

      // Get the download URL of the uploaded file
      String downloadURL = await firebaseStorageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      //print('Error uploading PDF to Firebase Storage: $e');
      return '';
    }
  }

  // after user successful signup, save his data in firestore
  Future<UserCredential> saveData ({
    required UserCredential userCredential,
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
    required String resume
  }) async {
    try{
      //add user to the list of users
      firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': userCredential.user!.email,
            'name' : name,
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
          }
      );
      return userCredential;
    }
    on FirebaseAuthException catch (e){
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
    required List<List<String>> links,
    required String youtube,
    required String logo,
    required String cover,
    required List<String> screenshots,
    required String platforms, // comma seperated platform names, later we will seperate them and use
    required String teamUid,
  }) async {
    try {
      DocumentReference ref = await firestore.collection('projects').add({
        'name': name,
        'about': about,
        'description': description,
        'techStack': techStack,
        'github': github,
        'links': links,
        'youtube': youtube,
        'logo': logo,
        'cover': cover,
        'screenshots': screenshots,
        'platforms': platforms,
        'teamUid': teamUid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return ref.id;
    }
    catch (error) {
      rethrow;
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
    required List<String> links,
    required DateTime applicationStartDate,
    required DateTime applicationEndDate,
    required DateTime hackathonStartDate,
    required DateTime hackathonEndDate,
    required DateTime midEvaluationDate,
    required DateTime resultDate,
    required List<List<String>> partners,
    required List<List<String>> faqs,
    required String coverImageUrl,
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


  // on organiser side get all the list of organised hackathons
  // it will return the complete list of data not id
  Future<List<Map<String, dynamic>>> getOrganiseHacks() async {
    List<Map<String, dynamic>> list = [];
    final data = await firestore.collection('users').doc().get();
    for(String a in data['organized']){
      Map<String, dynamic> temp = await firestore.collection('hackathons').doc(a).get() as Map<String, dynamic>;
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
      if(teamData['memberIds'].length < teamData['maxSize']){
        await firestore.collection('teams').doc(teamId).update({
          'memberIds': FieldValue.arrayUnion([userId]),
        });
        return 'success';
      }
      else{
        return 'full';
      }
    }
    catch (error){
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
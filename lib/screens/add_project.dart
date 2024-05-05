import 'dart:io';

import 'package:codesphere/dashboard/projects_page.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddProject extends StatefulWidget {
  final VoidCallback onProjectSaved;
  const AddProject({super.key, required this.onProjectSaved});

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices auth = AuthServices();

  // Define variables to hold user data
  String? _name;
  String? _shortDescription;
  String? _properDescription;
  List<String> _teckStack = [];
  String? _githubLink;
  String? _websiteHostedLink;
  String? _youtubeLink;
  File? _coverImage;
  List<File> _screenshots = [];
  File? _logo;
  List<String> _platforms = [];

  void pickCoverImage() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      setState(() {
        _coverImage = File(fileBytes.toString());
      });
    }
  }

  void pickScreenshots() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _screenshots = result.files.map((file) => File(file.path!)).toList();
      });
    }
  }

  void pickLogo() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      setState(() {
        _logo = File(fileBytes.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Add Project Details',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                CustomTextField(
                  labelText: 'PROJECT NAME',
                  onChanged: (value) => _name = value,
                ),
                CustomTextField(
                  labelText: 'SHORT DESCRIPTION (in less than 50 words)',
                  maxLines: 3,
                  onChanged: (value) => _shortDescription = value,
                ),
                CustomTextField(
                  labelText: 'PROPER DESCRIPTION',
                  maxLines: 8,
                  onChanged: (value) => _properDescription = value,
                ),
                CustomTextField(
                  labelText: 'TECH STACK (comma separated)',
                  onChanged: (value) => _teckStack = value.split(','),
                ),
                CustomTextField(
                  labelText: 'GITHUB LINK',
                  onChanged: (value) => _githubLink = value,
                ),
                CustomTextField(
                  labelText: 'WEBSITE HOSTED LINK',
                  onChanged: (value) => _websiteHostedLink = value,
                ),
                CustomTextField(
                  labelText: 'YOUTUBE LINK',
                  onChanged: (value) => _youtubeLink = value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.01,
                    top: size.height * 0.02,
                  ),
                  child: const Text('COVER IMAGE'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.4),
                  child: ElevatedButton(
                    onPressed: pickCoverImage,
                    child: const Text('Pick Cover Image'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.01,
                    top: size.height * 0.02,
                  ),
                  child: const Text('SCREENSHOTS'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.4),
                  child: ElevatedButton(
                    onPressed: pickScreenshots,
                    child: const Text('Pick ScreenShots'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.01,
                    top: size.height * 0.02,
                  ),
                  child: const Text('LOGO'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.4),
                  child: ElevatedButton(
                    onPressed: pickLogo,
                    child: const Text('Pick Logo'),
                  ),
                ),
                CustomTextField(
                  labelText: 'PLATFORMS (comma separated)',
                  onChanged: (value) => _platforms = value.split(','),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await auth.addProject(
                          name: _name!,
                          about: _shortDescription!,
                          description: _properDescription!,
                          techStack: _teckStack,
                          github: _githubLink!,
                          youtube: _youtubeLink!,
                          logo: 'sd',
                          cover: 'sd',
                          screenshots: ['sd', 'sd'],
                          platforms: _platforms.join(","),
                          teamUid: 'sd',
                        );
                        widget.onProjectSaved();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:codesphere/widgets/custom_text_field.dart';
import 'package:codesphere/widgets/dropdown_menu_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to hold user data
  String? _name;
  String? _contact;
  String? _gender;
  String? _tshirtSize;
  String? _bio;
  String? _educationDegree;
  String? _collegeName;
  String? _fieldOfStudy;
  String? _expectedGraduation;
  String? _skills;
  String? _githubLink;
  String? _linkedinLink;
  File? _profilePicture;
  File? _resume;

  List<String> generateYears() {
    final List<String> years = [];
    final int currentYear = DateTime.now().year;
    for (int year = currentYear + 4; year >= 2000; year--) {
      years.add(year.toString());
    }
    return years;
  }

  final List<String> tshirtSizes = [
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  final List<String> educationDegrees = [
    'High School',
    'Associate',
    'Bachelor',
    'Master',
    'PhD',
  ];

  final List<String> genders = [
    'Male',
    'Female',
    'Other',
  ];

  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _resume = result.files.single.path as File?;
      });
    }
  }

  Future<void> pickProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _profilePicture = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        children: [
          CustomTextField(
            labelText: 'NAME',
            onChanged: (value) {
              _name = value;
            },
          ),
          CustomTextField(
            labelText: 'CONTACT',
            onChanged: (value) {
              _contact = value;
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.01,
              top: size.height * 0.02,
            ),
            child: const Text('RESUME'),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.4),
            child: ElevatedButton(
              onPressed: pickResume,
              child: const Text('Pick Resume'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.01,
              top: size.height * 0.02,
            ),
            child: const Text('PROFILE PICTURE'),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.4),
            child: ElevatedButton(
              onPressed: pickProfilePicture,
              child: const Text('Pick Profile Picture'),
            ),
          ),
          ProfileDropdownFormField(
            value: _gender,
            labelText: 'GENDER',
            items: genders,
            onChanged: (value) {
              setState(() {
                _gender = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'T-shirt Size is required';
              }
              return null;
            },
          ),
          ProfileDropdownFormField(
            value: _tshirtSize,
            labelText: 'T-SHIRT SIZE',
            items: tshirtSizes,
            onChanged: (value) {
              setState(() {
                _tshirtSize = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'T-shirt Size is required';
              }
              return null;
            },
          ),
          CustomTextField(
            labelText: 'BIO',
            maxLines: 3,
            onChanged: (value) {
              _bio = value;
            },
          ),
          ProfileDropdownFormField(
            value: _educationDegree,
            labelText: 'EDUCATION DEGREE',
            items: educationDegrees,
            onChanged: (value) {
              setState(() {
                _educationDegree = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty || value == 'Choose Degree') {
                return 'Education Degree is required';
              }
              return null;
            },
          ),
          CustomTextField(
            labelText: 'COLLEGE NAME',
            onChanged: (value) {
              _collegeName = value;
            },
          ),
          CustomTextField(
            labelText: 'FIELD OF STUDY',
            onChanged: (value) {
              _fieldOfStudy = value;
            },
          ),
          ProfileDropdownFormField(
            value: _expectedGraduation,
            labelText: 'Graduation Year',
            items: generateYears(),
            onChanged: (value) {
              setState(() {
                _expectedGraduation = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty || value == 'Choose Size') {
                return 'Graduation Year is required';
              }
              return null;
            },
          ),
          CustomTextField(
            labelText: 'SKILLS',
            maxLines: 3,
            onChanged: (value) {
              _skills = value;
            },
          ),
          CustomTextField(
            labelText: 'GITHUB LINK',
            onChanged: (value) {
              _githubLink = value;
            },
          ),
          CustomTextField(
            labelText: 'LINKEDIN LINK',
            onChanged: (value) {
              _linkedinLink = value;
            },
          ),
          const SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: const Text('Profile saved'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                  if (kDebugMode) {
                    print('Profile saved');
                  }
                }
              },
              child: const Text('Save Profile'),
            ),
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

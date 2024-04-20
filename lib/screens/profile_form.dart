import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codesphere/dashboard/dashboard.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to hold user data
  File? _profilePicture;
  File? _resume;
  String selectedGender = 'Select';
  String selectedSize = 'Select';
  String degree = 'Select';
  int year = 2024;
  bool detailsChanged = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  String? photo = 'temp';
  String? resume = 'temp';
  final AuthServices auth = AuthServices();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> generateYears() {
    final List<String> years = [];
    final int currentYear = DateTime.now().year;
    for (int year = currentYear + 4; year >= 2000; year--) {
      years.add(year.toString());
    }
    return years;
  }

  final List<String> tshirtSizes = [
    'Select',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  final List<String> educationDegrees = [
    'Select',
    'High School',
    'Associate',
    'Bachelor',
    'Master',
    'PhD',
  ];

  final List<String> genders = [
    'Select',
    'Male',
    'Female',
    'Other',
  ];

  // Future<void> pickProfilePicture() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );
  //   if (result != null) {
  //     //Uint8List bytes = result.files.single.bytes!;
  //     setState(() {
  //       //_profilePicture = File.fromRawPath(bytes);
  //       _profilePicture = File(result.files.single.path!);
  //     });
  //   }
  // }

  final _picker = ImagePicker();
  // // Implementing the image picker
  // Future<void> _openImagePicker() async {
  //   final XFile? pickedImage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _profilePicture = File(pickedImage.path);
  //     });
  //   }
  // }

  // ignore: non_constant_identifier_names
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profilePicture = File(pickedImage.path);
      });
      try {
        // Upload file to Firebase Storage
        await uploadFile(_profilePicture!);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> uploadFile(File file) async {
    try {
      Reference ref = storage.ref().child('images/${path.basename(file.path)}');
      await ref.putFile(file);
      photo = await ref.getDownloadURL();
      print('File uploaded successfully.');
    } catch (e) {
      print(e);
    }
  }

  // Future<void> pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     _profilePicture = File(pickedImage.path);
  //   } else {
  //     //return null;
  //   }
  // }

  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _resume = File(result.files.single.path!);
      });
    }
  }

  void enableSaveButton(String value) {
    if (detailsChanged == false) {
      setState(() {
        detailsChanged = true;
      });
    }
  }

  void saveImage() async {
    if (_profilePicture != null) {
      String photoUrl =
          await auth.savePhoto(_profilePicture!, auth.getCurentUser()!.uid);

      photo = photoUrl;
    }
  }

  void saveResume() async {
    if (_resume != null) {
      String resumeUrl =
          await auth.saveResume(_resume!, auth.getCurentUser()!.uid);

      resume = resumeUrl;
    }
  }

  // @override
  // void initState() {
  //   // Future.delayed(Duration(seconds: 2), () async {

  // });

  //   Future<Map<String, dynamic>> data = auth.getUserData(uid: auth.getCurentUser()!.uid);
  //   nameController.text = data['name'];
  //   contactController.text = data['email'];
  //   selectedGender = data['gender'];
  //   selectedSize = data['size'];
  //   bioController.text = data['bio'];
  //   degree = data['degree'];
  //   collegeController.text = data['college'];
  //   fieldController.text = data['field'];
  //   year = data['passyear'];
  //   skillsController.text = data['skills'].join(', ');
  //   githubController.text = data['github'];
  //   linkedinController.text = data['linkedin'];

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('rebuilt');
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: size.width <= 720
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
              children: [
                ProfileTextField(
                  labelText: 'NAME',
                  controller: nameController,
                  onChanged: enableSaveButton,
                ),
                ProfileTextField(
                  labelText: 'CONTACT',
                  controller: contactController,
                  onChanged: enableSaveButton,
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
                    onPressed: pickImage,
                    child: const Text('Pick Profile Picture'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[300],
                  child: _profilePicture != null
                      ? Image.file(_profilePicture!, fit: BoxFit.cover)
                      : const Text('Please select an image'),
                ),
                ProfileDropdownFormField(
                  value: selectedGender,
                  labelText: 'GENDER',
                  items: genders,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
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
                  value: selectedSize,
                  labelText: 'T-SHIRT SIZE',
                  items: tshirtSizes,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'T-shirt Size is required';
                    }
                    return null;
                  },
                ),
                ProfileTextField(
                  labelText: 'BIO',
                  maxLines: 3,
                  controller: bioController,
                  onChanged: enableSaveButton,
                ),
                ProfileDropdownFormField(
                  value: degree,
                  labelText: 'EDUCATION DEGREE',
                  items: educationDegrees,
                  onChanged: (value) {
                    setState(() {
                      degree = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == 'Choose Degree') {
                      return 'Education Degree is required';
                    }
                    return null;
                  },
                ),
                ProfileTextField(
                  labelText: 'COLLEGE NAME',
                  controller: collegeController,
                  onChanged: enableSaveButton,
                ),
                ProfileTextField(
                  labelText: 'FIELD OF STUDY',
                  controller: fieldController,
                  onChanged: enableSaveButton,
                ),
                ProfileDropdownFormField(
                  value: year.toString(),
                  labelText: 'Graduation Year',
                  items: generateYears(),
                  onChanged: (value) {
                    setState(() {
                      year = int.parse(value!);
                    });
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value == 'Choose Size') {
                      return 'Graduation Year is required';
                    }
                    return null;
                  },
                ),
                ProfileTextField(
                  labelText: 'SKILLS',
                  maxLines: 3,
                  controller: skillsController,
                  onChanged: enableSaveButton,
                ),
                ProfileTextField(
                  labelText: 'GITHUB LINK',
                  controller: githubController,
                  onChanged: enableSaveButton,
                ),
                ProfileTextField(
                  labelText: 'LINKEDIN LINK',
                  controller: linkedinController,
                  onChanged: enableSaveButton,
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(20),
                    color: detailsChanged ? Colors.blue.shade100 : Colors.grey,
                    hoverColor: detailsChanged ? Colors.blue : Colors.grey,
                    onPressed: !detailsChanged
                        ? () {
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
                          }
                        : () async {
                            if (photo != null && resume != null) {
                              await auth.saveData(
                                name: nameController.text,
                                username: nameController.text,
                                email: contactController.text,
                                gender: selectedGender,
                                bio: bioController.text,
                                tShirtSize: selectedSize,
                                degree: degree,
                                college: collegeController.text,
                                field: fieldController.text,
                                passingYear: year.toString(),
                                skills:
                                    skillsController.text.split(',').toList(),
                                linkedin: linkedinController.text,
                                github: githubController.text,
                                photo: photo!,
                                resume: resume!,
                              );
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DashBoard()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Photo and resume not uploaded'),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                    child: detailsChanged
                        ? const Text('Save Profile')
                        : const Text('No Changes'),
                  ),
                ),
                const SizedBox(height: 40.0),
              ],
            )
          : const Row(
              children: [],
            ),
    ));
  }
}

class ProfileDropdownFormField extends StatelessWidget {
  final String? value;
  final String? labelText;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const ProfileDropdownFormField({
    super.key,
    required this.value,
    required this.labelText,
    required this.items,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.01),
          child: Text(labelText!),
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            errorStyle: const TextStyle(color: Colors.redAccent),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            border: const OutlineInputBorder(),
          ),
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty || value == 'Select') {
              return 'Required';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final TextEditingController controller;
  final Function(String) onChanged;

  const ProfileTextField(
      {super.key,
      required this.labelText,
      this.maxLines = 1,
      required this.controller,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.01),
          child: Text(labelText),
        ),
        TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              errorStyle: const TextStyle(color: Colors.redAccent),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              border: const OutlineInputBorder(),
            ),
            maxLines: maxLines,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              return null;
            },
            onChanged: onChanged),
      ],
    );
  }
}

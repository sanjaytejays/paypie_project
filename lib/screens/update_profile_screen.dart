import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paypie_project/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:paypie_project/services/user_service.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  XFile? image;
  File? _image;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userService = context.read<UserService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<UserModel?>(
          future: userService
              .fetchUserProfile(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If the Future is still running, show a loading indicator
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred while fetching data, display an error message
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              // If no user data is available, display a message
              return Text('No user data found');
            } else {
              // If user data is available, display the profile information
              UserModel user = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 40.0,
                      child: CircleAvatar(
                        radius: 38.0,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (image != null)
                              ? Image.file(_image!)
                              : Image.network(user.imageUrl),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController..text = user.name,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: bioController..text = user.bio,
                    decoration: InputDecoration(labelText: 'Bio'),
                  ),
                  TextField(
                    controller: genderController..text = user.gender,
                    decoration: InputDecoration(labelText: 'Gender'),
                  ),
                  TextField(
                    controller: emailController..text = user.email,
                    decoration: InputDecoration(labelText: 'Gender'),
                  ),
                  Row(
                    children: [
                      Text('Date of Birth: ${_selectedDate.toLocal()}'),
                      IconButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null &&
                              pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        icon: Icon(Icons.date_range),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Call the update profile function with the new data
                      userService.updateUserProfile(
                        name: nameController.text,
                        bio: bioController.text,
                        gender: genderController.text,
                        image: image!,
                        email: '',
                        dob: _selectedDate,
                      );

                      // Optionally, you can navigate to the updated profile page or another page
                      Navigator.pop(context);
                    },
                    child: Text('Update Profile'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paypie_project/screens/profile_screen.dart';
import 'package:paypie_project/services/user_service.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController bio = TextEditingController();
  String gender = 'Male';
  final ImagePicker _imagePicker = ImagePicker();
  DateTime _selectedDate = DateTime.now();
  XFile? image;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
    }
  }

  void uploadUserData() async {
    context.read<UserService>().createUserProfile(
        image: image!,
        name: name.text,
        email: email.text,
        bio: bio.text,
        gender: gender,
        dob: _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    // final userProfileProvider = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Upload
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      child: Icon(Icons.photo),
                      radius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Name
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name.text = value;
                  },
                  controller: name,
                ),

                SizedBox(height: 16.0),

                // Email
                TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email.text = value;
                    },
                    controller: email),
                SizedBox(height: 16.0),

                // Bio
                TextFormField(
                  decoration: InputDecoration(labelText: 'Bio'),
                  onChanged: (value) {
                    bio.text = value;
                  },
                  controller: bio,
                ),
                SizedBox(height: 16.0),

                // Gender
                DropdownButtonFormField<String>(
                  value: gender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                SizedBox(height: 16.0),

                // Date of Birth
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
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      uploadUserData();
                      // userProfileProvider.createUserProfile(
                      //     image: image!,
                      //     name: name.text,
                      //     email: email.text,
                      //     bio: bio.text,
                      //     gender: gender,
                      //     dob: _selectedDate);
                      print("Upload");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage1()));
                    } else {
                      print("error");
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

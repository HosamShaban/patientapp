import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  XFile? _image;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? imagePath = _prefs?.getString('profileImage');
    if (imagePath != null) {
      setState(() {
        _image = XFile(imagePath);
      });
    }
  }

  _imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      _saveImage(image);
    }
  }

  _imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      _saveImage(image);
    }
  }

  _saveImage(XFile image) async {
    setState(() {
      _image = image;
    });

    String imagePath = image.path;
    _prefs?.setString('profileImage', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _image != null
                ? FileImage(File(_image!.path)) as ImageProvider<Object>
                : const AssetImage("assets/images/p.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: IconButton(
                color: Colors.black,
                onPressed: () {
                  _imgFromGallery();
                },
                icon:
                    const Icon(Icons.camera_alt, size: 22, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

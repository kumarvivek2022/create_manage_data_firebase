import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class LoginProvider extends ChangeNotifier {

  var email = "";
  var password = "";
  var confirmPassword = "";
  File? _image;
  bool imageShow = false;
  final picker = ImagePicker();
  CollectionReference taskColl =
  FirebaseFirestore.instance.collection('taskcollection');

  ///login

  Future<String> userLogin(
      {BuildContext? context, String? email, String? password}) async {
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return user.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context!).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context!).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
      return "";
    }
  }

  ///registration

  Future<String?>registration({BuildContext? context, String? email, String? password, String? confirmPassword})
  async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        return userCredential.user!.uid.toString();

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
        return "";
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
    }
    return null;
  }



  /// getting the image from camera

  Future<File?> getImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
      print("image path" + _image.toString());
    } else {
      print("No Image Selected");
    }
    notifyListeners();
    return _image;

  }

  ///getting the image from gallery

  Future<File?> getGalleryImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
      print("image path" + _image.toString());
    } else {
      print("No Image Selected");
    }
    notifyListeners();
    return _image;

  }



  /// create firebase request

  Future<void> createTask(String title, String desc, String image) {
    return taskColl.doc("taskdata").update(
      {
        "array": FieldValue.arrayUnion([
          {
            'image': '"${image.toString()}"',
            'Description': desc.toString(),
            'title': title.toString(),
            'task_id': DateTime.now().millisecondsSinceEpoch,
            'task_status': "open"
          }
        ])
      },
    );
  }


  Future<String> uploadDataInFireStore(
      {required BuildContext context,
      required String title,
      required String desc,
      required File imageUrl}) async {
    String fileName = basename(imageUrl.path); // path provider
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("taskImages")
        .child(fileName); // path where you want to store file in firebase
    UploadTask uploadTask =
        storageRef.putFile(_image!); // for uploading the file
    await uploadTask.whenComplete(() async {
      // when uploading completed the you will get file url
      var url = await storageRef.getDownloadURL();
      print("get url -----------> $url");
      if (title.isNotEmpty && desc.isNotEmpty) {   // need to update in UI
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please wait updating details")));
        createTask(title.toString(), desc.toString(), url).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfully Updated")));
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill required fields")));
      }
    }).catchError((onError) {
      log(onError);
    });
    return "";
  }
}

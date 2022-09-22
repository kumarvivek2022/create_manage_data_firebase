import 'dart:io';
import 'package:create_manage_list_firebase/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File? image;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  File? _image;
  // String? imageBase;
  // XFile? photo;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (_, userInfoProvider, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Task Detail"),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("Title *"),
                TextField(controller: titleController),
                const SizedBox(
                  height: 10,
                ),
                const Text("Description *"),
                TextField(
                  controller: descController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          Provider.of<LoginProvider>(context, listen: false)
                              .getImage()
                              .then((value) {
                              _image = value;
                            });
                        },
                        child: const Text("Capture Image *")),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () async {
                          Provider.of<LoginProvider>(context, listen: false)
                              .getGalleryImage()
                              .then((value) {
                              _image = value;
                          });
                        },
                        child: const Text("upload from gallery *")),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: FileImage(_image ?? File('')),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        print("image url ----> $_image");
                        Provider.of<LoginProvider>(context,listen: false)
                            .uploadDataInFireStore(
                                context: context,
                                title: titleController.text,
                                desc: descController.text,
                                imageUrl: _image??File(''));
                      },
                      child: const Text("Submit")),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

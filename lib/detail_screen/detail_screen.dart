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
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (_, userInfoProvider, __) {
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.8),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Center(child: Text("Create Task")),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                 const  Center(
                    child: Text("Add Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const Text("Title *",style: TextStyle(color: Colors.white),),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextField(controller: titleController),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black),
                        hintText: "title",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Description *",style: TextStyle(color: Colors.white),),
                  const SizedBox(height: 20,),
                  // TextField(
                  //   controller: descController,
                  // ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: descController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black),
                        hintText: "title",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: FileImage(_image ?? File('')),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black
                          ),
                            onPressed: () {
                              Provider.of<LoginProvider>(context, listen: false)
                                  .getImage()
                                  .then((value) {
                                _image = value;
                              });
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text("Capture")),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black
                      ),
                        onPressed: () {
                          print("image url ----> $_image");
                          Provider.of<LoginProvider>(context, listen: false)
                              .uploadDataInFireStore(
                                  context: context,
                                  title: titleController.text,
                                  desc: descController.text,
                                  imageUrl: _image ?? File(''));
                        },
                        child: const Text("Submit")),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

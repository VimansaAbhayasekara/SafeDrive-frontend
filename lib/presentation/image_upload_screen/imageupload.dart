import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safedrive/presentation/image_upload_screen/homespare.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:safedrive/screens/Home.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? file;
  bool isFile = false;
  String? downloadUrl;

  final vehicleMakeController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleColourController = TextEditingController();
  final manufacturedYearController = TextEditingController();
  final sparePartNameController = TextEditingController();

  void pickImage(ImageSource source) async {
    XFile? xFileImage = await ImagePicker().pickImage(source: source);
    if (xFileImage == null) return; // User canceled image picking
    File image = File(xFileImage.path);
    setState(() {
      file = image;
      isFile = true;
    });
  }

  Future<void> uploadImage() async {
    List<String> fileNameSplit = file!.path.split('.');
    String fileType = fileNameSplit.last;
    String path =
        'files/${vehicleMakeController.text}-${vehicleModelController.text}.$fileType';

    // Get the file to upload
    final uploadFile = File(file!.path);
    // Upload the file to Firebase Storage
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(uploadFile);
    // Get the download URL
    String downloadUrl = await ref.getDownloadURL();
    setState(() {
      this.downloadUrl = downloadUrl;
    });

    // Show a success message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Successfully Uploaded!'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SafeDrive",
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(54, 62, 70, 1),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ],
            backgroundColor: Colors.grey,
            title: const Text(
              "Add A New Post",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Section for uploading image
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isFile
                          ? FittedBox(
                              fit: BoxFit.contain,
                              child: Image.file(file!),
                            )
                          : Image.asset("assets/images/image preview.jpg"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      pickImage(ImageSource.gallery);
                                    },
                                    child:
                                        const Text("Pick Image From Gallery"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      pickImage(ImageSource.camera);
                                    },
                                    child: const Text(
                                        "Capture Image Using Camera"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 42, 41),
                          minimumSize: const Size(250, 70),
                        ),
                        child: const Text(
                          "Click here to select image ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Form for adding details
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: vehicleMakeController,
                          decoration: const InputDecoration(
                            hintText: "Vehicle Make",
                            fillColor: Colors.black12,
                            hintStyle:
                                TextStyle(color: Colors.indigo, fontSize: 15),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          validator: (val) => val?.isEmpty == true ? "*" : null,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: vehicleModelController,
                          decoration: const InputDecoration(
                            hintText: "Vehicle Model",
                            fillColor: Colors.black12,
                            hintStyle:
                                TextStyle(color: Colors.indigo, fontSize: 15),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          validator: (val) => val?.isEmpty == true ? "*" : null,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: vehicleColourController,
                          decoration: const InputDecoration(
                            hintText: "Vehicle Colour",
                            fillColor: Colors.black12,
                            hintStyle:
                                TextStyle(color: Colors.indigo, fontSize: 15),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          validator: (val) => val?.isEmpty == true ? "*" : null,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: manufacturedYearController,
                          decoration: const InputDecoration(
                            hintText: "Manufactured Year",
                            fillColor: Colors.black12,
                            hintStyle:
                                TextStyle(color: Colors.indigo, fontSize: 15),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          validator: (val) => val?.isEmpty == true ? "*" : null,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: sparePartNameController,
                          decoration: const InputDecoration(
                            hintText: "SparePart Name",
                            fillColor: Colors.black12,
                            hintStyle:
                                TextStyle(color: Colors.indigo, fontSize: 15),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          validator: (val) => val?.isEmpty == true ? "*" : null,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isButtonDisabled()
                              ? null
                              : () async {
                                  // Call the method to upload image
                                  await uploadImage();
                                  // Add functionality for confirm details
                                  CollectionReference collref =
                                      FirebaseFirestore.instance
                                          .collection('imageData');
                                  collref.add({
                                    'vehicleMake': vehicleMakeController.text,
                                    'vehicleModel': vehicleModelController.text,
                                    'vehicleColour':
                                        vehicleColourController.text,
                                    'manufacturedYear':
                                        manufacturedYearController.text,
                                    'sparePartName':
                                        sparePartNameController.text,
                                    'imageID': downloadUrl,

                                    // add download image url here
                                  });
                                  print(downloadUrl);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            minimumSize: const Size(250, 70),
                          ),
                          child: const Text(
                            "Confirm Details and Upload",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isButtonDisabled() {
    return vehicleMakeController.text.isEmpty ||
        vehicleModelController.text.isEmpty ||
        vehicleColourController.text.isEmpty ||
        manufacturedYearController.text.isEmpty ||
        sparePartNameController.text.isEmpty;
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:safedrive/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PrePost());
}

class PrePost extends StatelessWidget {
  const PrePost({Key? key}) : super(key: key);

  Widget buildDataLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 210, 213, 152)),
    );
  }

  Future<void> _updateDocument(
      String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('imageData')
        .doc(documentId)
        .update(data);
  }

  Future<void> _deleteDocument(BuildContext context, String documentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('imageData')
                    .doc(documentId)
                    .delete();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 62, 70, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text('Previous Post'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('imageData').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              final Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              TextEditingController vehicleMakeController =
                  TextEditingController(text: data['vehicleMake']);
              TextEditingController vehicleModelController =
                  TextEditingController(text: data['vehicleModel']);
              TextEditingController vehicleColourController =
                  TextEditingController(text: data['vehicleColour']);
              TextEditingController manufacturedYearController =
                  TextEditingController(
                      text: data['manufacturedYear'] != null
                          ? data['manufacturedYear'].toString()
                          : '');
              TextEditingController sparePartNameController =
                  TextEditingController(text: data['sparePartName']);

              String? imageURL = data['imageID'];

              return Card(
                color: Color.fromARGB(255, 103, 106, 85),
                elevation: 3,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildDataLabel("Vehicle Make"),
                      Text('${vehicleMakeController.text}'),
                      SizedBox(height: 5),
                      buildDataLabel("Vehicle Model"),
                      Text('${vehicleModelController.text}'),
                      SizedBox(height: 5),
                      buildDataLabel("Vehicle Colour"),
                      Text('${vehicleColourController.text}'),
                      SizedBox(height: 5),
                      buildDataLabel("Manufactured Year"),
                      Text('${manufacturedYearController.text}'),
                      SizedBox(height: 5),
                      buildDataLabel("SparePart Name"),
                      Text('${sparePartNameController.text}'),
                      SizedBox(height: 10),
                      // Display the image using Image.network if imageURL is not null
                      if (imageURL != null)
                        Image.network(
                          imageURL,
                          height: 100, // Adjust height as needed
                          width: 100, // Adjust width as needed
                        )
                      else
                        const Text('No image URL found',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 222, 6, 6))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Edit Data"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: vehicleMakeController,
                                          decoration: InputDecoration(
                                              labelText: "Vehicle Make"),
                                        ),
                                        TextFormField(
                                          controller: vehicleModelController,
                                          decoration: InputDecoration(
                                              labelText: "Vehicle Model"),
                                        ),
                                        TextFormField(
                                          controller: vehicleColourController,
                                          decoration: InputDecoration(
                                              labelText: "Vehicle Colour"),
                                        ),
                                        TextFormField(
                                          controller:
                                              manufacturedYearController,
                                          decoration: InputDecoration(
                                              labelText: "Manufactured Year"),
                                        ),
                                        TextFormField(
                                          controller: sparePartNameController,
                                          decoration: InputDecoration(
                                              labelText: "SparePart Name"),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _updateDocument(document.id, {
                                            'vehicleMake':
                                                vehicleMakeController.text,
                                            'vehicleModel':
                                                vehicleModelController.text,
                                            'vehicleColour':
                                                vehicleColourController.text,
                                            'manufacturedYear':
                                                manufacturedYearController
                                                        .text.isNotEmpty
                                                    ? int.parse(
                                                        manufacturedYearController
                                                            .text)
                                                    : null,
                                            'sparePartName':
                                                sparePartNameController.text,
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Save"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Update'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _deleteDocument(context, document.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

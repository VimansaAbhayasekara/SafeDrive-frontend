import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safedrive/repository/repository.dart';
import 'package:safedrive/services/services.dart';

import '../../models/models.dart';
import '../screens.dart';
import 'widgets/details_card.dart';

class MyVehicle extends StatefulWidget {
  const MyVehicle({super.key});

  @override
  State<MyVehicle> createState() => _MyVehicleState();
}

class _MyVehicleState extends State<MyVehicle> {
  List<Map<String, String>> categories = [
    {
      "label": "Documents",
      "value": "DOCUMENTS",
    },
    {
      "label": "Spare Parts",
      "value": "SPARE_PARTS",
    },
    {
      "label": "Service Records",
      "value": "SERVICE_RECORDS",
    }
  ];

  int selectedCategory = 0;
  List<VehicleDetails> vehicleDetails = [];

  @override
  void initState() {
    super.initState();
    _getVehicleDetails(categories[selectedCategory]['value'].toString());
  }

  @override
  void dispose() {
    vehicleDetails = [];
    super.dispose();
  }

  _getVehicleDetails(String category) async {
    vehicleDetails =
        await VehicleDetailsRepository().getVehicleDetailsByCategory(category);
    setState(() {});
  }

  Future<void> deleteVehicleDetails(String vehicleDetailsId) async {
    APIResponse response =
        await VehicleDetailsRepository().delete(vehicleDetailsId);
    if (response.status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
        ),
      );
    }
  }

  Future<void> logout() async {
    await TokenService().deleteToken();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Login()));
  }

  Future<void> refreshData(String refresh) async {
    if (refresh == "refresh") {
      _getVehicleDetails(categories[selectedCategory]['value'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'My Vehicle',
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: logout,
            child: Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.040,
              ),
              child: const Icon(
                Iconsax.logout,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 12,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (itemBuilder, index) => Container(
                  margin: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                      _getVehicleDetails(categories[index]['value'].toString());
                    },
                    child: Container(
                      decoration: (index == selectedCategory)
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xff35C2C1),
                                  width: 2.0,
                                ),
                              ),
                            )
                          : null,
                      margin: EdgeInsets.symmetric(
                        horizontal: size.width / 20,
                      ),
                      child: Text(
                        categories[index]['label'].toString(),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.040,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.74,
              child: ListView.builder(
                itemCount: vehicleDetails.length,
                itemBuilder: (itemBuilder, index) => Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) =>
                      deleteVehicleDetails(vehicleDetails[index].id.toString()),
                  background: Container(
                    width: size.width,
                    height: size.height * 0.5,
                    margin: const EdgeInsets.all(10),
                    padding: EdgeInsets.all(size.width * 0.040),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.040),
                      color: Colors.redAccent.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.040,
                      ),
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: DetailsCard(
                    vehicleDetails: vehicleDetails[index],
                    onTap: () async {
                      String refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateVehicleDetails(
                              vehicleDetails: vehicleDetails[index]),
                        ),
                      );
                      refreshData(refresh);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          String refresh = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddVehicleDetails(
                category: categories[selectedCategory]['value'].toString(),
              ),
            ),
          );

          refreshData(refresh);
        },
        child: Container(
          padding: EdgeInsets.all(size.width * 0.040),
          decoration: BoxDecoration(
            color: const Color(0xff35C2C1),
            borderRadius: BorderRadius.circular(size.width * 0.070),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: size.width * 0.060,
          ),
        ),
      ),
    );
  }
}

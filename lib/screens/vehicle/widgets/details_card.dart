import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safedrive/models/models.dart';
import 'package:intl/intl.dart';
class DetailsCard extends StatelessWidget {

  final VehicleDetails vehicleDetails;
  final Function()? onTap;

  const DetailsCard({
    super.key,
    required this.vehicleDetails,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(size.width * 0.040),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(size.width * 0.040),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicleDetails.description.toString(),
              style: GoogleFonts.urbanist(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.010,
            ),
            Text(
              "Last Update : ${ DateFormat.yMMMMd().format(DateTime.parse(vehicleDetails.installationDate.toString())) }",
              style: GoogleFonts.urbanist(
                fontSize: size.width * 0.040,
              ),
            ),
            Text(
              "Renewal Date : ${ DateFormat.yMMMMd().format(DateTime.parse(vehicleDetails.renewalDate.toString())) }",
              style: GoogleFonts.urbanist(
                fontSize: size.width * 0.040,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

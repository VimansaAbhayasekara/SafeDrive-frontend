import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:safedrive/models/models.dart';
import 'package:safedrive/repository/repository.dart';

import '../widgets/widgets.dart';

class AddVehicleDetails extends StatefulWidget {
  final String category;

  const AddVehicleDetails({
    super.key,
    required this.category,
  });

  @override
  State<AddVehicleDetails> createState() => _AddVehicleDetailsState();
}

class _AddVehicleDetailsState extends State<AddVehicleDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _updateDateController = TextEditingController();
  final TextEditingController _renewalDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController _controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _controller.text = DateFormat.yMMMMEEEEd().format(picked);
      });
    }
  }

  Future<void> handleForm() async {
    if (_formKey.currentState!.validate()) {
      APIResponse response = await VehicleDetailsRepository().create(
        widget.category,
        _descriptionController.text,
        DateFormat('yyyy-MM-dd').format(DateFormat('EEEE, MMMM dd, yyyy')
            .parse(_updateDateController.text)),
        DateFormat('yyyy-MM-dd').format(DateFormat('EEEE, MMMM dd, yyyy')
            .parse(_renewalDateController.text)),
      );
      if (response.status) {
        _descriptionController.clear();
        _updateDateController.clear();
        _renewalDateController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
        Navigator.pop(context, 'refresh');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _updateDateController.dispose();
    _renewalDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Vehicle Details",
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                 SizedBox(
                  height: size.height * 0.040,
                ),
                CustomInput(
                  hintLabel: "Description",
                  maxLines: 5,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context, _updateDateController);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CustomInput(
                      hintLabel: 'Last Updated Date',
                      enabled: false,
                      controller: _updateDateController,
                      suffixIcon: const Icon(Icons.date_range),
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.urbanist(
                        color: Colors.black87,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last updated date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.020,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context, _renewalDateController);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: CustomInput(
                      hintLabel: 'Renewal Date',
                      enabled: false,
                      controller: _renewalDateController,
                      suffixIcon: const Icon(Icons.date_range),
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.urbanist(
                        color: Colors.black87,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Renewal date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.030,
                ),
                CustomButton(
                  title: "Done",
                  onPressed: handleForm,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

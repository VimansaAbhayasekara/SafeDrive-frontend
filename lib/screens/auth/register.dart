import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safedrive/models/models.dart';
import 'package:safedrive/screens/widgets/widgets.dart';
import '../../repository/repository.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _businessLicenseNumberController =
      TextEditingController();

  bool isVisible = true;
  bool confirmPassIsVisible = true;
  String accountType = "";
  String selectedProvince = "";

  List<Map<String, String>> provinces = [];
  List<Map<String, String>> districts = [];

  Future<void> handleForm() async {
    if (_formKey.currentState!.validate()) {
      APIResponse response = await AuthRepository().register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _accountTypeController.text,
        _provinceController.text,
        _districtController.text,
        _mobileNumberController.text,
        _businessLicenseNumberController.text,
      );



      if (response.status) {
        CollectionReference collref = FirebaseFirestore.instance.collection('user');
        await collref.add({
          'email' : _emailController.text,
          'AccType': _accountTypeController.text,
          // Add other fields as necessary
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.message),
        ));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _accountTypeController.dispose();
    _mobileNumberController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _businessLicenseNumberController.dispose();
    super.dispose();
  }

  Future<void> loadJsonData() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/provinces.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, String>> loadedData = jsonList.map((json) {
      return {
        "name": json['name'].toString(),
        "value": json['name'].toString(),
      };
    }).toList();

    setState(() {
      provinces = loadedData;
    });
  }

  Future<void> loadDistricts() async {
    if (selectedProvince == "") return;
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/provinces.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    var data = jsonList
        .where((element) => element['name'] == selectedProvince)
        .take(1);
    List<dynamic> dataList = data.first['districts'];
    List<Map<String, String>> loadedData = dataList.map((json) {
      return {
        "name": json.toString(),
        "value": json.toString(),
      };
    }).toList();

    setState(() {
      districts = loadedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: GoogleFonts.urbanist(
                            fontSize: size.width * 0.060,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Register to get started...",
                          style: GoogleFonts.urbanist(
                            fontSize: size.width * 0.060,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomDropDown(
                    hintLabel: "Select the account type",
                    controller: _accountTypeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Account type is required";
                      }
                      return null;
                    },
                    onSelectedValue: (value) {
                      _accountTypeController.text = value['value']!;
                      setState(() {
                        accountType = value['value']!;
                      });
                    },
                    items: const [
                      {'name': 'Vehicle Owner', 'value': 'Vehicle Owner'},
                      {'name': "Supplier", 'value': "Supplier"},
                      {'name': "Service Center", 'value': "Service Center"}
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomInput(
                    hintLabel: "Name",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomInput(
                    hintLabel: "E-mail",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail is required';
                      }
                      if (value.isNotEmpty && !value.contains('@')) {
                        return 'E-mail is badly formatted';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomInput(
                    hintLabel: "Mobile Number",
                    controller: _mobileNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mobile number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomDropDown(
                    hintLabel: "Select the Province",
                    controller: _provinceController,
                    onSelectedValue: (value) {
                      _provinceController.text = value['value']!;
                      _districtController.clear();
                      setState(() {
                        selectedProvince = value['value']!;
                      });
                      setState(() {
                        districts = [];
                      });
                      loadDistricts();
                    },
                    items: provinces,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Province is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomDropDown(
                    hintLabel: "Select the District",
                    controller: _districtController,
                    onSelectedValue: (value) {
                      _districtController.text = value['value']!;
                    },
                    items: districts,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'District is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  (accountType != "Vehicle Owner" && accountType != "")
                      ? Column(
                          children: [
                            CustomInput(
                              hintLabel: "Business License Number",
                              controller: _businessLicenseNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Business license number is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                          ],
                        )
                      : Container(),
                  CustomInput(
                    hintLabel: "Password",
                    obscureText: isVisible,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Icon(
                        !isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomInput(
                    hintLabel: "Confirm Password",
                    obscureText: confirmPassIsVisible,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (value != _passwordController.text) {
                        return 'Confirm Password is not match';
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          confirmPassIsVisible = !confirmPassIsVisible;
                        });
                      },
                      child: Icon(
                        !confirmPassIsVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  CustomButton(
                    title: "Sign Up",
                    onPressed: handleForm
                  ),
                  SizedBox(
                    height: size.height * 0.020,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.urbanist(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "Login Now",
                          style: GoogleFonts.urbanist(
                            color: const Color(0xff35C2C1),
                            fontSize: size.width * 0.045,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';
import '../../Widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final phoneController = TextEditingController();

  // Country Picker (Packege):
  Country selectedCountry = Country(
    phoneCode: '92',
    countryCode: 'PK',
    e164Sc: 0,
    geographic: true,
    level: 1, // Necessary till here.
    name: 'Pakistan',
    example: 'Pakistan',
    displayName: 'Pakistan',
    displayNameNoCountryCode: 'PK',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    // For not reversing the text of field because of onChange in textField:
    // phoneController.selection = TextSelection.fromPosition(
    //   TextPosition(offset: phoneController.text.length),
    // );

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.purple.shade50, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/image2.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text('Register',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text(
                    "Add your phone number. We'll send you a verification code.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    onChanged: (value) {
                      setState(() {
                        // phoneController.text = value;
                      });
                    },
                    cursorColor: Colors.purple,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        hintText: 'Enter Phone Number',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.black12)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.black12)),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: InkWell(
                            onTap: () {
                              // Show Country Picker Method:

                              showCountryPicker(
                                  context: context,
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  },
                                  countryListTheme: const CountryListThemeData(
                                      bottomSheetHeight: 550));
                            },
                            child: Text(
                              '${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        suffixIcon: phoneController.text.length > 9
                            ? Icon(
                                Icons.done,
                                color: Colors.green.shade700,
                              )
                            : null),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      onPressed: () => sendPhoneNumber(),
                      text: 'Login',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, '+${selectedCountry.phoneCode}$phoneNumber');
  }
}

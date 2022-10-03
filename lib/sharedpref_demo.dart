import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_demo/model.dart';

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({super.key});

  @override
  State<SharedPreferencesDemo> createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countyController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ProfileDetails _profileDetails = ProfileDetails();

  @override
  void initState() {
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      if (prefs.containsKey('profile')) {
        _profileDetails = ProfileDetails.fromJson(
            jsonDecode(prefs.getString('profile') ?? ''));

        _firstNameController.text = _profileDetails.firstName!;
        _middleNameController.text = _profileDetails.middleName!;
        _lastNameController.text = _profileDetails.lastName!;
        _phoneNumberController.text = _profileDetails.phoneNumber.toString();
        _houseNumberController.text = _profileDetails.houseNumber.toString();
        _streetAddressController.text = _profileDetails.streetName!;
        _cityController.text = _profileDetails.city!;
        _countyController.text = _profileDetails.county!;
      } else {
        debugPrint("Key doesn't exist");
      }
    });
  }

  bool _isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences Demo"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isEnabled = !_isEnabled;
                });
              },
              icon: Icon(_isEnabled ? Icons.check : Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: _firstNameController,
                hintText: 'First Name',
                isEnable: _isEnabled,
              ),
              CustomTextField(
                controller: _middleNameController,
                hintText: 'Middle Name',
                isEnable: _isEnabled,
              ),
              CustomTextField(
                controller: _lastNameController,
                hintText: 'Last Name',
                isEnable: _isEnabled,
              ),
              CustomTextField(
                controller: _phoneNumberController,
                hintText: 'Phone Number',
                prefixIcon: Icons.phone,
                maxLength: 14,
                textInputType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                isEnable: _isEnabled,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomTextField(
                      hintText: 'House Number',
                      controller: _houseNumberController,
                      prefixIcon: Icons.home,
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      isEnable: _isEnabled,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 2,
                    child: CustomTextField(
                      hintText: 'Street Address',
                      controller: _streetAddressController,
                      prefixIcon: Icons.map_outlined,
                      isEnable: _isEnabled,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                controller: _cityController,
                hintText: 'City',
                prefixIcon: Icons.location_city,
                isEnable: _isEnabled,
              ),
              CustomTextField(
                controller: _countyController,
                hintText: 'County',
                isEnable: _isEnabled,
                prefixIcon: Icons.wrong_location_outlined,
              ),
              ElevatedButton(
                  onPressed: () async {
                    _profileDetails = ProfileDetails(
                        firstName: _firstNameController.text,
                        middleName: _middleNameController.text,
                        lastName: _lastNameController.text,
                        phoneNumber: int.parse(_phoneNumberController.text),
                        houseNumber: int.parse(_houseNumberController.text),
                        streetName: _streetAddressController.text,
                        city: _cityController.text,
                        county: _countyController.text,
                        entryDate: DateTime.now().toString(),
                        updateDate: DateTime.now().toString());

                    String jsonString = jsonEncode(_profileDetails);

                    final SharedPreferences prefs = await _prefs;
                    prefs.setString('profile', jsonString);
                  },
                  child: const Text("Save Values"))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.prefixIcon = Icons.person,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.maxLength,
      required this.isEnable});
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool isEnable;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        enabled: widget.isEnable,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: widget.isEnable
                ? IconButton(
                    onPressed: (() {
                      widget.controller.clear();
                    }),
                    icon: const Icon(Icons.cancel_outlined),
                  )
                : null,
            // counterText: '',
            prefixIcon: Icon(widget.prefixIcon),
            hintText: widget.hintText),
      ),
    );
  }
}

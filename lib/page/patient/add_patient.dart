import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthcare_prediction/page/patient/add_patient_provider.dart';
import 'package:healthcare_prediction/custom_textfield/configs/decoration_config.dart';
import 'package:healthcare_prediction/custom_textfield/configs/textfield_config.dart';
import 'package:healthcare_prediction/custom_textfield/shadow_textfield.dart';
import 'package:healthcare_prediction/page/patient/patient_model.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key, required this.socket, required this.length})
      : super(key: key);
  final Socket socket;
  final int length;

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add patient'),
      ),
      body: ChangeNotifierProvider<AddPatientProvider>(
        create: (_) => AddPatientProvider(),
        child: Consumer<AddPatientProvider>(
          builder: (context, providerVal, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNumberInput(providerVal),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDropDown(providerVal),
                          SizedBox(width: 20),
                          _buildCheckBox(providerVal),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                providerVal.submit(widget.length).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            value != null
                                                ? Icons.warning_rounded
                                                : Icons.done,
                                            color: value != null
                                                ? Colors.yellow[600]
                                                : Colors.lightBlue,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 10),
                                            child: Text(
                                              value ?? "Submit Successfully",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  if (value == null) {
                                    Navigator.pop(
                                        context, providerVal.patientModel);
                                    widget.socket.write(
                                        'send:${providerVal.patientModel.toString()}');
                                    // print(providerVal.patientModel.toString());
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Expanded _buildCheckBox(AddPatientProvider providerVal) {
    return Expanded(
      child: Column(
        children: [
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                "Hypertension",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: providerVal.hypertension,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                providerVal.hypertension = value ?? false;
              }),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                "Heart disease",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: providerVal.heartDisease,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                providerVal.heartDisease = value ?? false;
              }),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                "Ever married",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: providerVal.everMarried,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                providerVal.everMarried = value ?? false;
              }),
        ],
      ),
    );
  }

  Container _buildDropDown(AddPatientProvider providerVal) {
    return Container(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Gender>(
                  isExpanded: true,
                  hint: Text("Gender",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                  items: Gender.values
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.value(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )))
                      .toList(),
                  value: providerVal.gender,
                  onChanged: (value) {
                    providerVal.gender = value;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: 160,
            child: Material(
              color: Colors.transparent,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SmokingStatus>(
                    isExpanded: true,
                    hint: Text("Smoking",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    items: SmokingStatus.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        .toList(),
                    value: providerVal.smokingStatus,
                    onChanged: (value) {
                      providerVal.smokingStatus = value;
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: 160,
            child: Material(
              color: Colors.transparent,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<WorkType>(
                    isExpanded: true,
                    hint: Text("Work Type",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    items: WorkType.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        .toList(),
                    value: providerVal.workType,
                    onChanged: (value) {
                      providerVal.workType = value;
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: 160,
            child: Material(
              color: Colors.transparent,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ResidenceType>(
                    isExpanded: true,
                    hint: Text("Residence",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    items: ResidenceType.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        .toList(),
                    value: providerVal.residenceType,
                    onChanged: (value) {
                      providerVal.residenceType = value;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildNumberInput(AddPatientProvider providerVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          child: ShadowTextField(
            textFieldConfig: TextFieldConfig(
                controller: providerVal.ageController,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onChanged: (value) {
              if (value.isEmpty) {
                providerVal.ageController.text = '0';
                providerVal.ageController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.ageController.text.length));
              } else if (value.length > 1 &&
                  value[0] == '0' &&
                  !value.contains('.')) {
                providerVal.ageController.text = value.substring(1);
                providerVal.ageController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.ageController.text.length));
              }
            },
            decorationConfig: TextFieldDecorationConfig(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                labelText: "Age",
                labelStyle: TextStyle(fontSize: 14)),
            textFieldType: TextFieldType.number,
            validator: TextFieldValidatorUtils.validateText,
          ),
        ),
        Container(
          width: 120,
          child: ShadowTextField(
            textFieldConfig: TextFieldConfig(
                controller: providerVal.avgGlucoseController,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onChanged: (value) {
              if (value.isEmpty) {
                providerVal.avgGlucoseController.text = '0';
                providerVal.avgGlucoseController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.avgGlucoseController.text.length));
              } else if (value.length > 1 &&
                  value[0] == '0' &&
                  !value.contains('.')) {
                providerVal.avgGlucoseController.text = value.substring(1);
                providerVal.avgGlucoseController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.avgGlucoseController.text.length));
              }
            },
            decorationConfig: TextFieldDecorationConfig(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                labelText: "Avg glucose",
                labelStyle: TextStyle(fontSize: 14)),
            textFieldType: TextFieldType.number,
            validator: TextFieldValidatorUtils.validateText,
          ),
        ),
        Container(
          width: 100,
          child: ShadowTextField(
            textFieldConfig: TextFieldConfig(
                controller: providerVal.bmiController,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onChanged: (value) {
              if (value.isEmpty) {
                providerVal.bmiController.text = '0';
                providerVal.bmiController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.bmiController.text.length));
              } else if (value.length > 1 &&
                  value[0] == '0' &&
                  !value.contains('.')) {
                providerVal.bmiController.text = value.substring(1);
                providerVal.bmiController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.bmiController.text.length));
              }
            },
            decorationConfig: TextFieldDecorationConfig(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                labelText: "Bmi",
                labelStyle: TextStyle(fontSize: 14)),
            textFieldType: TextFieldType.number,
            validator: TextFieldValidatorUtils.validateText,
          ),
        ),
      ],
    );
  }
}

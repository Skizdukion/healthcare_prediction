import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:healthcare_prediction/page/patient/patient_model.dart';
import 'package:uuid/uuid.dart';

class AddPatientProvider with ChangeNotifier {
  Gender? _gender;
  Gender? get gender => _gender;
  PatientModel? patientModel;
  set gender(Gender? value) {
    _gender = value;
    notifyListeners();
  }

  late final TextEditingController ageController;
  late final TextEditingController avgGlucoseController;
  late final TextEditingController bmiController;

  bool _hypertension = false;
  bool get hypertension => _hypertension;
  set hypertension(bool value) {
    _hypertension = value;
    notifyListeners();
  }

  bool _heartDisease = false;
  bool get heartDisease => _heartDisease;
  set heartDisease(bool value) {
    _heartDisease = value;
    notifyListeners();
  }

  bool _everMarried = false;
  bool get everMarried => _everMarried;
  set everMarried(bool value) {
    _everMarried = value;
    notifyListeners();
  }

  WorkType? _workType;
  WorkType? get workType => _workType;
  set workType(WorkType? value) {
    _workType = value;
    notifyListeners();
  }

  ResidenceType? _residenceType;
  ResidenceType? get residenceType => _residenceType;
  set residenceType(ResidenceType? value) {
    _residenceType = value;
    notifyListeners();
  }

  SmokingStatus? _smokingStatus;
  AddPatientProvider() {
    ageController = TextEditingController();
    avgGlucoseController = TextEditingController();
    bmiController = TextEditingController();
    ageController.text = '0';
    avgGlucoseController.text = '0';
    bmiController.text = '0';
  }
  SmokingStatus? get smokingStatus => _smokingStatus;
  set smokingStatus(SmokingStatus? value) {
    _smokingStatus = value;
    notifyListeners();
  }

  Future<String?> submit(int length) {
    if (double.parse(ageController.text) == 0) {
      return Future.value('Your age invalid');
    }
    if (double.parse(avgGlucoseController.text) == 0) {
      return Future.value('Your avg glucose invalid');
    }
    if (double.parse(bmiController.text) == 0) {
      return Future.value('Your Bmi invalid');
    }
    if (gender == null) {
      return Future.value('Please choose your gender');
    }
    if (smokingStatus == null) {
      return Future.value('Please choose your smoking status');
    }
    if (workType == null) {
      return Future.value('Please choose your work type');
    }
    if (residenceType == null) {
      return Future.value('Please choose your residence type');
    }
    patientModel = PatientModel(
        id: (length + 1).toString(),

        gender: gender!,
        age: double.parse(ageController.text),
        hypertension: hypertension,
        heartDisease: heartDisease,
        everMarried: everMarried,
        workType: workType!,
        residenceType: residenceType!,
        avgGlucoseLevel: double.parse(avgGlucoseController.text),
        bmi: double.parse(bmiController.text),
        smokingStatus: smokingStatus!);
    // FirebaseFirestore.instance.collection('patients').add(patient.toJson());
    return Future.value(null);
  }

  // String generateId(){
  //   return Random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
  // }
}

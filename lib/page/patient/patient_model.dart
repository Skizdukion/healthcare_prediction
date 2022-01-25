class PatientModel {
  String? id;
  Gender gender;
  double age;
  bool hypertension;
  bool heartDisease;
  bool everMarried;
  WorkType workType;
  ResidenceType residenceType;
  double avgGlucoseLevel;
  double bmi;
  SmokingStatus smokingStatus;
  bool? strokePredict;
  PatientModel(
      {this.id,
      required this.gender,
      required this.age,
      required this.hypertension,
      required this.heartDisease,
      required this.everMarried,
      required this.workType,
      required this.residenceType,
      required this.avgGlucoseLevel,
      required this.bmi,
      required this.smokingStatus,
      this.strokePredict});

  // TODO: add convert
  @override
  String toString() {
    return '$id, ${gender.toInt()}, $age, ${hypertension ? 1 : 0}, ${heartDisease ? 1 : 0}, ${everMarried ? '0' : '1'}, ${workType.toInt()}, ${residenceType.toInt()}, $avgGlucoseLevel, $bmi, ${smokingStatus.toInt()}';
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender.value(),
      'age': age,
      'hypertension': hypertension,
      'heartDisease': heartDisease,
      'everMarried': everMarried,
      'workType': workType.value(),
      'residenceType': residenceType.value(),
      'avgGlucoseLevel': avgGlucoseLevel,
      'bmi': bmi,
      'smokingStatus': smokingStatus.value(),
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      gender: Gender.values.firstWhere((e) => e.value() == json['gender']),
      age: json['age']?.toDouble() ?? 0,
      hypertension: json['hypertension'] ?? false,
      heartDisease: json['heartDisease'] ?? false,
      everMarried: json['everMarried'] ?? false,
      workType:
          WorkType.values.firstWhere((e) => e.value() == json['workType']),
      residenceType: ResidenceType.values
          .firstWhere((e) => e.value() == json['residenceType']),
      avgGlucoseLevel: json['avgGlucoseLevel']?.toDouble() ?? 0.0,
      bmi: json['bmi']?.toDouble() ?? 0.0,
      smokingStatus: SmokingStatus.values
          .firstWhere((e) => e.value() == json['smokingStatus']),
    );
  }

  PatientModel copyWith({
    String? id,
    Gender? gender,
    double? age,
    bool? hypertension,
    bool? heartDisease,
    bool? everMarried,
    WorkType? workType,
    ResidenceType? residenceType,
    double? avgGlucoseLevel,
    double? bmi,
    SmokingStatus? smokingStatus,
    bool? strokePredict,
  }) {
    return PatientModel(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      hypertension: hypertension ?? this.hypertension,
      heartDisease: heartDisease ?? this.heartDisease,
      everMarried: everMarried ?? this.everMarried,
      workType: workType ?? this.workType,
      residenceType: residenceType ?? this.residenceType,
      avgGlucoseLevel: avgGlucoseLevel ?? this.avgGlucoseLevel,
      bmi: bmi ?? this.bmi,
      smokingStatus: smokingStatus ?? this.smokingStatus,
      strokePredict: strokePredict ?? this.strokePredict,
    );
  }
}

enum Gender { male, female }

extension GenderExt on Gender {
  String value() {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }

  String toInt() {
    switch (this) {
      case Gender.male:
        return '1';
      case Gender.female:
        return '0';
    }
  }
}

enum WorkType { children, selfEmployed, private, neverWorked, govtJob }

extension WorkTypeExt on WorkType {
  String value() {
    switch (this) {
      case WorkType.children:
        return 'children';
      case WorkType.selfEmployed:
        return 'Self-employed';
      case WorkType.private:
        return 'Private';
      case WorkType.neverWorked:
        return 'Never_worked';
      case WorkType.govtJob:
        return 'Govt_job';
    }
  }

  String toInt() {
    switch (this) {
      case WorkType.children:
        return '2';
      case WorkType.selfEmployed:
        return '1';
      case WorkType.private:
        return '0';
      case WorkType.neverWorked:
        return '4';
      case WorkType.govtJob:
        return '3';
    }
  }
}

enum ResidenceType { urban, rural }

extension ResidencetypeExt on ResidenceType {
  String value() {
    switch (this) {
      case ResidenceType.urban:
        return 'Urban';
      case ResidenceType.rural:
        return 'Rural';
    }
  }

  String toInt() {
    switch (this) {
      case ResidenceType.urban:
        return '0';
      case ResidenceType.rural:
        return '1';
    }
  }
}

enum SmokingStatus { smokes, neverSmoked, formerlySmoked, unknown }

extension SmokingStatusExt on SmokingStatus {
  String value() {
    switch (this) {
      case SmokingStatus.smokes:
        return 'smokes';
      case SmokingStatus.neverSmoked:
        return 'never smoked';
      case SmokingStatus.formerlySmoked:
        return 'formerly smoked';
      case SmokingStatus.unknown:
        return 'Unknown';
    }
  }

  String toInt() {
    switch (this) {
      case SmokingStatus.smokes:
        return '3';
      case SmokingStatus.neverSmoked:
        return '0';
      case SmokingStatus.formerlySmoked:
        return '2';
      case SmokingStatus.unknown:
        return '1';
    }
  }
}

extension StringExt on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

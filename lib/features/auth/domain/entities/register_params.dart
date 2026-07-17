/// Role chosen at registration (sent to the API by name: "Individual"/"Coach").
enum SignupRole {
  individual('Individual'),
  coach('Coach');

  const SignupRole(this.wire);
  final String wire;
}

/// Gender sent by name.
enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  const Gender(this.wire);
  final String wire;
}

/// Training goal sent by name.
enum DevelopmentDirection {
  strength('Strength'),
  hypertrophy('Hypertrophy'),
  fatLoss('FatLoss'),
  recomposition('Recomposition'),
  endurance('Endurance'),
  generalHealth('GeneralHealth');

  const DevelopmentDirection(this.wire);
  final String wire;
}

/// Main training style sent by name.
enum TrainingDiscipline {
  powerlifting('Powerlifting'),
  bodybuilding('Bodybuilding'),
  weightlifting('Weightlifting'),
  calisthenics('Calisthenics'),
  crossFit('CrossFit'),
  running('Running'),
  generalFitness('GeneralFitness');

  const TrainingDiscipline(this.wire);
  final String wire;
}

/// Inputs for `POST /api/auth/register`.
class RegisterParams {
  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.developmentDirection,
    required this.trainingDiscipline,
    this.height,
    this.bodyweight,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final SignupRole role;
  final Gender gender;
  final DateTime dateOfBirth;
  final DevelopmentDirection developmentDirection;
  final TrainingDiscipline trainingDiscipline;
  final double? height;
  final double? bodyweight;
}

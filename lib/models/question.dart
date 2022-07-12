class Questions {
  static List<String> long = ['Quality of sleep', 'General muscle soreness', 'Overall mood', 'Fatigue level', 'Stress level'];
  static List<String> short = ['Sleep', 'Muscles', 'Mood', 'Fatigue', 'Stress'];
  static List<List<String>> options = [
    ['Insomnia', 'More tired than normal', 'Normal', 'Fresh', 'Very Fresh'],
    ['Very Sore']
  ];
}

class Question {
  final String long;
  final String short;
  final List<String> responses;

  Question({required this.long, required this.short, required this.responses});
}

List<Question> myQuestions = [
  Question(
    long: 'Fatigue',
    short: 'Fatigue',
    responses: ['Always tired', 'More tired than normal', 'Normal', 'Fresh', 'Very fresh'],
  ),
  Question(
    long: 'Quality of sleep',
    short: 'Sleep',
    responses: ['Insomnia', 'More tired than normal', 'Normal', 'Fresh', 'Very fresh'],
  ),
  Question(
    long: 'General Muscle Soreness',
    short: 'Muscles',
    responses: ['Very sore', 'Increase in soreness/tightness', 'Normal', 'Feeling good', 'Feeling great'],
  ),
  Question(
    long: 'Stress Levels',
    short: 'Stress',
    responses: ['Highly stressed', 'Feeling stressed', 'Normal', 'Relaxed', 'Very relaxed'],
  ),
  Question(
    long: 'Overall mood',
    short: 'Mood',
    responses: ['Highly annoyed/irritable/down', 'Snappiness at team members', 'Less interested in others/activities than normal', 'A generally good mood', 'Very positive mood'],
  ),
];

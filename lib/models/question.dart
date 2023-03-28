class Question {
  final String long;
  final String short;
  final List<String> responses;

  Question({required this.long, required this.short, required this.responses});
}

List<Question> myQuestions = [
  Question(
    long: 'How fatigued are you feeling today?',
    short: 'Fatigue',
    responses: ['Always tired', 'More tired than normal', 'Normal', 'Fresh', 'Very fresh'],
  ),
  Question(
    long: 'How was your quality of sleep last night?',
    short: 'Sleep',
    responses: ['Insomnia', 'More tired than normal', 'Normal', 'Fresh', 'Very fresh'],
  ),
  Question(
    long: 'How is your general soreness of muscles?',
    short: 'Muscles',
    responses: ['Very sore', 'Increase in soreness/tightness', 'Normal', 'Feeling good', 'Feeling great'],
  ),
  Question(
    long: 'How stressed are you feeling in general?',
    short: 'Stress',
    responses: ['Highly stressed', 'Feeling stressed', 'Normal', 'Relaxed', 'Very relaxed'],
  ),
  Question(
    long: 'What is your overall mood level?',
    short: 'Mood',
    responses: ['Highly annoyed/irritable/down', 'Snappiness at team members', 'Less interested in others/activities than normal', 'A generally good mood', 'Very positive mood'],
  ),
];

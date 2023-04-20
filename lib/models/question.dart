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
    responses: [
      '1 - Always tired',
      '2 - More tired than normal',
      '3 - Normal',
      '4 - Fresh',
      '5 - Very fresh',
    ],
  ),
  Question(
    long: 'How was your quality of sleep last night?',
    short: 'Sleep',
    responses: [
      '1 - Insomnia',
      '2 - Resteless sleep',
      '3 - Difficulty falling asleep',
      '4 - Good',
      '5 - Very restful',
    ],
  ),
  Question(
    long: 'How is your general soreness of muscles?',
    short: 'Muscles',
    responses: [
      '1 - Very sore',
      '2 - Increased soreness',
      '3 - Normal',
      '4 - Feeling good',
      '5 - Feeling great',
    ],
  ),
  Question(
    long: 'How stressed are you feeling in general?',
    short: 'Stress',
    responses: [
      '1 - Highly stressed',
      '2 - Feeling stressed',
      '3 - Normal',
      '4 - Relaxed',
      '5 - Very relaxed',
    ],
  ),
  Question(
    long: 'What is your overall mood level?',
    short: 'Mood',
    responses: [
      '1 - Highly annoyed, irritable or down',
      '2 - Snappiness at teammates or family',
      '3 - Less interested  than normal',
      '4 - A generally good mood',
      '5 - Very positive mood',
    ],
  ),
];

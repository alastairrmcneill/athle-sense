import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/today/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/models/question.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/event_service.dart';
import 'package:wellness_tracker/services/response_service.dart';

class TodayQuestionnaireForm extends StatefulWidget {
  const TodayQuestionnaireForm({super.key});

  @override
  State<TodayQuestionnaireForm> createState() => _TodayQuestionnaireFormState();
}

class _TodayQuestionnaireFormState extends State<TodayQuestionnaireForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<int> answerValues = [0, 0, 0, 0, 0];
  int availabilityValue = 0;

  Future _saveResponse(BuildContext context) async {
    List<int> _ratings = answerValues;
    int _wellnessRating = 0;
    for (var value in answerValues) {
      _wellnessRating += value;
    }

    ResponseService.saveResponse(
      context,
      answerValues: answerValues,
      availabilityValue: availabilityValue,
      wellnessRating: _wellnessRating,
    );
  }

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    List<Event>? myEvents = eventNotifier.myEvents;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...myQuestions.asMap().entries.map((entry) {
              int index = entry.key;
              Question question = entry.value;
              return QuestionCard(
                questionText: question.long,
                groupValue: answerValues[index],
                responses: question.responses,
                onchanged: (value) => setState(() => answerValues[index] = value),
              );
            }).toList(),
            EventService.inActiveEvent(context)
                ? QuestionCard(
                    questionText: 'What is your availabiltiy for competing today?',
                    groupValue: availabilityValue,
                    responses: [
                      '1 - Long term injury',
                      '2 - Injured today, maybe ready tomorrow',
                      '3 - Unsure if able to play today',
                      '4 - Able to play but with niggle',
                      '5 - Completely ready',
                    ],
                    onchanged: (value) => setState(() => availabilityValue = value),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    // Save response
                    await _saveResponse(context);
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

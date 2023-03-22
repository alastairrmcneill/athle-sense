import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/models/question.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/response_service.dart';
import 'package:wellness_tracker/services/services.dart';

class TodayQuestionnaireForm extends StatefulWidget {
  const TodayQuestionnaireForm({super.key});

  @override
  State<TodayQuestionnaireForm> createState() => _TodayQuestionnaireFormState();
}

class _TodayQuestionnaireFormState extends State<TodayQuestionnaireForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool inEvent = true;

  List<int> answerValues = [0, 0, 0, 0, 0];
  int availabilityValue = 0;

  Widget _buildEventQuestion() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black38),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What is your availabiltiy for competing today?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('None'),
                    Radio<int>(value: 1, groupValue: availabilityValue, onChanged: (value) => setState(() => availabilityValue = 1)),
                  ],
                ),
                Column(
                  children: [
                    Text('Reduced'),
                    Radio<int>(value: 2, groupValue: availabilityValue, onChanged: (value) => setState(() => availabilityValue = 2)),
                  ],
                ),
                Column(
                  children: [
                    Text('Full'),
                    Radio<int>(value: 3, groupValue: availabilityValue, onChanged: (value) => setState(() => availabilityValue = 3)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _saveResponse(BuildContext context) async {
    List<int> _ratings = answerValues;
    int _wellnessRating = 0;
    for (var value in answerValues) {
      _wellnessRating += value;
    }

    bool result = await ResponseService.saveResponse(
      context,
      answerValues: answerValues,
      availabilityValue: availabilityValue,
      wellnessRating: _wellnessRating,
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...myQuestions.asMap().entries.map((entry) {
              int index = entry.key;
              Question question = entry.value;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormField(
                  builder: (field) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(question.long),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(question.responses.first),
                            Text(question.responses.last),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Radio<int>(value: 1, groupValue: answerValues[index], onChanged: (value) => setState(() => answerValues[index] = 1)),
                            Radio<int>(value: 2, groupValue: answerValues[index], onChanged: (value) => setState(() => answerValues[index] = 2)),
                            Radio<int>(value: 3, groupValue: answerValues[index], onChanged: (value) => setState(() => answerValues[index] = 3)),
                            Radio<int>(value: 4, groupValue: answerValues[index], onChanged: (value) => setState(() => answerValues[index] = 4)),
                            Radio<int>(value: 5, groupValue: answerValues[index], onChanged: (value) => setState(() => answerValues[index] = 5)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            inEvent ? _buildEventQuestion() : const SizedBox(),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                String _snackbarText = '';
                // Save response
                bool result = await _saveResponse(context);

                if (result) {
                  _snackbarText = 'Saved response';
                } else {
                  _snackbarText = 'Unsuccessful';
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _snackbarText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

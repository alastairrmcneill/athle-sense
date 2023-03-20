import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/question.dart';

class TodayQuestionnaireForm extends StatefulWidget {
  const TodayQuestionnaireForm({super.key});

  @override
  State<TodayQuestionnaireForm> createState() => _TodayQuestionnaireFormState();
}

class _TodayQuestionnaireFormState extends State<TodayQuestionnaireForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<int> selectedValues = [0, 0, 0, 0, 0];
  List<String?> selectedItems = [
    null,
    null,
    null,
    null,
    null,
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ...myQuestions.asMap().entries.map((entry) {
              //   int index = entry.key;
              //   Question question = entry.value;

              //   return Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(color: Colors.black38),
              //       ),
              //       padding: EdgeInsets.all(10),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(question.long),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(question.responses.first),
              //               Text(question.responses.last),
              //             ],
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Radio<int>(value: 1, groupValue: selectedValues[index], onChanged: (value) => setState(() => selectedValues[index] = 1)),
              //               Radio<int>(value: 2, groupValue: selectedValues[index], onChanged: (value) => setState(() => selectedValues[index] = 2)),
              //               Radio<int>(value: 3, groupValue: selectedValues[index], onChanged: (value) => setState(() => selectedValues[index] = 3)),
              //               Radio<int>(value: 4, groupValue: selectedValues[index], onChanged: (value) => setState(() => selectedValues[index] = 4)),
              //               Radio<int>(value: 5, groupValue: selectedValues[index], onChanged: (value) => setState(() => selectedValues[index] = 5)),
              //             ],
              //           ),
              //           const SizedBox(height: 5),
              //         ],
              //       ),
              //     ),
              //   );
              // }).toList(),

              ...myQuestions.asMap().entries.map((entry) {
                int index = entry.key;
                Question question = entry.value;

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
                        Text(question.long),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: selectedItems[index],
                          hint: Text('Please select'),
                          items: [
                            ...question.responses
                                .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.visible,
                                    )))
                                .toList(),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedItems[index] = value as String;
                            });
                          },
                          onSaved: (newValue) {},
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              }).toList(),

              ElevatedButton(
                onPressed: () {},
                child: Text('Save'),
              ),
            ],
          ),
        ));
  }
}

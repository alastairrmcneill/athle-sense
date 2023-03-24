// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wellness_tracker/support/theme.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final int groupValue;
  final Function(int) onchanged;
  const QuestionCard({
    Key? key,
    required this.questionText,
    required this.groupValue,
    required this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: FormField(validator: (value) {
        if (groupValue == 0) {
          return 'Required';
        }
      }, builder: (field) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.cardColor,
            border: Border.all(color: field.hasError ? Colors.red : Colors.transparent),
          ),
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionText,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Radio<int>(value: 1, groupValue: groupValue, onChanged: (value) => onchanged(1), activeColor: ratingColors[0]),
                  Radio<int>(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) => onchanged(2),
                    activeColor: ratingColors[1],
                  ),
                  Radio<int>(
                    value: 3,
                    groupValue: groupValue,
                    onChanged: (value) => onchanged(3),
                    activeColor: ratingColors[2],
                  ),
                  Radio<int>(
                    value: 4,
                    groupValue: groupValue,
                    onChanged: (value) => onchanged(4),
                    activeColor: ratingColors[3],
                  ),
                  Radio<int>(
                    value: 5,
                    groupValue: groupValue,
                    onChanged: (value) => onchanged(5),
                    activeColor: ratingColors[4],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

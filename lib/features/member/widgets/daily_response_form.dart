import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/models/question.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';

class DailyResponseForm extends StatefulWidget {
  const DailyResponseForm({Key? key}) : super(key: key);

  @override
  State<DailyResponseForm> createState() => _DailyResponseFormState();
}

class _DailyResponseFormState extends State<DailyResponseForm> {
  List<List<bool>> _selections = [
    for (var i = 0; i < Questions.long.length; i++) [false, false, false, false, false]
  ];
  List<bool> _availabilitySelections = [false, false, false];

  List<Widget> _buildQuestionList() {
    List<Widget> _questionsList = [];
    for (var i = 0; i < Questions.long.length; i++) {
      _questionsList.add(_buildQuestion(i));
    }
    return _questionsList;
  }

  Widget _buildQuestion(int index) {
    return Column(
      children: [
        Text(Questions.long[index]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('Bad'), Text('Good')],
        ),
        ToggleButtons(
          isSelected: _selections[index],
          onPressed: (indexPressed) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < _selections.length; buttonIndex++) {
                if (buttonIndex == indexPressed) {
                  _selections[index][buttonIndex] = !_selections[index][buttonIndex];
                } else {
                  _selections[index][buttonIndex] = false;
                }
              }
            });
          },
          children: _buildButtons(index),
          // selectedBorderColor: Colors.transparent,
          // borderColor: Colors.transparent,
          // fillColor: Colors.transparent,
        ),
      ],
    );
  }

  List<Widget> _buildButtons(int index) {
    return [
      _selections[index][0] ? Text('1') : Text('One'),
      _selections[index][1] ? Text('2') : Text('Two'),
      _selections[index][2] ? Text('3') : Text('Three'),
      _selections[index][3] ? Text('4') : Text('Four'),
      _selections[index][4] ? Text('5') : Text('Five'),
    ];
  }

  Widget _buildAvailabilityQuestion() {
    return ToggleButtons(
      isSelected: _availabilitySelections,
      onPressed: (indexPressed) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < _availabilitySelections.length; buttonIndex++) {
            if (buttonIndex == indexPressed) {
              _availabilitySelections[buttonIndex] = !_availabilitySelections[buttonIndex];
            } else {
              _availabilitySelections[buttonIndex] = false;
            }
          }
        });
      },
      children: _buildAvailabilityButtons(),
      // selectedBorderColor: Colors.transparent,
      // borderColor: Colors.transparent,
      // fillColor: Colors.transparent,
    );
  }

  List<Widget> _buildAvailabilityButtons() {
    return [
      !_availabilitySelections[0] ? Text('No pitch time') : Text('Sad'),
      !_availabilitySelections[1] ? Text('Shortened') : Text('OK'),
      !_availabilitySelections[2] ? Text('Good to go') : Text('Awesome'),
    ];
  }

  bool _enableButton() {
    for (var question in _selections) {
      if (!question.contains(true)) {
        return false;
      }
    }
    if (!_availabilitySelections.contains(true)) {
      return false;
    }

    return true;
  }

  Future<bool> _saveResponse(UserNotifier userNotifier, EventNotifier eventNotifier, ResponseNotifier responseNotifier) async {
    List<int> _ratings = [];
    int _wellnessRating = 0;
    for (var selection in _selections) {
      int score = selection.indexOf(true) + 1;
      _ratings.add(score);
      _wellnessRating += score;
    }

    Response response = Response(
      userUid: userNotifier.currentUser!.uid,
      eventUid: eventNotifier.currentEvent!.uid!,
      date: DateTime.now(),
      ratings: _ratings,
      wellnessRating: _wellnessRating,
      availability: _availabilitySelections.indexOf(true) + 1,
    );

    bool result = await ResponseDatabase.createResponse(responseNotifier, response);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return Column(
      children: [
        Text('Please rate the following between 1 (bad) and 5 (good).'),
        ..._buildQuestionList(),
        Text('How available are you for play today?'),
        _buildAvailabilityQuestion(),
        ElevatedButton(
          onPressed: !_enableButton()
              ? null
              : () async {
                  String _snackbarText = '';
                  bool result = await _saveResponse(userNotifier, eventNotifier, responseNotifier);

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
                  Navigator.of(context).pop();
                },
          child: Text('Save'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/models/question.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';
import 'package:reading_wucc/support/theme.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            myQuestions[index].long,
            style: Theme.of(context).textTheme.headline5,
          ),
          ToggleButtons(
            constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 40) / 5, maxWidth: (MediaQuery.of(context).size.width - 40) / 5, minHeight: 40),
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
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtons(int index) {
    List<Widget> _list = [];

    myQuestions[index].responses.forEach((response) {
      _list.add(
        Text(
          response,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
      );
    });

    return _list;
  }

  Widget _buildAvailabilityQuestion() {
    return ToggleButtons(
      constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 40) / 3, maxWidth: (MediaQuery.of(context).size.width - 40) / 3, minHeight: 40),
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
    );
  }

  List<Widget> _buildAvailabilityButtons() {
    return [
      !_availabilitySelections[0]
          ? Text(
              'No pitch time',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          : Text(
              'Sad',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
      !_availabilitySelections[1]
          ? Text(
              'Shortened',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          : Text(
              'OK',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
      !_availabilitySelections[2]
          ? Text(
              'Good to go',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )
          : Text(
              'Awesome',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
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
    ResponseDatabase.readMemberResponses(responseNotifier, eventNotifier.currentEvent!.uid!, userNotifier.currentUser!.uid);
    return result;
  }

  bool _buildForm(ResponseNotifier responseNotifier) {
    bool _alreadyResponded = false;

    if (responseNotifier.myResponses != null && responseNotifier.myResponses!.isNotEmpty) {
      if (responseNotifier.myResponses!.last.date.isAtSameMomentAs(DateUtils.dateOnly(DateTime.now()))) {
        _alreadyResponded = true;
      }
    }
    return _alreadyResponded;
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return _buildForm(responseNotifier)
        ? Center(
            child: Text(
              'Already Responded',
              style: Theme.of(context).textTheme.headline5,
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Please rate the following between 1 (bad) and 5 (good).',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  ..._buildQuestionList(),
                  Text('How available are you for play today?', style: Theme.of(context).textTheme.headline5),
                  _buildAvailabilityQuestion(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
                            },
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.headline5!.copyWith(color: MyColors.backgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

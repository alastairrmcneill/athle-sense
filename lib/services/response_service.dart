import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/response.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/response_database.dart';

class ResponseService {
  static Future saveResponse(BuildContext context, {required List<int> answerValues, required int availabilityValue, required int wellnessRating}) async {
    // Create response

    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    Response response = Response(
      userUid: userNotifier.currentUser!.uid,
      date: DateTime.now(),
      ratings: answerValues,
      wellnessRating: wellnessRating,
      availability: availabilityValue,
    );

    // Write to database
    bool success = await ResponseDatabase.createResponse(context, response: response);

    // Update notifiers
    await loadUserResponses(context);

    return success;
  }

  static Future loadUserResponses(BuildContext context) async {
    // Read from Database
    List<Response> responseList = await ResponseDatabase.readMyResponses(context);

    // Update notifier
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    responseNotifier.setMyResponses = responseList;
  }

  // static Appointment responseToAppointment(Response response) {
  //   return Appointment(
  //     startTime: response.date,
  //     endTime: response.date.add(Duration(minutes: 1)),
  //     subject: response.uid!,
  //   );
  // }
}

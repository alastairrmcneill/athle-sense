import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/response.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/auth_service.dart';
import 'package:wellness_tracker/services/response_database.dart';

class ResponseService {
  static Future saveResponse(BuildContext context, {required List<int> answerValues, required int availabilityValue, required int wellnessRating}) async {
    showCircularProgressOverlay(context);

    String? userUid = AuthService.currentUserId;
    if (userUid == null) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, "Error: Logout and log back in to reset");
      return; // Return if not
    }

    // Create response
    Response response = Response(
      userUid: userUid,
      date: DateTime.now(),
      ratings: answerValues,
      wellnessRating: wellnessRating,
      availability: availabilityValue,
    );

    // Write to database
    await ResponseDatabase.create(context, response: response);
    stopCircularProgressOverlay(context);

    // Load Responses
    await loadUserResponses(context);
  }

  static Future loadUserResponses(BuildContext context) async {
    // Read from Database

    List<Response> responseList = await ResponseDatabase.readMyResponses(context);

    // Update notifier
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    responseNotifier.setMyResponses = responseList;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wellness_tracker/models/models.dart';

class EventData {
  final List<double> baselineRatings;
  final List<double> averageRatingsToday;
  final double teamWellnessBaseline;
  final double teamWellnessToday;
  final double teamWellnessYesterday;
  final List<String> incompleteMemberIDs;
  final List<String> reducedAvailabilityMemberIDs;
  final List<Response> allResponses;
  final List<Response> todaysResponses;
  final List<Response> yesterdayResponses;
  final List<Map> differenceFromYesterday;
  final List<Map> differenceFromBaseline;

  EventData({
    required this.baselineRatings,
    required this.averageRatingsToday,
    required this.teamWellnessBaseline,
    required this.teamWellnessToday,
    required this.teamWellnessYesterday,
    required this.incompleteMemberIDs,
    required this.reducedAvailabilityMemberIDs,
    required this.allResponses,
    required this.todaysResponses,
    required this.yesterdayResponses,
    required this.differenceFromYesterday,
    required this.differenceFromBaseline,
  });
}

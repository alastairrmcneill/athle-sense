// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/support/theme.dart';

class AllResponsesTile extends StatefulWidget {
  final Member member;
  final Response? todaysResponse;
  final Response? yesterdaysResponse;
  final double baseline;
  const AllResponsesTile({
    Key? key,
    required this.member,
    required this.todaysResponse,
    required this.yesterdaysResponse,
    required this.baseline,
  }) : super(key: key);

  @override
  State<AllResponsesTile> createState() => _AllResponsesTileState();
}

class _AllResponsesTileState extends State<AllResponsesTile> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: () => setState(() => expanded = !expanded),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: MyColors.cardColor,
          ),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        widget.member.name,
                        style: Theme.of(context).textTheme.headline5,
                      )),
                  widget.todaysResponse != null
                      ? Text(
                          'Completed survey',
                          style: Theme.of(context).textTheme.headline6,
                        )
                      // ? Icon(
                      //     Icons.check_rounded,
                      //     color: MyColors.lightTextColor,
                      //   )
                      : const SizedBox(),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              expanded
                  ? Divider(
                      color: MyColors.lightTextColor!.withOpacity(0.5),
                    )
                  : const SizedBox(),
              expanded ? const SizedBox(height: 5) : const SizedBox(),
              expanded
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'To yesterday',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 3),
                            widget.yesterdaysResponse != null && widget.todaysResponse != null
                                ? Text(
                                    (widget.todaysResponse!.wellnessRating - widget.yesterdaysResponse!.wellnessRating).toStringAsFixed(1),
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.w200),
                                  )
                                : Text(
                                    '-',
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.w200),
                                  )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'To baseline',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 3),
                            widget.yesterdaysResponse != null && widget.todaysResponse != null
                                ? Text(
                                    (widget.todaysResponse!.wellnessRating - widget.baseline).toStringAsFixed(1),
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.w200),
                                  )
                                : Text(
                                    '-',
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.w200),
                                  )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Availability',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 3),
                            widget.todaysResponse != null
                                ? Text(
                                    widget.todaysResponse!.availability.toString(),
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.w200),
                                  )
                                : Text(
                                    '-',
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20, fontWeight: FontWeight.w200),
                                  )
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

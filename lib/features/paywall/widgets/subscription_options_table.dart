import 'package:flutter/material.dart';
import 'package:wellness_tracker/support/theme.dart';

class SubscriptionOptionsTable extends StatelessWidget {
  const SubscriptionOptionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(inside: BorderSide(color: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.5))),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            Text('', style: Theme.of(context).textTheme.headline5),
            Center(child: Text('Basic', style: Theme.of(context).textTheme.headline5)),
            Center(child: Text('Pro', style: Theme.of(context).textTheme.headline5)),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Daily wellness survey', style: Theme.of(context).textTheme.headline6),
            ),
            Center(child: Text('✅')),
            Center(child: Text('✅')),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Review historical wellness', style: Theme.of(context).textTheme.headline6),
            ),
            Center(child: Text('✅')),
            Center(child: Text('✅')),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Join groups', style: Theme.of(context).textTheme.headline6),
            ),
            Center(child: Text('✅')),
            Center(child: Text('✅')),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Create groups', style: Theme.of(context).textTheme.headline6),
            ),
            Center(child: Text('❌')),
            Center(child: Text('✅')),
          ],
        ),
      ],
    );
  }
}

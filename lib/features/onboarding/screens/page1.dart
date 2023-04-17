import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Expanded(
          //   flex: 1,
          //   child: Container(),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Image.asset(
              'assets/page_1.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          // const SizedBox(height: 80),
        ],
      ),
    );
  }
}

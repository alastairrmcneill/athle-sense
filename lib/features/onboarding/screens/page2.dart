import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
              'assets/page_2.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          // const SizedBox(height: 80),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TimeUpClass extends StatelessWidget {
  const TimeUpClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //get support of back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //elevation if not 0 then will create a shadow
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Time's up",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

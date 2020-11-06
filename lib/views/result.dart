import 'package:flutter/material.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class Result extends StatefulWidget {
  final int correct, incorrect, total;

  Result(
      {@required this.correct, @required this.incorrect, @required this.total});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 14.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: blueButton(
                  context: context,
                  label: "Go to Home",
                  buttonWidth: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

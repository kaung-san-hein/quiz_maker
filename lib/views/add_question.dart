import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion({this.quizId});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  DatabaseService _databaseService = DatabaseService();
  bool isLoading = false;

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };

      await _databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        brightness: Brightness.light,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Question" : null,
                      decoration: InputDecoration(hintText: "Question"),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option1" : null,
                      decoration:
                          InputDecoration(hintText: "Option1 (Correct Answer)"),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option2" : null,
                      decoration: InputDecoration(hintText: "Option2"),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option3" : null,
                      decoration: InputDecoration(hintText: "Option3"),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option4" : null,
                      decoration: InputDecoration(hintText: "Option4"),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: blueButton(
                            context: context,
                            label: "Submit",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 36,
                          ),
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            uploadQuestionData();
                          },
                          child: blueButton(
                            context: context,
                            label: "Add Question",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 36,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/helpers/functions.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/views/create_quiz.dart';
import 'package:quiz_maker/views/play_quiz.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseService _databaseService = DatabaseService();

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _databaseService.getQuizData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final List<DocumentSnapshot> quizs = snapshot.data.docs;
          return ListView.builder(
            itemCount: quizs.length,
            itemBuilder: (context, index) {
              return QuizTile(
                imgUrl: quizs[index].get("quizImageUrl"),
                title: quizs[index].get("quizTitle"),
                desc: quizs[index].get("quizDesc"),
                quizId: quizs[index].get("quizId"),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        actions: [
          IconButton(
            icon: Icon(
              Icons.all_out,
              color: Colors.black87,
            ),
            onPressed: () {
              HelperFunctions.logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateQuiz()),
          );
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;

  QuizTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizId)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.0),
        height: 150.0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

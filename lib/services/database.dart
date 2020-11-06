import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("quizs");

  Future<void> addQuizData(Map quizData, String quizId) async {
    await _collectionReference.doc(quizId).set(quizData).catchError((e) {
      print(e.toString());
    });
  }

  Stream<QuerySnapshot> getQuizData() {
    return _collectionReference.snapshots();
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await _collectionReference
        .doc(quizId)
        .collection("ques_and_ans")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<QuerySnapshot> getQuestionData(String quizId) async {
    return await _collectionReference
        .doc(quizId)
        .collection("ques_and_ans")
        .get();
  }
}

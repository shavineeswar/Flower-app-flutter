import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:crud_app/screens/admin/q&a_forum/add_question_screen.dart';
import 'package:crud_app/screens/admin/q&a_forum/admin_question_list.dart';
import 'package:crud_app/screens/admin/quiz/list_quiz.dart';
import 'package:flutter/material.dart';

class QAforumHome extends StatefulWidget {
  const QAforumHome({Key? key}) : super(key: key);

  @override
  State<QAforumHome> createState() => _QAforumHomeState();
}

class _QAforumHomeState extends State<QAforumHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 67, 88),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const AppBarTitle(
          sectionName: "Q & A",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddQuestionScreen()));
        },
        backgroundColor: const Color.fromARGB(255, 255, 177, 10),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
              child: AdminQuestionList(),
              ),
              ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/screens/admin/q&a_forum/admin_answer_screen.dart';
import 'package:crud_app/validators/database.dart';
import 'package:flutter/material.dart';

class AdminQuestionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readForum(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 73, 209, 180)),
            ),
          );
        }

        return SizedBox(
          height: 600,
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                var noteInfo =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
                String docId = snapshot.data!.docs[index].id;
                String description = noteInfo["description"];
                String imageURL = noteInfo["imageURL"];
                String answer = noteInfo['answer'];
                return Ink(
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 30.0),
                    elevation: 15,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:16.0, right: 16.0,),
                          child: Text(
                            description,
                            maxLines: 8,
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 18),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AnswerScreen(
                                    currrentDescription: description,
                                    currrentImageURL: imageURL,
                                    documentId: docId,
                                    currentAnswer: answer,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Answer'), // <-- Text
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon( // <-- Icon
                                    Icons.edit,
                                    size: 16.0,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Delete'), // <-- Text
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon( // <-- Icon
                                    Icons.delete,
                                    size: 16.0,
                                  ),
                                ],
                              ),

                              onPressed: ()=>
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          title: const Text('Please Confirm'),
                                          content:  const Text("Are you sure to edit the question?"),
                                          actions: [
                                            // The "Yes" button
                                            TextButton(
                                                onPressed: () async{
                                                  // Remove the box
                                                  // setState(() {
                                                  //   _isShown = false;
                                                  // });
                                                  await Database.deleteForum(
                                                    docId: docId,
                                                  );
                                                  child:
                                                  const CircularProgressIndicator(
                                                    valueColor:
                                                    AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                                                    strokeWidth: 3,
                                                  );
                                                  // Close the dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Yes')),
                                            TextButton(
                                                onPressed: () {
                                                  // Close the dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'))
                                          ],
                                        );
                                      }),
                            )
                          ],
                        ),
                        const Text(
                          'Answer',
                          style: TextStyle(
                              color: Color.fromARGB(255, 29, 177, 152),
                              fontSize: 18.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:16.0, right: 16.0,),
                          child: Text(
                            answer,
                            maxLines: 4,
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 18),
                          ),
                        ),
                        //Image.network(snapshot.data!.docs[index]['imageURL'] ?? 'https://png.pngtree.com/png-vector/20190723/ourlarge/pngtree-flower-web-icon--flat-line-filled-gray-icon-vector-png-image_1569041.jpg'),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
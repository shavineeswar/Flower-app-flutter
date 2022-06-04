import 'package:flutter/material.dart';
import 'dart:io';
import 'package:crud_app/validators/validator.dart';
import 'package:crud_app/validators/database.dart';
import 'package:crud_app/custom_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditQuizForm extends StatefulWidget {
  final String documentId;
  final String currentQuestion;
  final String currentAnswer;
  final String currentWrongAnswer;
  final String currentDescription;
  final FocusNode answerFocusNode;
  final FocusNode questionFocusNode;
  final FocusNode wrongAnswerFocusNode;
  final FocusNode descriptionFocusNode;
  final String currentImageURL;

  const EditQuizForm({
    required this.documentId,
    required this.currentAnswer,
    required this.currentDescription,
    required this.answerFocusNode,
    required this.currentWrongAnswer,
    required this.currentQuestion,
    required this.descriptionFocusNode,
    required this.wrongAnswerFocusNode,
    required this.questionFocusNode,
    required this.currentImageURL,
  });

  @override
  State<EditQuizForm> createState() => _EditQuizFormState();
}

class _EditQuizFormState extends State<EditQuizForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _wrongAnswerController = TextEditingController();
  final TextEditingController _descriptionContoller = TextEditingController();

  String updateAnswer = "";
  String updateQuestion = "";
  String updateWrongAnswer = "";
  String updateDescription = "";
  static String imageURL = "";
static var pickedImage;
  File? _image;

  //upload image
  final picker = ImagePicker();
  Reference ref = FirebaseStorage.instance
      .ref()
      .child("category" + DateTime.now().toString());

  Future getImage(BuildContext context) async {
    pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Image Uploaded")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No Image Uploaded")));
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _addItemFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6), // Border width
                      // decoration: BoxDecoration(
                      //     color: Color.fromARGB(255, 29, 177, 152),
                      //     borderRadius: BorderRadius.circular(20)),
                      child: Column(
                          //crossAxisAlignment: center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(88), // Image radius
                                  child: _image == null
                                      ? Image.network(widget.currentImageURL,
                                          fit: BoxFit.cover)
                                      : Image.file(_image!)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 216, 216, 216),
                                radius: 20,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt_rounded,
                                      size: 25,
                                      color: Color.fromARGB(255, 99, 99, 99)),
                                  onPressed: () {
                                    getImage(context);
                                  },
                                ),
                              ),
                            ),
                          ]),
                    ),
                    const Text(
                      'Question',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                      initialValue: widget.currentQuestion,
                        isLabelEnabled: false,
                        controller: _questionController,
                        focusNode: widget.questionFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Question",
                        hint: "Enter the question",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateQuestion = value;
                        }),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      'Answer',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                      initialValue: widget.currentAnswer,
                        isLabelEnabled: false,
                        controller: _answerController,
                        focusNode: widget.answerFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Answer",
                        hint: "Enter the Answer",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateAnswer = value;
                        }),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      'Wrong Answer',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                      initialValue: widget.currentWrongAnswer,
                        isLabelEnabled: false,
                        controller: _wrongAnswerController,
                        focusNode: widget.wrongAnswerFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "WrongAnswer",
                        hint: "Enter the Answer",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateWrongAnswer = value;
                        }),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Description',
                      style: TextStyle(
                          color: Color.fromARGB(255, 29, 177, 152),
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    CustomFormField(
                        initialValue: widget.currentDescription,
                        maxLines: 10,
                        isLabelEnabled: false,
                        controller: _descriptionContoller,
                        focusNode: widget.descriptionFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "Description",
                        hint: "Write your Description",
                        validator: (value) {
                          Validator.validateField(
                            value: value,
                          );
                          updateDescription = value;
                        }),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 29, 177, 152)),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color.fromARGB(255, 14, 204, 172)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        onPressed: () async {
                          widget.answerFocusNode.unfocus();
                          widget.descriptionFocusNode.unfocus();
                          widget.questionFocusNode.unfocus();
                          widget.wrongAnswerFocusNode.unfocus();

                          if (_addItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });
                            if (_image == null) {
                              imageURL = widget.currentImageURL;
                            }
                            else{
                              await ref.putFile(File(pickedImage!.path));
                              imageURL = await ref.getDownloadURL();
                            }
                            await Database.updateQuestion(
                                docId: widget.documentId,
                                question : updateQuestion,
                                answer: updateAnswer,
                                wrongAnswer: updateWrongAnswer,
                                description: updateDescription,
                                imageURL:imageURL,);
    
                            setState(() {
                              _isProcessing = false;
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'Update Data',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}

import 'package:crud_app/screens/admin/category/add_item_form.dart';
import 'package:crud_app/screens/admin/category/app_bar.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _originFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _originFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          toolbarHeight: 80,
          backgroundColor: Color.fromARGB(255, 29, 177, 152),
          centerTitle: true,
          title: const AppBarTitle(
            sectionName: "Add Category",
            
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20),
          child: AddItemFormm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              originFocusNode:_originFocusNode
              ),
        )),
      ),
    );
  }
}

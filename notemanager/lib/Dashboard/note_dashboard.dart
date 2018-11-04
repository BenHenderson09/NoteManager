import 'package:flutter/material.dart';

import './note_controller.dart';

class NoteDashboard extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
        appBar:AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Note Manager"),
              Container(
                margin:EdgeInsets.all(10.0),
                child:FloatingActionButton(
                  backgroundColor: Colors.lightBlueAccent,
                  child:Text("+"),
                  onPressed:(){
                    Navigator.of(context).pushNamed('/addnote');
                  }
              ),
              ),
            ] 
          ), 
        ),

        body: NoteController(),
    );
  }
}
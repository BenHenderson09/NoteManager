import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Edit/edit_note.dart';
import '../NoteFunctions/note_functions.dart';

class NoteController extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return NoteControllerState();
  }
}

class NoteControllerState extends State<NoteController>{
  List<Map<String,String>> _notes = new List<Map<String,String>>();

  @override
  void initState(){
    _loadNotes();
    super.initState();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _notes = NoteFunctions.parseNotes(prefs.getString('notes')); 
    });
  }

  Future<void> _deleteNote(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState((){
      _notes.removeAt(index);
      prefs.setString('notes', json.encode(_notes));
    });
  }

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (BuildContext ctx, int index){
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => EditNote(index)
            ));
          },
          child: Card(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget>[

                      Flexible(
                        child:Text( 
                          _notes[index]['title'],
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      
                      Container(
                        margin:EdgeInsets.all(1.0),
                        width: 30.0,
                        child: FloatingActionButton(
                          heroTag: "DeleteNote"+index.toString(),
                          backgroundColor: Colors.red,
                          child:Text(
                            "-",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed:(){
                            _deleteNote(index).then((result){
                              _generateSnackBar("Note Deleted Successfully");
                            });
                          }
                        )
                      ),
                    ]
                  ),
                ),
              ],
            ),
        )
        );
      }
    );
  }

  void _generateSnackBar(String value) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
}
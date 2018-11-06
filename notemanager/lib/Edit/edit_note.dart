import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../NoteFunctions/note_functions.dart';

class EditNote extends StatefulWidget{
  final int _noteIndex;

  EditNote(this._noteIndex);

  @override
  State<StatefulWidget> createState(){
    return EditNoteState();
  }
}

class EditNoteState extends State<EditNote>{
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _bodyController = new TextEditingController();
  
  Map<String,String> _note = new Map<String,String>();
  int _noteIndex;

  @override
  void initState(){
    _noteIndex = widget._noteIndex;
    _loadNote();
    super.initState();
  }

  @override
  void dispose(){
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _loadNote() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String,String>> notes = NoteFunctions.parseNotes(prefs.getString('notes'));

    setState(() {
      if (notes.length >= _noteIndex){
        _note = notes[_noteIndex];
        _titleController.text = _note['title'];
        _bodyController.text = _note['body'];
      }      
    });
  }

  Future<void> _editNote() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String,String> note = {'title':_titleController.text,'body':_bodyController.text};

    List<Map<String,String>> notes = NoteFunctions.parseNotes(prefs.getString('notes'));

    if (notes.length >= _noteIndex){
      notes[_noteIndex] = note;
    }

    prefs.setString('notes', json.encode(notes));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),

      body:ListView(
        children: <Widget>[
          Container(
            margin:EdgeInsets.all(10.0),
            child: Column(
              children:<Widget>[

                Container(
                  margin:EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Title'
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black
                    ),
                    controller: _titleController,
                  ),
                ),
                 
                Container(
                  margin:EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child:TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      filled: true,
                      hintText: 'Body'
                    ),
                    controller: _bodyController,
                  ),
                ),

                Container(
                  width:double.infinity,
                  child:RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text("Edit Note"),
                    onPressed: (){
                      _editNote().then((result){                    
                        Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false);
                      });
                    },
                  ),
                ),

              ]
            )
          ),
        ],
      )
    );
  }
}
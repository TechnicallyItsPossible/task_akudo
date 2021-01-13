import 'package:flutter/material.dart';
import 'todo.dart';
import 'globals.dart';
class doneList extends StatefulWidget {
  @override
  _doneListState createState() => _doneListState();
}

class _doneListState extends State<doneList> {

  void _removedoneItem(int index) {
    setState(() {
      totalpoints=totalpoints-int.parse(pointsdone[index]);
    });
    setState(() => taskstodo.add(tasksdone[index]));
    setState(() => pointstodo.add(pointsdone[index]));
    setState(() => tasksdone.removeAt(index));
    setState(() => pointsdone.removeAt(index));
  }

  void _promptRemovedoneItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${tasksdone[index]}" as redo?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS REDO'),
                    onPressed: () {

                      _removedoneItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  Widget _builddoneList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < tasksdone.length) {
          return _builddoneItem(tasksdone[index],pointsdone[index], index);
        }
      },
    );
  }



  Widget _builddoneItem(String doneText, String donePoint, int index) {
    return new ListTile(
        title: Column(
          children: [
            Text(
              doneText,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              donePoint,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            FlatButton(onPressed: (){_promptRemovedoneItem(index);}, child: Text("Redo"), textColor: Colors.white ,color: Colors.red[900])
          ],
        ),

        tileColor: Colors.grey[900],
        contentPadding: EdgeInsets.all(20),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _builddoneList(),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pop(context);}, backgroundColor: Colors.red[900], child: Icon(Icons.arrow_back_rounded),)
    );
  }
}

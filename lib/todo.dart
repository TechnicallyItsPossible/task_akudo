import 'dart:ui';
import 'package:flutter/services.dart';

import 'globals.dart';
import 'package:flutter/material.dart';
import 'package:task/completedlist.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {



  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
      setState(() => taskstodo.add(task));
    }
  }
  void _addTodoItemPoints(String points) {
    // Only add the task if the user actually entered something
    if(points.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
      setState(() => pointstodo.add(points));
    }
  }

  void _removeTodoItem(int index) {
    totalpoints=totalpoints+ int.parse(pointstodo[index]);
    setState(() => tasksdone.add(taskstodo[index]));
    setState(() => pointsdone.add(pointstodo[index]));

    setState(() => taskstodo.removeAt(index));
    setState(() => pointstodo.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${taskstodo[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < taskstodo.length) {
          return _buildTodoItem(taskstodo[index],pointstodo[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, String todoPoint, int index) {
    return new ListTile(
        title: Column(
          children: [
            Text(
              todoText,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              todoPoint,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        subtitle: Column(
          children: [

            FlatButton(onPressed: (){_promptRemoveTodoItem(index);}, child: Text("Done"), textColor: Colors.white ,color: Colors.red[900])
          ],
        ),
        
        tileColor: Colors.grey[900],
        contentPadding: EdgeInsets.all(20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Earn Your Keep'),
        backgroundColor: Colors.red[800],
      ),
      backgroundColor: Colors.black,
      body:_buildTodoList(),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.red[900],
                heroTag: 'add',
                onPressed: () {_pushAddTodoScreen();},
                child: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
            Positioned(
              bottom: 80.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.red[900],
                heroTag: 'done',
                onPressed: () {
                  _pushDoneList();},
                child: Icon(Icons.list),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),

            Positioned(
              bottom: 150.0,
              right: 10.0,
              child: FloatingActionButton(
                backgroundColor: Colors.red[900],
                heroTag: 'Refresh',
                onPressed: () {
                  setState(() {

                  });
                },
                child: Icon(Icons.refresh),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
            ),
          ],
        ),
    );
  }

  void _pushAddTodoScreen() {
    var val1,val2;
    // Push this page onto the stack
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a task'),
                    backgroundColor: Colors.red[900],
                  ),
                  backgroundColor: Colors.black,
                  body: Column(
                    children: [
                      new TextField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        autofocus: true,
                        onSubmitted: (val) {
                          val1=val;// Close the add todo screen
                        },
                        decoration: new InputDecoration(
                            hintText: 'Enter something to do...',
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                            contentPadding: const EdgeInsets.all(16.0)
                        ),
                      ),
                      new TextField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        autofocus: true,
                        onSubmitted: (val) {
                          val2=val;// Close the add todo screen
                        },
                        decoration: new InputDecoration(
                            hintText: 'Enter Award points',
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                            contentPadding: const EdgeInsets.all(16.0)
                        ),
                      ),

                  ElevatedButton(child: Text('Add Task'),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) { return Colors.red[900]; // Use the component's default.
                      },
                    ),
                  ),
                    onPressed: () {
                    _addTodoItem(val1);
                   _addTodoItemPoints(val2);
                    Navigator.pop(context);
                  },
              )
                    ],
                  )
              );
            }
        )
    );
  }
  void _pushDoneList() {
    // Push this page onto the stack
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                appBar: new AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text('Completed Tasks'),
                      Text("Total points "+totalpoints.toString(),textAlign :TextAlign.right,style: TextStyle(fontSize: 10),),
                    ],
                  ),
                  backgroundColor: Colors.red[800],
                ),
                body: doneList(),
              );
            }
        )
    );
  }
}

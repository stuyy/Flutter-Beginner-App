import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'To Do App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<ListItem> items = new List<ListItem>();
  String inputValue = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addHeading() {
    showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: new Text("This is an Alert"),
          content: TextField(
            onChanged: (String value) async {
              setState(() {
                inputValue = value;
              });
            },
          ),
          actions: <Widget>[
            new FlatButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: new Text("Close")),
            new FlatButton(onPressed: () {
              print("Hello World");
              setState(() {
                items.add(HeadingItem(inputValue));
              });
              Navigator.of(context).pop();
            }, child: new Text("Submit"))
          ],
        );
      },
    );
  }

  void deleteTask(ListItem item) {
    print("Deleting.");
    setState(() {
      items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            print("Hi");
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: item.buildTitle(context)
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('Delete Task'),
                        onPressed: () {
                          deleteTask(item);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHeading,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);

  Widget buildCard(BuildContext context);

  String get itemHeading;

}

class HeadingItem implements ListItem {
  String heading;

  HeadingItem(String heading) {
    this.heading = heading;
  }
  get itemHeading {
    return heading;
  }
  Widget buildTitle(BuildContext context) {
    return Text(
      this.heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;

  Widget buildCard(BuildContext context) => null;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  String sender;
  String body;

  MessageItem(String sender, String body) {
    this.sender = sender;
    this.body = body;
  }
  get itemHeading {
    return sender;
  }
  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);

  Widget buildCard(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_alarm),
            title: new Text(this.sender)
          ),
        ],
      ),
    );
  }
}
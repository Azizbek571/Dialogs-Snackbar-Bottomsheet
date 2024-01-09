import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final snackBar = SnackBar(
    content: Text('Succesfully saved!'),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
    action: SnackBarAction(label: 'Undo', onPressed: () {}),
  );

  String delete = 'No choice made';
  String location = 'None selected yet';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Save'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.red)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                delete = 'You selected No';
                              });
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                delete = 'You selected Yes';
                              });
                              Navigator.pop(context);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                        title: Text('Delete entry 12345?'),
                        content: Text('Are you sure?'),
                      );
                    });
              },
              child: Text('Delete'),
            ),
            Text('$delete'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final String loc = await showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Choose your location'),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'South Africa');
                            },
                            child: Text('South Africa'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'America');
                            },
                            child: Text('America'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'America');
                            },
                            child: Text('Brazil'),
                          ),
                        ],
                      );
                    });
                    setState(() {
                      location = loc;
                    });
              },
              child: Text('Choose location'),
            ),
            Text('$location'),
            ElevatedButton(
              onPressed: () {
                scaffoldKey.currentState?.showBottomSheet((context) {
                  return Container(
                    child: Center(child: Column(
                      children: [
                        Text('Are you sure you wanr to delete?')
                      ],
                    )
                    ),
                    
                    height: 110,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                  );
                });
              },
              child: Text('Bottom sheet'),
            ),
          ],
        ),
      ),
    );
  }
}

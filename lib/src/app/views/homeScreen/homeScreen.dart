import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/src/app/models/todoModel.dart';
import 'package:todoapp/src/app/services/todoHelper.dart';
import 'package:todoapp/src/app/views/calenderScreen/calenderScreen.dart';
import 'package:todoapp/src/app/views/homeScreen/todoScreen.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({
    super.key,
    required this.userId,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  TextEditingController _titleController = TextEditingController();
  final TodoDatabaseHelper _todoDatabaseHelper = TodoDatabaseHelper();
  TextEditingController _descriptionController = TextEditingController();
  int _currentIndex = 0;

  List<Widget> _screens = [];
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _screens = [
      TodoScreen(
        userId: widget.userId,
      ),
      CalenderScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(key: _overlayKey, initialEntries: [
      OverlayEntry(
        builder: (context) => Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: Stack(
            children: [
              BottomNavigationBar(
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                    if (index == 1) {
                      // Handle the middle item tap, show the dialog here

                      if (overlayEntry == null) {
                        overlayEntry = OverlayEntry(
                          builder: (context) => Builder(builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                            );
                          }),
                        );
                        Overlay.of(context)?.insert(overlayEntry!);
                      }
                    } else {
                      // Close the dialog if it's open when tapping other items
                      overlayEntry?.remove();
                      overlayEntry = null;
                    }
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/home-2.png',
                        width: 24, height: 24),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              title: Text(
                                'Add new item...😊',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              content: Container(
                                height: 270,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 220.0),
                                      child: Text(
                                        'Title',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText:
                                            'Make milk', // Set your hint text here
                                        hintStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(83, 83, 83, 1)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        filled: true,
                                        fillColor: Colors.black,
                                      ),
                                      controller: _titleController,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 190.0),
                                      child: Text(
                                        'Description',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText:
                                            'Finish the milk today...', // Set your hint text here
                                        hintStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(83, 83, 83, 1)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        filled: true,
                                        fillColor: Colors.black,
                                      ),
                                      controller: _descriptionController,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Todo todo = Todo(
                                      id: widget.userId,
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      isCompleted: false,
                                    );

                                    _todoDatabaseHelper.addTodo(
                                        todo, widget.userId);
                                    _titleController.clear();
                                    _descriptionController.clear();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Add Todo'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 4),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('assets/images/home-2.png',
                              width: 48, height: 48),
                          padding: EdgeInsets.all(10),
                        ),
                      ]),
                    ),
                    label: 'Add item',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/images/calendar.png',
                        width: 24, height: 24),
                    label: 'Calender',
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

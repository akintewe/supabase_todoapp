import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late List<Appointment> _events;

  @override
  void initState() {
    super.initState();
    _events = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Event Schedule',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: CustomCalendarDataSource(_events),
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          monthCellStyle: MonthCellStyle(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        headerStyle:
            CalendarHeaderStyle(textStyle: TextStyle(color: Colors.white)),
        weekNumberStyle: WeekNumberStyle(backgroundColor: Colors.white),
        blackoutDatesTextStyle: TextStyle(color: Colors.white),
        viewHeaderStyle: ViewHeaderStyle(
          backgroundColor: Colors.black,
          dayTextStyle: TextStyle(color: Colors.white),
          dateTextStyle: TextStyle(color: Colors.white),
        ),
        appointmentTextStyle: TextStyle(color: Colors.white),
        todayTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEventDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEventDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Event Name'),
                onChanged: (value) {
                  // Handle event name input
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Generate a random color for the event
                  Color randomColor = Colors.primaries[
                      DateTime.now().second % Colors.primaries.length];
                  _events.add(Appointment(
                    startTime: DateTime.now(),
                    endTime: DateTime.now().add(Duration(hours: 1)),
                    subject: 'Event Name',
                    color: randomColor,
                  ));
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text('Add Event'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomCalendarDataSource extends CalendarDataSource {
  final List<Appointment> appointments;

  CustomCalendarDataSource(this.appointments);
}

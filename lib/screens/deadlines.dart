import 'package:deadlines/screens/edit_deadline.dart';
import 'package:flutter/material.dart';
import 'add_deadline.dart';
import '../models/deadline.dart';
import 'package:timeago/timeago.dart' as timeago;

class DeadlinesScreen extends StatefulWidget {
  const DeadlinesScreen({super.key});

  @override
  State<DeadlinesScreen> createState() => _DeadlinesScreenState();
}

class _DeadlinesScreenState extends State<DeadlinesScreen> {
  List<Deadline> deadlines = [
    Deadline(title: 'Module Achat', assignedTo: 'Younes and Salma', date: DateTime.now().add(Duration(days: 5))),
    Deadline(title: 'Module Stock', assignedTo: 'Oualid and Hmanna', date: DateTime.now().add(Duration(days: 7))),
    Deadline(title: 'SMQ', assignedTo: 'Hamza', date: DateTime.now().add(Duration(days: 10))),
    Deadline(title: 'Suivi Mobile', assignedTo: 'Escanor', date: DateTime.now().add(Duration(days: 10))),
  ];

  void _addDeadline(String title, String assignedTo, DateTime date) {
    setState(() {
      deadlines.add(Deadline(title: title, assignedTo: assignedTo, date: date));
    });
  }

  void _editDeadline(int index, String title, String assignedTo, DateTime date) {
    setState(() {
      deadlines[index] = Deadline(title: title, assignedTo: assignedTo, date: date);
    });
  }

  void _deleteDeadline(int index) {
    setState(() {
      deadlines.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deadlines'),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: deadlines.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(deadlines[index]),
            background: Container(
              color: Colors.lightGreen,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.check, color: Colors.white),
            ),
            onDismissed: (direction) {
              _deleteDeadline(index);
            },
            child: ListTile(
              title: Text(deadlines[index].title),
              subtitle: Text(
                  deadlines[index].assignedTo,
                style: const TextStyle(fontSize: 13),
              ),
              // subtitle: Text(deadlines[index].date.toLocal().toString().split(' ')[0]),
              trailing: Text(timeago.format((deadlines[index].date), allowFromNow: true)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditDeadlineScreen(
                    deadline: deadlines[index],
                    onEditDeadline: (title, assignedTo, date) => _editDeadline(index, title, assignedTo, date),
                  ),
                ));
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddDeadlineScreen(onAddDeadline: _addDeadline),
          ));
        },
        tooltip: 'Add Deadline',
        child: const Icon(Icons.add),
      ),
    );
  }
}

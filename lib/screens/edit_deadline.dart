import 'package:flutter/material.dart';

import '../models/deadline.dart';

class EditDeadlineScreen extends StatefulWidget {
  final Deadline deadline;
  final void Function(String, String, DateTime) onEditDeadline;

  const EditDeadlineScreen({super.key, required this.deadline, required this.onEditDeadline});

  @override
  State<EditDeadlineScreen> createState() => _EditDeadlineScreenState();
}

class _EditDeadlineScreenState extends State<EditDeadlineScreen> {
  final _titleController = TextEditingController();
  final _assignedTpController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.deadline.title;
    _assignedTpController.text = widget.deadline.assignedTo;
    _selectedDate = widget.deadline.date;
  }

  void _submitData() {
    if (_titleController.text.isEmpty || _assignedTpController.text.isEmpty || _selectedDate == null) {
      return;
    }

    widget.onEditDeadline(
      _titleController.text,
      _assignedTpController.text,
      _selectedDate!,
    );

    Navigator.of(context).pop();
  }

  void _pickDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Deadline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _assignedTpController,
              decoration: const InputDecoration(labelText: 'Assinged to'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}

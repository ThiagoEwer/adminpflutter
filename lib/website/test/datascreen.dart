// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final _databaseReference = FirebaseDatabase.instance.reference();

  late String _nodeName;
  late String _nodeValue;

  void _createNewNode() {
    if (_nodeName.isNotEmpty && _nodeValue.isNotEmpty) {
      _databaseReference.child(_nodeName).set(_nodeValue);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Node created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Node Name',
              ),
              onChanged: (value) {
                setState(() {
                  _nodeName = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Node Value',
              ),
              onChanged: (value) {
                setState(() {
                  _nodeValue = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createNewNode,
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
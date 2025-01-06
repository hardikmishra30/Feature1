import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataTableExample(),
  ));
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final List<Map<String, dynamic>> _data = [
    {"Name": "Karan", "Age": 19, "City": "New Delhi"},
    {"Name": "Arjun", "Age": 20, "City": "Mumbai"},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _addRow() {
    if (_nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        _cityController.text.isNotEmpty) {
      setState(() {
        _data.add({
          "Name": _nameController.text,
          "Age": int.tryParse(_ageController.text) ?? 0,
          "City": _cityController.text,
        });
      });
      _nameController.clear();
      _ageController.clear();
      _cityController.clear();
    }
  }

  void _deleteRow(int index) {
    setState(() {
      _data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topic: DataTable with Add/Delete Rows'),
      ),
      /*Here this code is for row adjustments of name, age and city. */
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('City')),
                    DataColumn(label: Text('Actions'),)
                    
                  ],
                  rows: _data
                      .asMap()
                      .entries
                      .map(
                        (entry) => DataRow(cells: [
                          DataCell(
                            TextFormField(
                              initialValue: entry.value['Name'],
                              onChanged: (newValue) {
                                setState(() {
                                  entry.value['Name'] = newValue;
                                });
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: entry.value['Age'].toString(),
                              keyboardType: TextInputType.number,
                              onChanged: (newValue) {
                                setState(() {
                                  entry.value['Age'] =
                                      int.tryParse(newValue) ?? 0;
                                });
                              },
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: entry.value['City'],
                              onChanged: (newValue) {
                                setState(() {
                                  entry.value['City'] = newValue;
                                });
                              },
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteRow(entry.key),
                            ),
                          ),
                        ]),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    
                    decoration: InputDecoration(
                      
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  
                  onPressed: _addRow,
                  child: Text('Add Row'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

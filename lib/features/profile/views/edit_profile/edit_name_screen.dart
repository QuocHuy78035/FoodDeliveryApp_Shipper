import 'package:flutter/material.dart';

class EditNameScreen extends StatefulWidget {
  final String name;

  const EditNameScreen({super.key, required this.name});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  String nameChange = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameChange = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.1),
      appBar: AppBar(
        title: const Text("Edit Name"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: (){
                nameChange != widget.name ? Navigator.pop(context, nameChange) : null;
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: nameChange == widget.name ? Colors.grey : Colors.red,
                  fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                nameChange = value;
              });
            },
            initialValue: widget.name,
            autofocus: true,
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder()),
          ),
        ]),
      ),
    );
  }
}

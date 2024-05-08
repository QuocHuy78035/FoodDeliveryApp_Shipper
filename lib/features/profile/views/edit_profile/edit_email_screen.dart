import 'package:flutter/material.dart';

class EditEmailScreen extends StatefulWidget {
  final String email;

  const EditEmailScreen({super.key, required this.email});

  @override
  State<EditEmailScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditEmailScreen> {
  //String nameChange = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //nameChange = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.1),
      appBar: AppBar(
        title: const Text("Edit Address"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: (){
                //nameChange != widget.name ? Navigator.pop(context, nameChange) : null;
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.grey,
                    // color: nameChange == widget.name ? Colors.grey : Colors.red,
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
                //nameChange = value;
              });
            },
            readOnly: true,
            initialValue: widget.email,
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

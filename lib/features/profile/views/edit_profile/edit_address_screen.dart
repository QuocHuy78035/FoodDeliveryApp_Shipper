import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  final String address;

  const EditAddressScreen({super.key, required this.address});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
            initialValue: widget.address,
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

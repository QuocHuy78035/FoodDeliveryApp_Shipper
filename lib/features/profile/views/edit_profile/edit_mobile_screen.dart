import 'package:flutter/material.dart';

class EditMobileScreen extends StatefulWidget {
  final String mobile;

  const EditMobileScreen({super.key, required this.mobile});

  @override
  State<EditMobileScreen> createState() => _EditMobileScreenState();
}

class _EditMobileScreenState extends State<EditMobileScreen> {
  String mobileChange = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileChange = widget.mobile;
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
              onTap: () {
                mobileChange != widget.mobile
                    ? Navigator.pop(context, mobileChange)
                    : null;
              },
              child: Text(
                "Save",
                style: TextStyle(
                    color: mobileChange == widget.mobile
                        ? Colors.grey
                        : Colors.red,
                    fontSize: 16),
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
                mobileChange = value;
              });
            },
            initialValue: widget.mobile,
            autofocus: true,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ]),
      ),
    );
  }
}

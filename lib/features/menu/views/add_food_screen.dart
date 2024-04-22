import 'dart:io';

import 'package:ddnangcao_project/models/category.dart';
import 'package:ddnangcao_project/providers/add_food_provider.dart';
import 'package:ddnangcao_project/providers/category_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart ';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_lib.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  //final List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = '';
  List<String> listCateName = [];
  List<String> listCateId = [];
  List<Category> category = [];
  String cateId = "";
  String quantity = "";
  String price = "";
  File? _image;
  String foodName = "";

  getListStringCateName() {
    for (int i = 0; i < category.length; i++) {
      listCateName.add(category[i].name);
      listCateId.add(category[i].id);
    }
  }

  _selectCameraImage() async {
    final ImagePicker _imagePicker = ImagePicker();

    final im = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (im != null) {
      setState(() {
        _image = File(im.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //dropdownValue = list.first;
    Provider.of<CategoryProvider>(context, listen: false)
        .getAllCategory()
        .then((response) {
      setState(() {
        category = response;
      });
      getListStringCateName();
      dropdownValue = listCateName.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  foodName = value;
                },
                decoration: const InputDecoration(
                    hintText: "Enter Food Name", labelText: "Food Names"),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _selectCameraImage();
                    },
                    child: Container(
                      height: 60,
                      width: GetSize.getWidth(context) / 2.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorLib.primaryColor)),
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: ColorLib.primaryColor,
                            ),
                            Text("Choose Food Image")
                          ],
                        ),
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        cateId = listCateId[listCateName.indexOf(value)];
                      });
                      print(cateId);
                    },
                    items: listCateName
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: GetSize.getWidth(context) * .4,
                        child: TextFormField(
                          onChanged: (value) {
                            price = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "Enter Price", labelText: "Price"),
                        ),
                      ),
                      const Text("VND")
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    height: 50,
                    width: GetSize.getWidth(context) * .2,
                    child: TextFormField(
                      onChanged: (value) {
                        quantity = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Enter Quantity", labelText: "Quantity"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Provider.of<AddFoodProvider>(context, listen: false).addFood(foodName,
              cateId, "65aa9f6c56ab9f71f999e895", price, quantity, _image!);
        },
        child: Container(
          color: ColorLib.primaryColor,
          height: 50,
          width: GetSize.getWidth(context),
          child: const Center(
            child: Text(
              "Up Load",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

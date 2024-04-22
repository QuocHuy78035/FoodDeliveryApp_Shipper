import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ddnangcao_project/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/category.dart';
import '../../../providers/category_provider.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';
import '../../main/views/navbar_custom.dart';

class EditFoodScreen extends StatefulWidget {
  final String foodId;
  final String foodName;
  final String price;
  final String left;
  final String cateId;
  final String image;

  const EditFoodScreen(
      {super.key,
      required this.foodId,
      required this.foodName,
      required this.price,
      required this.image,
        required this.cateId,
      required this.left});

  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController leftController = TextEditingController();
  String nameChange = "";
  String priceChange = "";
  String leftChange = "";

  String dropdownValue = '';
  List<String> listCateName = [];
  List<String> listCateId = [];
  List<Category> category = [];
  String cateId = "";
  File? _image;

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
    cateId = widget.cateId;
    nameChange = widget.foodName;
    priceChange = widget.price;
    leftChange = widget.left;
    nameController.text = widget.foodName;
    priceController.text = widget.price;
    leftController.text = widget.left;
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
        title: const Text("Edit Food"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () async{
                if( nameChange != widget.foodName ||
                    priceChange != widget.price ||
                    leftChange != widget.left ||
                    _image != null){
                  EasyLoading.show();
                  await Provider.of<MenuProvider>(context, listen: false)
                      .editFood(widget.foodId, nameChange, cateId,
                      priceChange, leftChange, _image!);
                  EasyLoading.dismiss();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                  );
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  color: nameChange != widget.foodName ||
                          priceChange != widget.price ||
                          leftChange != widget.left ||
                          _image != null
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _image == null
                  ? SizedBox(
                      width: 130,
                      height: 130,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: widget.image,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : Column(
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
                    ),
              TextFormField(
                controller: nameController,
                onChanged: (value) {
                  nameChange = value;
                  setState(() {
                    nameChange = value;
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Enter Food Name", labelText: "Food Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: GetSize.getWidth(context) * .3,
                        child: TextFormField(
                          controller: priceController,
                          onChanged: (value) {
                            priceChange = value;
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
                    width: GetSize.getWidth(context) * .3,
                    child: TextFormField(
                      controller: leftController,
                      onChanged: (value) {
                        leftChange = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Quantity",
                        hintText: "Enter Quantity",
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: GetSize.getWidth(context) * .4,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          //icon: const Icon(Icons.arrow_downward),
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
                      ),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    //Provider.of<AddFoodProvider>(context, listen: false).addFood(foodName, cateId, "65aa9f6c56ab9f71f999e895", price, quantity, _image!);
                  },
                  child: Text("Up load"))
            ],
          ),
        ),
      ),
    );
  }
}

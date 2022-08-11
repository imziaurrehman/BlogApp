import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../customs.dart';

class Image_Picker extends StatefulWidget {
  const Image_Picker({
    Key? key,
  }) : super(key: key);

  @override
  State<Image_Picker> createState() => _Image_PickerState();
}

class _Image_PickerState extends State<Image_Picker> {
  ImagePicker imagePicker = ImagePicker();
  // File? pickedimage;

  XFile? image;
  Future imagegetter() async {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("choose one option"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              child: const Text("open gallery")),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context, ImageSource.camera);
              },
              child: const Text("open camera")),
        ],
      ),
    ).then((ImageSource? imageSource) async {
      image = await ImagePicker().pickImage(source: imageSource!);
      setState(() {
        if (image == null && imageSource == null) {
          return;
        } else {
          pickedimage = File(image!.path);
        }
      });
    });
  }

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        InkWell(
          child: pickedimage == null
              ? const Center(
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 55,
                  ),
                )
              : Center(
                  child: Image.file(
                    pickedimage!,
                    height: size.height * 0.3,
                    width: size.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
          onTap: () => isSelected ? null : imagegetter(),
        ),
        TextButton(
          style: TextButton.styleFrom(
            elevation: 0.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            backgroundColor: Color.fromARGB(255, 217, 189, 189),
          ),
          onPressed: () {
            print("image deleted");
            setState(() {
              pickedimage = null;
            });
          },
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

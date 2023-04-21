import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hola/common/colors.dart';
import 'package:hola/common/helper/show_alert.dart';
import 'package:hola/pages/image_picker.dart';
import 'package:hola/pages/widgets/custom_elevated_button.dart';
import 'package:hola/pages/widgets/custom_icon_button.dart';
import 'package:hola/pages/widgets/custom_text_field.dart';
import 'package:hola/pages/widgets/short_h_bar.dart';
import 'package:hola/repository/controller/auth_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key});

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  File? imageCamera;
  Uint8List? imagegallery;
  File? imageFile;
  late TextEditingController usernameController;

  saveUserDataToFirebase() {
    String username = usernameController.text;

    if (username.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please provide an username");
    } else if (username.length < 3 || username.length > 20) {
      return showAlertDialog(
          context: context,
          message: "A username should be between 3 to 20 letters");
    }
    ref.read(authControllerProvider).saveUserInfoToFirestore(
        username: username,
        profileImageUrl: imageCamera ?? imagegallery ?? '',
        context: context,
        mounted: mounted);
  }

  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortHBar(),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Profile Photo',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  CustomIconButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      icon: Icons.close),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  imagePickerIcon(
                      onTap: pickImageFromCamera,
                      icon: Icons.camera_alt_outlined,
                      text: 'Camera'),
                  const SizedBox(
                    width: 15,
                  ),
                  imagePickerIcon(
                      //onTap: () {},
                      onTap: () async {
                        Navigator.pop(context);
                        final image = await Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return const ImagePickerPage();
                        }));
                        if (image == null) return;
                        setState(() {
                          imageCamera = null;
                          imagegallery = image;
                        });
                      },
                      icon: Icons.photo_camera_back_rounded,
                      text: 'Gallery'),
                ],
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );
        });
  }

  void pickImageFromCamera() async {
    Navigator.pop(context);
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      cropImage(image!.path);
      setState(() {
        imageCamera = File(image.path);
        imagegallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void getFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          iconSize: 30,
          onTap: onTap,
          icon: icon,
          iconColor: ColorsApp.blueLight,
          minWidth: 50,
          border: Border.all(color: Colors.grey.shade200),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text(
            'Profile Info',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Please Provide an Username",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () => imagePickerTypeBottomSheet(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                          color: imageCamera == null && imagegallery == null
                              ? Colors.transparent
                              : Colors.grey.shade400),
                      image: imageCamera != null || imagegallery != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: imagegallery != null
                                  ? MemoryImage(imagegallery!) as ImageProvider
                                  : FileImage(imageCamera!))
                          : null),
                  child: Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: imageCamera == null && imagegallery == null
                          ? Colors.grey.shade400
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextForm(
                    controller: usernameController,
                    hintext: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.emoji_emotions_outlined),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomElevatedButton(
          onPressed: saveUserDataToFirebase,
          text: 'NEXT',
          buttonWidth: 90,
        ),
      ),
    );
  }
}

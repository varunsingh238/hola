import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hola/common/helper/show_alert.dart';
import 'package:hola/pages/widgets/custom_elevated_button.dart';
import 'package:hola/pages/widgets/custom_icon_button.dart';
import 'package:hola/repository/controller/auth_controller.dart';

import '../common/colors.dart';
import 'widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please enter your phone number.");
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
          context: context,
          message:
              "The phone number you entered is to short for $countryName.\n\nInclude your area code if you haven't.");
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
          context: context,
          message:
              "The phone number you entered is to long for $countryName.\n\nInclude your area code if you haven't.");
    }

    ref.read(authControllerProvider).sendSmsCode(
        context: context, phoneNumber: '+$countryCode$phoneNumber');
  }

  showNationPicker() {
    showCountryPicker(
      context: context,
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
      favorite: ['IND'],
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).backgroundColor,
        flagSize: 22,
        textStyle: Theme.of(context).textTheme.titleMedium,
        inputDecoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: const Icon(
            Icons.language,
            color: ColorsApp.blueLight,
          ),
          hintText: 'Search country code or name',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    countryNameController = TextEditingController(text: "India");
    countryCodeController = TextEditingController(text: "91");
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    countryCodeController.dispose();
    countryNameController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CustomIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Enter your phone number",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            CustomIconButton(
              icon: Icons.more_vert,
              onTap: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Holaa needs to verify your phone number.   ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const [
                        TextSpan(
                            text: "What's my number?",
                            style: TextStyle(color: Colors.blue))
                      ]),
                ),
              ),
              Image(
                image: const AssetImage(
                  "assets/images/login.gif",
                ),
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextForm(
                  controller: countryNameController,
                  ontap: () => showNationPicker(),
                  readonly: true,
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: CustomTextForm(
                        ontap: () => showNationPicker,
                        controller: countryCodeController,
                        prefixText: '+',
                        readonly: true,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextForm(
                        controller: phoneNumberController,
                        hintext: "phone number",
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Carrier charges may apply",
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomElevatedButton(
          onPressed: () => sendCodeToPhone(),
          text: 'NEXT',
          buttonWidth: 90,
        ),
      ),
    );
  }
}

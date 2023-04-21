// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:hola/pages/widgets/custom_icon_button.dart';
import 'package:hola/pages/widgets/custom_text_field.dart';
import 'package:hola/repository/controller/auth_controller.dart';

class Verificationpage extends ConsumerWidget {
  const Verificationpage({
    Key? key,
    required this.smsCodeId,
    required this.phoneNumber,
  }) : super(key: key);
  final String smsCodeId;
  final String phoneNumber;

  void verifySmsCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Verify your number",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          actions: [CustomIconButton(onTap: () {}, icon: Icons.more_vert)],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const [
                        TextSpan(
                            text:
                                "+91-8697594823 wait for an sms to arrive or request a call."),
                        TextSpan(
                            text: "\nWrong number?",
                            style: TextStyle(color: Colors.blue))
                      ]),
                ),
              ),
              Image(
                image: const AssetImage("assets/images/otp.gif"),
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomTextForm(
                  onChanged: (value) {
                    if (value.length == 6) {
                      return verifySmsCode(context, ref, value);
                    }
                  },
                  hintext: '_ _ _  _ _ _',
                  keyboardType: TextInputType.number,
                  fontSize: 30,
                  autoFocus: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Enter 6-digit code',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.message,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Resend SMS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.blue.shade200,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Request a call',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hola/pages/widgets/custom_icon_button.dart';

import '../../common/colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  showBottomSheet(context) {
    return showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                      color: ColorsApp.greyLight,
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        icon: Icons.close_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("App Language",
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey.shade800,
                  ),
                ),
                RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Colors.lightBlue,
                  title: Text(
                    'English',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    "(phone's language)",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: ColorsApp.blueDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.language,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              Text('English'),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_ui/screens/mobile_layout_screen.dart';

import '../../colors.dart';
import '../../common/widgets/custom_button.dart';
import '../auth/screens/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final toastController = TextEditingController();

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, MobileLayoutScreen.routeName).then((_) {
      // Set text controller to empty after navigation
      toastController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height / 9),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: toastController,
                decoration: const InputDecoration(
                  hintText: 'Enter anything',
                ),
                onChanged: (value) {
                  if (value == "dev💓devi") {
                    // Navigate to the login screen if specific text is typed
                    navigateToLoginScreen(context);
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'Show Message',
                onPressed: () {
                  if (toastController.text.isNotEmpty &&
                      toastController.text != "dev💓devi") {
                    Fluttertoast.showToast(
                      msg: toastController.text,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    toastController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the text controller when the widget is disposed
    toastController.dispose();
    super.dispose();
  }
}

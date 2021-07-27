import 'package:flutter/material.dart';
import 'package:tourpedia/ui/pages/login.dart';
import 'package:tourpedia/ui/pages/register.dart';
import 'package:tourpedia/ui/widgets/custom_button.dart';
import 'package:tourpedia/ui/widgets/custom_button_login.dart';
import 'package:tourpedia/utils/my_colors.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Expanded(
            flex: 4,
            child: Center(
              child: Image(
                width: 267,
                image: AssetImage(
                    'lib/assets/images/illustration_logo_vertical.png'),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              //height: 100,
              //margin: const EdgeInsets.only(top: 10),
              //transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: MyColors.blueThird,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 27, color: MyColors.white),
                        children: [
                          TextSpan(text: "Let's start on vacation to "),
                          TextSpan(
                              text: "Bandung",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // child: Text(
                    //   "Let's start on vacation to Bandung",
                    //   style: TextStyle(fontSize: 25, color: Colors.white),
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                  Column(
                    children: [
                      CustomButtonLogin(
                        title: "Login",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ));
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        title: 'Register',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

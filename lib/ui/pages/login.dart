import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:sp_util/sp_util.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'package:tourpedia/models/user_model.dart';
import 'package:tourpedia/ui/pages/register.dart';
import 'package:tourpedia/ui/widgets/bottom_tab_bar.dart';
import 'package:tourpedia/ui/widgets/custom_button_small.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:http/http.dart' as http;
import 'package:tourpedia/utils/settings.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  bool canLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blueFour,
      body: ListView(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            padding: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
            width: double.infinity,
            color: MyColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Image(
                  //color: MyColors.white,
                  image: AssetImage(
                      'lib/assets/images/illustration_logo_text.png'),
                  height: 45,
                ),
              ],
            ),
          ),

          Stack(
            children: [
              Container(
                height: 20,
                color: MyColors.white,
              ),
              Container(
                height: 20,
                decoration: const BoxDecoration(
                    color: MyColors.blueFour,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              )
            ],
          ),

          const Padding(
            padding: EdgeInsets.only(left: 24, top: 6, bottom: 52),
            child: Text(
              'LOGIN',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: textEditingControllerEmail,
              decoration: const InputDecoration(
                  fillColor: MyColors.greySecond,
                  labelText: "Email",
                  labelStyle: TextStyle(
                      color: MyColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 80),
            child: TextField(
              controller: textEditingControllerPassword,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(
                      color: MyColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),

          Center(
            child: CustomButtonSmall(
              title: 'MASUK',
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => FutureProgressDialog(
                    _login(),
                    message: const Text('Loading'),
                  ),
                );
                (canLogin) ? Navigator.pop(context) : null;
                (canLogin)
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomTabBar(),
                        ))
                    : null;
              },
            ),
          ),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Belum punya akun?  ',
                style: TextStyle(fontSize: 14),
              ),
              TouchableOpacity(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Future _login() async {
    String url = Settings.urlBackend + "/api/user/login";
    try {
      if (textEditingControllerEmail.text.isEmpty &&
          textEditingControllerPassword.text.isEmpty) {
        showTopSnackBar(
            context,
            const CustomSnackBar.error(
                message: 'Email dan Password harus diisi'));
        return null;
      }

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Accept": "aplication/json"},
        body: {
          "email": textEditingControllerEmail.text,
          'password': textEditingControllerPassword.text
        },
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);

        final userModel = userModelFromJson(response.body);
        SpUtil.putString('token', userModel.data.accessToken);
        SpUtil.putString('email', userModel.data.user.email);
        SpUtil.putString('name', userModel.data.user.name);
        (userModel.data.user.phone != null)
            ? SpUtil.putString('phone', userModel.data.user.phone)
            : null;
        SpUtil.putString('photo', userModel.data.user.profilePhotoUrl);
        SpUtil.putInt('id', userModel.data.user.id);

        canLogin = true;

        return '';

        // showTopSnackBar(context,
        //     CustomSnackBar.info(message: textEditingControllerPassword.text));

      } else {
        throw ('Email atau Password salah');
      }
    } catch (e) {
      debugPrint("error catch $e");
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
      return null;
    }
  }
}

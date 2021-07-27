import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:sp_util/sp_util.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/models/tourism_model.dart' as tourism_model;
import 'package:tourpedia/models/user_model.dart';
import 'package:tourpedia/ui/pages/login.dart';
import 'package:tourpedia/ui/widgets/bottom_tab_bar.dart';
import 'package:tourpedia/ui/widgets/custom_button.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerPhone = TextEditingController();
  TextEditingController textEditingControllerRetypePassword =
      TextEditingController();

  bool canRegister = false;

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
              controller: textEditingControllerName,
              decoration: const InputDecoration(
                  fillColor: MyColors.greySecond,
                  labelText: "Nama",
                  labelStyle: TextStyle(
                      color: MyColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: TextField(
              controller: textEditingControllerEmail,
              decoration: const InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(
                      color: MyColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: TextField(
              controller: textEditingControllerPhone,
              decoration: const InputDecoration(
                  labelText: "No Telephone",
                  labelStyle: TextStyle(
                      color: MyColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
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

          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 80),
            child: TextField(
              controller: textEditingControllerRetypePassword,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Retype Password",
                  labelStyle: TextStyle(
                      color: MyColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
          ),

          Center(
              child: CustomButton(
            title: 'DAFTAR',
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => FutureProgressDialog(
                  _register(),
                  message: const Text('Loading'),
                ),
              );
              (canRegister) ? Navigator.pop(context) : null;
              (canRegister)
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomTabBar(),
                      ))
                  : null;
            },
          )),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sudah punya akun?  ',
                style: TextStyle(fontSize: 14),
              ),
              TouchableOpacity(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Future<tourism_model.TourismModel?> _register() async {
    String url = Settings.urlBackend + "/api/user/register";
    try {
      if (textEditingControllerEmail.text.isEmpty &&
          textEditingControllerPassword.text.isEmpty &&
          textEditingControllerRetypePassword.text.isEmpty &&
          textEditingControllerName.text.isEmpty &&
          textEditingControllerPhone.text.isEmpty) {
        showTopSnackBar(
            context, const CustomSnackBar.error(message: 'Semua Harus diisi'));
        return null;
      }

      if (textEditingControllerPassword.text !=
          textEditingControllerRetypePassword.text) {
        showTopSnackBar(
            context,
            const CustomSnackBar.error(
                message: 'Password dan Retype Password harus sama'));
        return null;
      }

      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Accept": "aplication/json"},
        body: {
          "email": textEditingControllerEmail.text,
          'password': textEditingControllerPassword.text,
          'name': textEditingControllerName.text,
          'phone': textEditingControllerPhone.text
        },
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);

        final userModel = userModelFromJson(response.body);
        SpUtil.putString('token', userModel.data.accessToken);
        SpUtil.putString('email', userModel.data.user.email);
        SpUtil.putString('name', userModel.data.user.name);
        SpUtil.putString('photo', userModel.data.user.profilePhotoUrl);
        SpUtil.putInt('id', userModel.data.user.id);
        SpUtil.putString('phone', userModel.data.user.phone);

        canRegister = true;

        return null;
      }
      if (response.statusCode == 500) {
        throw ('Email sudah terdaftar sebelumnya');
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

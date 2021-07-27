import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:sp_util/sp_util.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:tourpedia/ui/pages/get_started.dart';
import 'package:tourpedia/ui/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = SpUtil.getString('name', defValue: '')!;
  String phone = SpUtil.getString('phone', defValue: '')!;
  String email = SpUtil.getString('email', defValue: '')!;
  bool canLogout = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blueThird,
      appBar: AppBar(
        backgroundColor: MyColors.bluePrimary,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Image(
            image: AssetImage('lib/assets/images/ilustration_profile.png'),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.account_circle, size: 75, color: MyColors.white),
              Text(
                name,
                style: const TextStyle(
                    color: MyColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: const TextStyle(
                    color: MyColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              const SizedBox(height: 5),
              Text(
                phone,
                style: const TextStyle(
                    color: MyColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const ListTile(
                            title: Text('Kebijakan Privasi'),
                          ),
                          const Divider(
                            thickness: 2,
                            height: 0,
                          ),
                          const ListTile(
                            title: Text('Tentang Tourpedia'),
                          ),
                          const Divider(
                            thickness: 2,
                            height: 0,
                          ),
                          const ListTile(
                            title: Text('Creator'),
                          ),
                          const Divider(
                            thickness: 2,
                            height: 0,
                          ),
                        ],
                      ),
                      CustomButton(
                        title: 'LOGOUT',
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => FutureProgressDialog(
                              _logout(),
                              message: const Text('Loading'),
                            ),
                          );
                          (canLogout)
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GetStarted(),
                                  ))
                              : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _logout() async {
    String url = Settings.urlBackend + '/api/user/logout';
    String token = SpUtil.getString('token', defValue: '')!;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "aplication/json",
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);

        SpUtil.clear();
        canLogout = true;

        return null;
      } else {
        throw ('Logout Gagal');
      }
    } catch (e) {
      debugPrint("error catch $e");
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
      return null;
    }
  }
}

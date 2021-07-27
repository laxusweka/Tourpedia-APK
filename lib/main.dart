import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tourpedia/ui/pages/get_started.dart';
import 'package:http/http.dart' as http;
import 'package:tourpedia/ui/widgets/bottom_tab_bar.dart';
import 'package:tourpedia/utils/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  String url = Settings.urlBackend + '/api/user/about-me';
  bool isLogin = false;
  String token = SpUtil.getString('token', defValue: '')!;

  try {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Data login berhasil");
      isLogin = true;
    } else {
      debugPrint("Data login Gagal");
      isLogin = false;
    }
  } catch (e) {
    debugPrint("Data login Gagal");
    isLogin = false;
  }

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({Key? key, required this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Tourpedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: (isLogin) ? const BottomTabBar() : const GetStarted(),
    );
  }
}

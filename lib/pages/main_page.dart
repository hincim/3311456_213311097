import 'package:flutter/material.dart';
import 'package:kelimeezberle/global_widget/app_bar.dart';
import 'package:kelimeezberle/pages/word_list_page.dart';
import 'package:kelimeezberle/practical_method.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum Lang { eng, tr }
// daha okunaklı olması için enum yapısını kullanırım.

final Uri _urlGithub = Uri.parse('https://github.com/hincim');
final Uri _urlGmail = Uri.parse('hakanincim4@gmail.com');

Future<void> _launchUrlGithub() async {
  if (!await launchUrl(_urlGithub)) {
    throw Exception('Could not launch $_urlGithub');
  }
}

/*Future<void> _launchUrlGmail() async {
  if (!await launchUrl(_urlGmail)) {
    throw Exception('Could not launch $_urlGmail');
  }
}*/

class _MainPageState extends State<MainPage> {
  Lang? _chooseLang = Lang.eng;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bununla drawerı açacağım.

  PackageInfo? packageInfo;
  String version = "";

  @override
  void initState() {
    super.initState();
    packageInfoInit();
  }

  void packageInfoInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    // bununla versiyon bilgisini çekerim.

    setState(() {
      version = packageInfo!.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width / 5;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 80,
                  ),
                  Text(
                    "WordHive",
                    style: TextStyle(fontFamily: "RobotoLight", fontSize: 26),
                  ),
                  Text(
                    "İstediğini öğren.",
                    style: TextStyle(fontFamily: "RobotoLight", fontSize: 16),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Divider(
                        color: Colors.black,
                      )),
                  Container(
                    margin:
                        EdgeInsets.only(top: 50, right: 8, left: 8, bottom: 8),
                    child: InkWell(
                      onTap: () async {
                        _launchUrlGithub();
                      },
                      child: Text(
                        "Github",
                        style: TextStyle(
                            fontFamily: "RobotoLight",
                            fontSize: 16,
                            color: Color(PracticalMethod.HexaColorConvertColor(
                                "#0A588D"))),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "İletişim için hakanincim4@gmail.com"
                      "\n\nv$version",
                  style: TextStyle(
                      fontFamily: "RobotoLight",
                      fontSize: 14,
                      color: Color(
                          PracticalMethod.HexaColorConvertColor("#0A588D"))),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: appBar(context, left: const FaIcon(
        FontAwesomeIcons.bars,
        color: Colors.black,
        size: 20,
      ), center: Image.asset("assets/images/logo.png"),
      leftWidgetOnClick: ()=>{_scaffoldKey.currentState?.openDrawer()}),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              langRadioButton(
                  screenSizeWidth: screenSizeWidth,
                  text: "İngilizce - Türkçe",
                  group: _chooseLang,
                  value: Lang.tr),
              langRadioButton(
                  screenSizeWidth: screenSizeWidth,
                  text: "Türkçe - İngilizce",
                  value: Lang.eng,
                  group: _chooseLang),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WordListPage()));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Listelerim",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: "Carter",
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(PracticalMethod.HexaColorConvertColor(
                                "#2da2a6")),
                            Color(PracticalMethod.HexaColorConvertColor(
                                "#476462")),
                          ],
                          tileMode: TileMode.repeated)),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCard(context,
                        startColor: "#1DACC9",
                        endColor: "#0C33B2",
                        title: "Kelime\nKartları"),
                    buildCard(context,
                        startColor: "#FF4081",
                        endColor: "#FF3348",
                        title: "Çoktan\nSeçmeli")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildCard(
    BuildContext context, {
    @required String? startColor,
    @required String? endColor,
    @required String? title,
  }) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width * 0.37,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title!,
            style: TextStyle(
                fontSize: 28, fontFamily: "Carter", color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.file_copy,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(PracticalMethod.HexaColorConvertColor(startColor!)),
                Color(PracticalMethod.HexaColorConvertColor(endColor!)),
              ],
              tileMode: TileMode.repeated)),
    );
  }

  Padding langRadioButton(
      {@required double? screenSizeWidth,
      @required String? text,
      @required Lang? value,
      @required Lang? group}) {
    // bunları kesin gönder diyorum yoksa doğru çalışmam.
    return Padding(
      padding: EdgeInsets.only(left: screenSizeWidth!),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title:
            Text(text!, style: TextStyle(fontFamily: "Carter", fontSize: 15)),
        leading: Radio<Lang>(
          value: value!,
          groupValue: group,
          onChanged: (Lang? value) {
            setState(() {
              _chooseLang = value;
            });
          },
        ),
      ),
    );
  }
}

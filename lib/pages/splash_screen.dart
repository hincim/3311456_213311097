import 'package:flutter/material.dart';
import 'package:kelimeezberle/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2),(){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
      const MainPage()
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/images/logo.png"),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Kelime Ezberle",style: TextStyle(color: Colors.black,
                          fontFamily: "Carter",fontSize: 40),),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text("İstediğini Öğren",style: TextStyle(color: Colors.black,
                      fontFamily: "Carter",fontSize: 25),),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text("Pratik Yap",style: TextStyle(color: Colors.black,
                      fontFamily: "Carter",fontSize: 25),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}














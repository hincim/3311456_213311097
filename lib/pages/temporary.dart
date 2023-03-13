import 'package:flutter/material.dart';

class TemporaryPage extends StatefulWidget {
  const TemporaryPage({Key? key}) : super(key: key);

  @override
  State<TemporaryPage> createState() => _TemporaryPageState();
}

class _TemporaryPageState extends State<TemporaryPage> {
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
                    Image.asset("assets/images/orneklogo.png"),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}














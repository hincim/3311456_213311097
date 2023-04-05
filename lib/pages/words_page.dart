import 'package:flutter/material.dart';
import 'package:kelimeezberle/database/dao.dart';

import '../global_widget/app_bar.dart';
import '../models/words.dart';
import '../practical_method.dart';

class WordsPage extends StatefulWidget {
  final int ?listID;
  final String ?listName;

  const WordsPage(this.listID, this.listName,{Key? key}) : super(key: key);

  @override
  State<WordsPage> createState() => _WordsPageState(listID: listID,listName: listName);
}

class _WordsPageState extends State<WordsPage> {
  int ?listID;
  String ?listName;

  _WordsPageState({@required this.listID, @required this.listName});

  List<Word> _wordList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("$listID - $listName");
    getWordByList();
  }

  void getWordByList() async{


    _wordList = await DB.instance.getWordByList(listID);
    setState(() => _wordList);
    // sayfaya kelimelerin geldiğini bildiririm.

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: appBar(context, left: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 22,
      ), center: Text(listName!, style: TextStyle(fontFamily: "carter",fontSize: 22,
      color: Colors.black),),
          right:Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Image.asset("assets/images/logo.png",
              height: 80,width: 80,)
          ) ,
          leftWidgetOnClick: ()=>{
            Navigator.pop(context)
          }),

      body: SafeArea(
        child: ListView.builder(itemBuilder: (context, index) {
          
          return wordItem(_wordList[index].id!,
              index, word_tr: _wordList[index].word_tr, word_eng: _wordList[index].word_eng, status: _wordList[index].status);
        },
        itemCount: _wordList.length,),
      ),
    );
  }

  Center wordItem(int wordId, int index, {@required String ?word_tr,
  @required String ?word_eng, @required bool ?status}) {
    return Center(
            child: Container(
              width: double.infinity,
              child: Card(
                color: Color(PracticalMethod.HexaColorConvertColor("#2da2a6")),
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                margin: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15,top: 10),
                          child: Text(word_tr!,style: TextStyle(color: Colors.black,
                              fontSize: 18,fontFamily: "RobotoMedium"),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30,bottom: 10),
                          child: Text(word_eng!,style: TextStyle(color: Colors.black,
                              fontSize: 16,fontFamily: "RobotoRegular"),),
                        ),
                      ],
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      hoverColor: Colors.blueAccent,
                      value: status,
                      onChanged: (bool? value){

                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

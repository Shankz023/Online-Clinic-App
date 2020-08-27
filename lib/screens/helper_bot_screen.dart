import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelperBotScreen extends StatefulWidget {
  @override
  _HelperBotScreenState createState() => _HelperBotScreenState();
}

class _HelperBotScreenState extends State<HelperBotScreen> {

  void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/application2.json")
        .build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });


    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }


  var height,width;
  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  Widget chat(String msg,int data){
    return Container(padding: EdgeInsets.only(left: 20, right: 20),

      child: Row(
        mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [

          data == 0 ? Container(
            height: 60,
            width: 60,
            child: Icon(FontAwesomeIcons.robot,color: Colors.redAccent,)
          ) : Container(),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0 ? Color.fromRGBO(23, 157, 139, 1) : Colors.orangeAccent,
                elevation: 0.0,

                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                            constraints: BoxConstraints( maxWidth: 200),
                            child: Text(
                              msg,
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                )),
          ),


          data == 1? Container(
            height: 60,
            width: 60,
            child: Icon(Icons.account_circle,color: Colors.redAccent,)
          ) : Container(),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Helper Bot'),
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.black54,
          child: Column(
            children: <Widget>[
              Flexible(
                  child: ListView.builder(
                      reverse: true,
                      itemCount: messsages.length,
                      itemBuilder: (context, index) => chat(
                          messsages[index]["message"].toString(),
                          messsages[index]["data"])
                  )
              ),
                SizedBox(
                  height: 20,
                ),

                Divider(
                  height: 5.0,
                  color: Colors.greenAccent,
                ),
              ListTile(
                title: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
                  child: TextFormField(
                    cursorColor: Colors.redAccent,
                    controller: messageInsert,
                    decoration: InputDecoration(hintText: 'Enter Your question',border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,),style: TextStyle(color: Colors.white70),
                  ),
                ),
                trailing: IconButton(icon: Icon(Icons.send,color: Colors.redAccent,), onPressed: (){
                  if(messageInsert.text.isNotEmpty){
                    setState(() {
                      messsages.insert(0, {"data": 1, "message": messageInsert.text});
                    });
                    response(messageInsert.text);
                    messageInsert.clear();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }
                },),
              ),
            ],
          )
      ),
    );
  }
}

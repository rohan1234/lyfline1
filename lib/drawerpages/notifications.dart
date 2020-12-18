import 'dart:convert';
import 'package:flutter/material.dart';
class Notification1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Activity",style: TextStyle(color: Colors.white,fontFamily: 'Pacifico'),),
            backgroundColor: Colors.black,
            leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,), onPressed: (){}),
            actions: [
              Column(
                children: [
                  SizedBox(height: 15,),
                  Container(
                    child: Material(
                      color: Colors.grey,
                      child: TabBar(tabs: [
                        Tab(child: Text("Followers",style: TextStyle(color: Colors.black,fontFamily: 'Pacifico'),),),
                        Tab(child: Text("Likes",style: TextStyle(color: Colors.black,fontFamily: 'Pacifico'),),),
                        Tab(child: Text("Comments",style: TextStyle(color: Colors.black,fontFamily: 'Pacifico'),),),
                      ]),
                    ),
                  )
                ],
              )
            ],
            ),
        ));
  }
}

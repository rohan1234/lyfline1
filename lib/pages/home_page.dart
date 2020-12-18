import 'dart:convert';

import 'package:TikTokUI/constant/data_json.dart';
import 'package:TikTokUI/drawerpages/Search.dart';
import 'package:TikTokUI/drawerpages/block.dart';
import 'package:TikTokUI/drawerpages/logout.dart';
import 'package:TikTokUI/drawerpages/notifications.dart';
import 'package:TikTokUI/drawerpages/report.dart';
import 'package:TikTokUI/drawerpages/save.dart';
import 'package:TikTokUI/pages/UserProfile.dart';
import 'package:TikTokUI/pages/BuildMoreOption.dart';
import 'package:TikTokUI/widgets/ExploreTabView.dart';
import 'package:TikTokUI/widgets/moreOption.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:TikTokUI/widgets/FollowingplayerItem.dart';
import 'package:video_player/video_player.dart';
class HomePage extends StatefulWidget {

  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  bool like = false;
  void initState() {
    super.initState();

    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void choiceAction(String choice) {}
  bool followbutton = true;
  bool explorebutton = false;
  void buttonFollowing() {}
  // Future<bool> _onBackPressed() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text('Do you want to exit the app'),
  //             actions: <Widget>[
  //               FlatButton(
  //                   onPressed: () => {Navigator.pop(context, false)},
  //                   child: Text('No')),
  //               FlatButton(
  //                   onPressed: () => {Navigator.pop(context, true)},
  //                   child: Text('Yes'))
  //             ],
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(icon: Icon(Icons.close), onPressed: (){})
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      CircleAvatar( radius: 40,
                      backgroundImage: AssetImage('assets/userimage.png'),
                    ),
                    //SizedBox(width: 20,),
                    Column(
                      children: [
                        Text("User Name",style: TextStyle(fontSize: 18.0,fontFamily: 'Pacifico'),),
                        Text("@User Id",style: TextStyle(fontSize: 13.0,fontFamily: 'Pacifico'),),
                      ],
                    ),
                    IconButton(icon: Icon(Icons.search), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));})


                  ],
                )
              ],
              )),
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey))
                ),
              ),
              customTile(Icons.search,'Search',(){Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));}),
              customTile(Icons.save_alt,'Save',(){Navigator.push(context, MaterialPageRoute(builder: (context) => Save()));}),
              customTile(Icons.notifications_none,'Notification',(){Navigator.push(context, MaterialPageRoute(builder: (context) => Notification1()));}),
              customTile(Icons.block,'Blocked User',(){Navigator.push(context, MaterialPageRoute(builder: (context) => Block()));}),
              customTile(Icons.close,'Report',(){Navigator.push(context, MaterialPageRoute(builder: (context) => Report()));}),
              SizedBox(height: 250,),
              Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey))
                ),
              ),
              customTile(Icons.label_important,'Logout',(){Navigator.push(context, MaterialPageRoute(builder: (context) => Log()));}),
            ],
          ),
        ),
        appBar: AppBar(
          leading:
          IconButton(icon: Icon(Icons.more_vert,color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
               ),

          elevation: 0,
          title: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: GoogleFonts.pacifico(
                fontStyle: FontStyle.italic,
                fontSize: MediaQuery.of(context).textScaleFactor * 16,
                textStyle: TextStyle(
                  color: Colors.white,
                )),
            tabs: <Widget>[
              Tab(
                text: "Following",
              ),
              Tab(
                text: "Explore",
              ),
            ],
          ),
          backgroundColor: Colors.transparent.withOpacity(0),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: CircleAvatar(),
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: TabBarView(
          children: <Widget>[
            getFollowingBody(),
            getExploreBody(),
          ],
        ),
        // floatingActionButton: Container(
        //   width: 80,
        //   height: 80,
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => VideoCamera()));
        //       },
        //       child: Center(
        //         child: Image.asset(
        //           'assets/Middleone.png',
        //           width: 45,
        //           height: 45,
        //         ),
        //       ),
        //       backgroundColor: Colors.white,
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget getFollowingBody() {
    var size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children: List.generate(items.length, (index) {
          return FollowPlayerItem(
            videoUrl: items[index]['videoUrl'],
            size: size,
            name: items[index]['name'],
            caption: items[index]['caption'],
            songName: items[index]['songName'],
            profileImg: items[index]['profileImg'],
            likes: items[index]['likes'],
            comments: items[index]['comments'],
            shares: items[index]['shares'],
            views: items[index]['views'] ?? 10,
          );
        }),
      ),
    );
  }

  getExploreBody() {
    var size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children: List.generate(items.length, (index) {
          return ExplorePlayerItem(
            videoUrl: items[index]['videoUrl'],
            size: size,
            name: items[index]['name'],
            caption: items[index]['caption'],
            songName: items[index]['songName'],
            profileImg: items[index]['profileImg'],
            likes: items[index]['likes'],
            comments: items[index]['comments'],
            shares: items[index]['shares'],
            views: items[index]['views'] ?? 10,
          );
        }),
      ),
    );
  }
}

class customTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  customTile(this.icon,this.text,this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          child: Row(
            children: [
              Icon(icon),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,style: TextStyle(fontSize: 15.0,fontFamily: 'Pacifico'),),
              )
            ],
          ),
        ),
      ),
    );
  }
}


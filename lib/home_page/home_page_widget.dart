import 'dart:io';
import 'dart:math';

import 'package:afro_jam/video_call/template.dart';
import 'package:afro_jam/video_call/video_call_page.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'dart:ui' as ui;
import '../backend/api_requests/api_calls.dart';
import '../chat_page/chat_page_widget.dart';
import '../flutter_flow/flutter_flow_audio_player.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../my_playlist/my_playlist_widget.dart';
import '../playlist_page/playlist_page_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../song_page/song_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({
    Key key,
    this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {

  var rng = new Random();

  final subjectText = TextEditingController(text: "Afro Jam Room");

  //transparent blue
  bool isAudioMuted = false;
  bool isVideoMuted = false;

  TextEditingController searchTextFieldController;
  dynamic searchPlaylistResult;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _validateName(String value) {
    if (value.length < 6)
      return 'Min 8 letters';
  }

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    searchTextFieldController = TextEditingController();
  }

  String _meetingId;
  String _meetingPw;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Future<void> _showStartVideoCallDialog() async {
      return showDialog<void>(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: AlertDialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                children: [
                  Image.asset('assets/images/Assets-1-05.png',height: 120,),
              SizedBox(height: 20,),
              Text('Start a Video Call',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: h * 0.020
                ),)
                ],
              ),
              content: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: (){
                        isAudioMuted = !isAudioMuted;
                        Navigator.pop(context);
                        _showStartVideoCallDialog();
                      },
                      backgroundColor: Colors.black,
                      child: isAudioMuted
                          ? Icon(Icons.mic_off, color: Colors.white70,)
                          :Icon(Icons.mic, color: Colors.deepOrange,),
                    ),
                    FloatingActionButton(
                      onPressed: (){
                        isVideoMuted = !isVideoMuted;
                        Navigator.pop(context);
                        _showStartVideoCallDialog();
                      },
                      backgroundColor: Colors.black,
                      child: isVideoMuted
                          ? Icon(Icons.videocam_off, color: Colors.white70,)
                          :Icon(Icons.videocam, color: Colors.deepOrange ,)
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'CONNECT',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    _startMeeting();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _showJoinVideoCallDialog() async {
      return showDialog<void>(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: AlertDialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                children: [
                  Image.asset('assets/images/Assets-1-05.png',height: 120,),
                  SizedBox(height: 20,),
                  Text('Join a Video Call',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: h * 0.020
                    ),)
                ],
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => _validateName(val),
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          hintText: 'Meeting ID',
                          fillColor: Colors.white70,
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: FlutterFlowTheme.subtitle1.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _meetingId = val;
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'CONNECT',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      _joinMeeting(_meetingId);
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _showVideoCallDialog() async {
      return showDialog<void>(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Column(
                children: [
                  Image.asset(
                    'assets/images/videocall.png',
                    height: h * 0.25,
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text('Video Call',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: h * 0.020
                          )
                      )
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'START',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showStartVideoCallDialog();
                  },
                ),
                FlatButton(
                  child: Text(
                    'JOIN',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    //await _auth.signOut();
                    Navigator.pop(context);
                    _showJoinVideoCallDialog();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Container(
          decoration: BoxDecoration(
            color: Color(0x00EEEEEE),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0x00FFFFFF),
              borderRadius: BorderRadius.circular(55),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(55),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchTextFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                          child: InkWell(
                            onTap: () async {
                              searchPlaylistResult = await searchPlaylistCall(
                                text: searchTextFieldController.text,
                              );
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaylistPageWidget(
                                    playlistDetails: searchPlaylistResult,
                                  ),
                                ),
                              );

                              setState(() {});
                            },
                            child: Icon(
                              Icons.search_sharp,
                              color: Color(0xFF6C6C6C),
                              size: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePageWidget(
                          userData: widget.userData,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      getJsonField(widget.userData, r'''$.avatar'''),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.black,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: Image.asset(
                  'assets/images/Assets-1-05.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Divider(
                thickness: 1,
                color: Color(0xFFC3C3C3),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPlaylistWidget(
                          userid: widget.userData,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                        child: Icon(
                          Icons.playlist_play_outlined,
                          color: Color(0xFF838383),
                          size: 24,
                        ),
                      ),
                      Text(
                        'My Playlist',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF838383),
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    _showVideoCallDialog();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                        child: Icon(
                          Icons.voice_chat,
                          color: Color(0xFF838383),
                          size: 24,
                        ),
                      ),
                      Text(
                        'Video Call',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF838383),
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                child: InkWell(
                  onTap: () async {
                    await launchURL('https://afrojam.com.au/#');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                        child: Icon(
                          Icons.error_outline_sharp,
                          color: Color(0xFF838383),
                          size: 24,
                        ),
                      ),
                      Text(
                        'About',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF838383),
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          //backgroundColor: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  labelColor: Color(0xFFFF4700),
                  unselectedLabelColor: Color(0xFFFFA885),
                  labelStyle: FlutterFlowTheme.bodyText1,
                  indicatorColor: Color(0xFFFF4700),
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home_outlined,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.notifications_none,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.ondemand_video_outlined,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0x00EEEEEE),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Text(
                                    'Top Songs',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FutureBuilder<dynamic>(
                                    future: getTracksCall(),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (snapshot.hasData) {
                                        final listViewGetTracksResponse =
                                            snapshot.data;
                                        return Builder(
                                          builder: (context) {
                                            final tracks = (getJsonField(
                                                listViewGetTracksResponse,
                                                r'''$''')
                                                ?.toList() ??
                                                [])
                                                .take(30)
                                                .toList();
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              itemCount: tracks.length,
                                              itemBuilder:
                                                  (context, tracksIndex) {
                                                final tracksItem =
                                                tracks[tracksIndex];
                                                return Padding(
                                                  padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 15, 5, 0),
                                                  child: ListTile(
                                                    leading: Image.network(
                                                      getJsonField(tracksItem,
                                                          r'''$.art'''),
                                                      // width: 50,
                                                      // height: 100,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    title: Text(
                                                      '${getJsonField(tracksItem, r'''$
                                                                .title''').toString()}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),
                                                    subtitle: Text(
                                                      '${getJsonField(tracksItem,
                                                          r'''$.user.full_name''').toString()}',
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 12),
                                                    ),
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SongPageWidget(
                                                                id: getJsonField(
                                                                    tracksItem,
                                                                    r'''$.id''')
                                                                    .toString(),
                                                                userData:
                                                                widget.userData,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                                // return Padding(
                                                //   padding: EdgeInsetsDirectional
                                                //       .fromSTEB(10, 0, 0, 20),
                                                //   child: Container(
                                                //     width: MediaQuery.of(context)
                                                //             .size
                                                //             .width *
                                                //         1,
                                                //     height: 100,
                                                //     decoration: BoxDecoration(
                                                //       color: Color(0x00EEEEEE),
                                                //     ),
                                                //     child: Row(
                                                //       mainAxisSize:
                                                //           MainAxisSize.max,
                                                //       children: [
                                                //         InkWell(
                                                //           onTap: () async {
                                                //             await Navigator.push(
                                                //               context,
                                                //               MaterialPageRoute(
                                                //                 builder: (context) =>
                                                //                     SongPageWidget(
                                                //                   id: getJsonField(
                                                //                           tracksItem,
                                                //                           r'''$.id''')
                                                //                       .toString(),
                                                //                   userData: widget
                                                //                       .userData,
                                                //                 ),
                                                //               ),
                                                //             );
                                                //           },
                                                //           child: ClipRRect(
                                                //             borderRadius:
                                                //                 BorderRadius.only(
                                                //               bottomLeft:
                                                //                   Radius.circular(
                                                //                       15),
                                                //               bottomRight:
                                                //                   Radius.circular(
                                                //                       0),
                                                //               topLeft:
                                                //                   Radius.circular(
                                                //                       15),
                                                //               topRight:
                                                //                   Radius.circular(
                                                //                       0),
                                                //             ),
                                                //             child: Image.network(
                                                //               getJsonField(
                                                //                   tracksItem,
                                                //                   r'''$.art'''),
                                                //               width: 80,
                                                //               height: 80,
                                                //               fit: BoxFit.cover,
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         Container(
                                                //           width: MediaQuery.of(
                                                //                       context)
                                                //                   .size
                                                //                   .width *
                                                //               0.75,
                                                //           height: MediaQuery.of(
                                                //                       context)
                                                //                   .size
                                                //                   .height *
                                                //               1,
                                                //           child: Padding(
                                                //             padding: const
                                                //             EdgeInsets.fromLTRB(15, 15, 5, 5),
                                                //             child: Text
                                                //               ('${getJsonField
                                                //               (tracksItem, r'''$
                                                //               .title''').toString
                                                //               ()}',style:
                                                //             TextStyle(color:
                                                //             Colors.white,
                                                //                 fontSize: 18),),
                                                //           ),
                                                //           //     FlutterFlowAudioPlayer(
                                                //           //   audio: Audio.network(
                                                //           //     'https://afrojam.com.au/${getJsonField(tracksItem, r'''$.track_file''').toString()}',
                                                //           //     metas: Metas(
                                                //           //       id: '3e8aa4a107ef3c0500642ec78ef4f521.mp3-ak6ey272',
                                                //           //       title:
                                                //           //           '${getJsonField(tracksItem, r'''$.title''').toString()}',
                                                //           //     ),
                                                //           //   ),
                                                //           //   titleTextStyle:
                                                //           //       FlutterFlowTheme
                                                //           //           .bodyText1
                                                //           //           .override(
                                                //           //     fontFamily:
                                                //           //         'Poppins',
                                                //           //     fontSize: 10,
                                                //           //     fontWeight:
                                                //           //         FontWeight.w500,
                                                //           //   ),
                                                //           //   playbackDurationTextStyle:
                                                //           //       FlutterFlowTheme
                                                //           //           .bodyText1
                                                //           //           .override(
                                                //           //     fontFamily:
                                                //           //         'Poppins',
                                                //           //     color: Color(
                                                //           //         0xFF9D9D9D),
                                                //           //     fontSize: 10,
                                                //           //   ),
                                                //           //   fillColor:
                                                //           //       Colors.white,
                                                //           //   playbackButtonColor:
                                                //           //       FlutterFlowTheme
                                                //           //           .primaryColor,
                                                //           //   activeTrackColor:
                                                //           //       Color(0xFF57636C),
                                                //           //   elevation: 0,
                                                //           // ),
                                                //         )
                                                //       ],
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                            );
                                          },
                                        );
                                      }else{
                                        return Image.asset
                                          ('assets/images/loading.gif',
                                          height: 40,);
                                      }


                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FutureBuilder<dynamic>(
                              future: notificationsCall(
                                userid:
                                    getJsonField(widget.userData, r'''$.id''')
                                        .toString(),
                                key: getJsonField(widget.userData, r'''$.key''')
                                    .toString(),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Image.asset
                                    ('assets/images/loading.gif',
                                    height: 40,);
                                }
                                final listViewNotificationsResponse =
                                    snapshot.data;
                                return Builder(
                                  builder: (context) {
                                    final notification = getJsonField(
                                                listViewNotificationsResponse,
                                                r'''$''')
                                            ?.toList() ??
                                        [];
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notification.length,
                                      itemBuilder:
                                          (context, notificationIndex) {
                                        final notificationItem =
                                            notification[notificationIndex];
                                        return InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SongPageWidget(
                                                  id: getJsonField(
                                                          notificationItem,
                                                          r'''$.track.id''')
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8, 8, 8, 8),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          getJsonField(
                                                              notificationItem,
                                                              r'''$.avatar'''),
                                                          width: 74,
                                                          height: 74,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 1, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.75,
                                                              height: 50,
                                                              child: Text(
                                                                getJsonField(
                                                                        notificationItem,
                                                                        r'''$.full_title''')
                                                                    .toString(),
                                                                style:
                                                                TextStyle
                                                                  (color:
                                                                Colors.white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              getJsonField(
                                                                      notificationItem,
                                                                      r'''$.date_created''')
                                                                  .toString(),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Lexend Deca',
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: FutureBuilder<dynamic>(
                                      future: getMessagesCall(
                                        userid: getJsonField(
                                                widget.userData, r'''$.id''')
                                            .toString(),
                                        key: getJsonField(
                                                widget.userData, r'''$.key''')
                                            .toString(),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Image.asset
                                            ('assets/images/loading.gif',
                                            height: 40,);
                                        }
                                        final listViewGetMessagesResponse =
                                            snapshot.data;
                                        return Builder(
                                          builder: (context) {
                                            final message = getJsonField(
                                                        listViewGetMessagesResponse,
                                                        r'''$''')
                                                    ?.toList() ??
                                                [];
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.vertical,
                                              itemCount: message.length,
                                              itemBuilder:
                                                  (context, messageIndex) {
                                                final messageItem =
                                                    message[messageIndex];
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChatPageWidget(
                                                              chatID: getJsonField(
                                                                      messageItem,
                                                                      r'''$.id''')
                                                                  .toString(),
                                                              userData: widget
                                                                  .userData,
                                                              personID: getJsonField(
                                                                      messageItem,
                                                                      r'''$.user1''')
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          border: Border.all(
                                                            color: Colors.black,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8,
                                                                          0,
                                                                          8,
                                                                          0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    width: 60,
                                                                    height: 60,
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child: Image
                                                                        .network(
                                                                      getJsonField(
                                                                          messageItem,
                                                                          r'''$.user.avatar'''),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        getJsonField(messageItem,
                                                                                r'''$.user.full_name''')
                                                                            .toString(),
                                                                        style: FlutterFlowTheme
                                                                            .subtitle1
                                                                            .override(
                                                                          fontFamily:
                                                                              'Lexend Deca',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.7,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            getJsonField(messageItem, r'''$.date''').toString(),
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white70,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              4,
                                                                              4,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            getJsonField(messageItem, r'''$.lastMessage.message''').toString(),
                                                                            style:
                                                                                FlutterFlowTheme.bodyText2.override(
                                                                              fontFamily: 'Lexend Deca',
                                                                              color: Colors.white70,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 0, 10),
                                      child: Text(
                                        'Suggested Videos',
                                        style:
                                            FlutterFlowTheme.subtitle1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: FutureBuilder<dynamic>(
                                        future: suggestedVideoCall(
                                          id: getJsonField(
                                                  widget.userData, r'''$.id''')
                                              .toString(),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Image.asset
                                              ('assets/images/loading.gif',
                                              height: 40,);
                                          }
                                          final listViewSuggestedVideoResponse =
                                              snapshot.data;
                                          return Builder(
                                            builder: (context) {
                                              final sugVid = (getJsonField(
                                                              listViewSuggestedVideoResponse,
                                                              r'''$''')
                                                          ?.toList() ??
                                                      [])
                                                  .take(5)
                                                  .toList();
                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: sugVid.length,
                                                itemBuilder:
                                                    (context, sugVidIndex) {
                                                  final sugVidItem =
                                                      sugVid[sugVidIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 10, 40),
                                                    child:
                                                        FlutterFlowVideoPlayer(
                                                      path:
                                                          'https://afrojam.com.au/${getJsonField(sugVidItem, r'''$.upload_file''').toString()}',
                                                      videoType:
                                                          VideoType.network,
                                                      autoPlay: false,
                                                      looping: true,
                                                      showControls: true,
                                                      allowFullScreen: true,
                                                      allowPlaybackSpeedMenu:
                                                          false,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 10),
                                        child: Text(
                                          'Watch Videos',
                                          style: FlutterFlowTheme.subtitle1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: FutureBuilder<dynamic>(
                                          future: getVideoListCall(),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Image.asset
                                                ('assets/images/loading.gif',
                                                height: 40,);
                                            }
                                            final listViewGetVideoListResponse =
                                                snapshot.data;
                                            return Builder(
                                              builder: (context) {
                                                final videos = getJsonField(
                                                            listViewGetVideoListResponse,
                                                            r'''$''')
                                                        ?.toList() ??
                                                    [];
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: videos.length,
                                                  itemBuilder:
                                                      (context, videosIndex) {
                                                    final videosItem =
                                                        videos[videosIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 5, 5, 5),
                                                      child:
                                                          FlutterFlowVideoPlayer(
                                                        path:
                                                            'https://afrojam.com.au/${getJsonField(videosItem, r'''$.upload_file''').toString()}',
                                                        videoType:
                                                            VideoType.network,
                                                        autoPlay: false,
                                                        looping: true,
                                                        showControls: true,
                                                        allowFullScreen: true,
                                                        allowPlaybackSpeedMenu:
                                                            false,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  _startMeeting() async {

    _meetingId = (rng.nextInt(80000000) + 10000000).toString();

    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
    };
    if (Platform.isAndroid) {
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    } else if (Platform.isIOS) {
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }

    var options = JitsiMeetingOptions(room: _meetingId)
      ..subject = 'Meeting ID: $_meetingId'
      ..userDisplayName =  getJsonField(widget.userData, r'''$.full_name''').toString()
      ..iosAppBarRGBAColor = '#ff8c00'
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": _meetingId,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": 'Meeting ID: $_meetingId'}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  _joinMeeting(String meetingID) async {


    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
    };
    if (Platform.isAndroid) {
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    } else if (Platform.isIOS) {
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }

    var options = JitsiMeetingOptions(room: _meetingId)
      ..userDisplayName =  getJsonField(widget.userData, r'''$.full_name''').toString()
      ..iosAppBarRGBAColor = '#ff8c00'
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": ''}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }


}

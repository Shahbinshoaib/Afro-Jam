import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectPlaylistWidget extends StatefulWidget {
  SelectPlaylistWidget({
    Key key,
    this.userData,
    this.trackid,
  }) : super(key: key);

  final dynamic userData;
  final String trackid;

  @override
  _SelectPlaylistWidgetState createState() => _SelectPlaylistWidgetState();
}

class _SelectPlaylistWidgetState extends State<SelectPlaylistWidget> {
  dynamic addToPlaylistResult;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: myPlaylistCall(
        userid: getJsonField(widget.userData, r'''$.id''').toString(),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Color(0xFFFF4700),
              ),
            ),
          );
        }
        final listViewMyPlaylistResponse = snapshot.data;
        return Builder(
          builder: (context) {
            final playlist =
                getJsonField(listViewMyPlaylistResponse, r'''$''')?.toList() ??
                    [];
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: playlist.length,
              itemBuilder: (context, playlistIndex) {
                final playlistItem = playlist[playlistIndex];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      addToPlaylistResult = await addToPlaylistCall(
                        trackid: widget.trackid,
                        key: getJsonField(widget.userData, r'''$.key''')
                            .toString(),
                        userid: getJsonField(widget.userData, r'''$.id''')
                            .toString(),
                        playlistid:
                            getJsonField(playlistItem, r'''$.id''').toString(),
                      );
                      if (getJsonField(addToPlaylistResult, r'''$.status''')) {
                        Navigator.pop(context);
                      }

                      setState(() {});
                    },
                    child: ListTile(
                      title: Text(
                        getJsonField(playlistItem, r'''$.name''').toString(),
                        style: FlutterFlowTheme.title3,
                      ),
                      subtitle: Text(
                        '${getJsonField(playlistItem, r'''$.total_tracks''').toString()} Tracks',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

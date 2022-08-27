import 'api_manager.dart';

Future<dynamic> authLoginCall({
  String username = '',
  String password = '',
}) {
  final body = '''
{
  "username": "${username}",
  "password": "${password}"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'AuthLogin',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/login&username=$username&password=$password',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> authSignupCall({
  String username = '',
  String fullName = '',
  String email = '',
  String password = '',
}) {
  final body = '''
{
  "username": "${username}",
  "full_name": "${fullName}",
  "email": "${email}",
  "password": "${password}"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'AuthSignup',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/signup&username=$username&full_name=$fullName&email=$email&password=$password',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> getTracksCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'GetTracks',
    apiUrl: 'https://afrojam.com.au/?p=api/api-key/load/tracks&offset=0',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getTrackDetailsCall({
  String id = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'GetTrackDetails',
    apiUrl: 'https://afrojam.com.au/?p=api/api-key/track/details&id=$id',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getCommentsCall({
  String offset = '0',
  String limit = '0',
  String type = 'track',
  String typeId = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'GetComments',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/load/comments&offset=$offset&limit=$limit&type=$type&type_id=$typeId',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> downloadTrackCall({
  String id = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'downloadTrack',
    apiUrl: 'https://afrojam.com.au/?p=api/api-key/get/download/detail&id=$id',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> notificationsCall({
  String userid = '',
  String key = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Notifications',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/notifications&key=$key&userid=$userid&offset=0&limit=30',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getMessagesCall({
  String userid = '',
  String key = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'GetMessages',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/message/lists&key=$key&userid=$userid',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getChatCall({
  String cid = '',
  String key = '',
  String userid = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'GetChat',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/chats&cid=$cid&offset=0&limit=50&key=$key&userid=$userid',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> sendMessageCall({
  String toID = '',
  String text = '',
  String key = '',
  String userid = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'SendMessage',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/chat/send&to=$toID&text=$text&key=$key&userid=$userid',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getFollowersCall({
  String theuserid = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'GetFollowers',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/people/list&type=followers&offset=0&limit=10&theuserid=$theuserid',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getVideoListCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'GetVideoList',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/video/list&limit=20&offset=0',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> suggestedVideoCall({
  String id = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'SuggestedVideo',
    apiUrl: 'https://afrojam.com.au/?p=api/api-key/suggest/videos&id=$id',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> likeAPICall({
  String key = '',
  String userid = '',
  String type = '',
  String typeId = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'LikeAPI',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/like/item&key=$key&userid=$userid&type=$type&type_id=$typeId',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> searchPlaylistCall({
  String text = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'SearchPlaylist',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/list/playlist&type=playlist&type_id=search-$text&limit=20&offset=0',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> myPlaylistCall({
  String userid = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'MyPlaylist',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/list/playlist&type=playlist&type_id=profile-$userid&limit=20&offset=0',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> addCommentCall({
  String key = '',
  String userid = '',
  String trackId = '',
  String message = '',
}) {
  final body = '''
{
  "key": "${key}",
  "userid": "${userid}",
  "type_id": "${trackId}",
  "message": "${message}"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'AddComment',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/add/comment&key=$key&userid=$userid&type=track&type_id=$trackId&message=$message',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> deleteCommentCall({
  String key = '',
  String userid = '',
  String commentid = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'DeleteComment',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/remove/comment&key=$key&userid=$userid&id=$commentid',
    callType: ApiCallType.DELETE,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> addToPlaylistCall({
  String trackid = '',
  String playlistid = '',
  String key = '',
  String userid = '',
}) {
  final body = '''
{
  "track": "${trackid}",
  "playlist": "${playlistid}",
  "key": "${key}",
  "userid": "${userid}"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'AddToPlaylist',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/add/to/playlist&track=$trackid&playlist=$playlistid&key=$key&userid=$userid',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

Future<dynamic> createPlaylistCall({
  String name = '',
  String desc = '',
  String userid = '',
  String key = '',
}) {
  final body = '''
{
  "name": "${name}",
  "desc": "${desc}",
  "userid": "${userid}",
  "key": "${key}"
}''';
  return ApiManager.instance.makeApiCall(
    callName: 'CreatePlaylist',
    apiUrl:
        'https://afrojam.com.au/?p=api/api-key/add/playlist&name=$name&desc=$desc&userid=$userid&key=$key',
    callType: ApiCallType.POST,
    headers: {},
    params: {},
    body: body,
    bodyType: BodyType.JSON,
    returnResponse: true,
  );
}

class MeetingRoomResponse {
  bool? success;
  String? message;
  MeetingRoomData? data;
  dynamic errors;
  dynamic meta;

  MeetingRoomResponse({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.meta,
  });

  MeetingRoomResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? MeetingRoomData.fromJson(json['data']) : null;
    errors = json['errors'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['errors'] = errors;
    data['meta'] = meta;
    return data;
  }
}

class MeetingRoomData {
  AgoraSettings? agora;
  String? sessionStatus;

  MeetingRoomData({this.agora, this.sessionStatus});

  MeetingRoomData.fromJson(Map<String, dynamic> json) {
    agora = json['agora'] != null
        ? AgoraSettings.fromJson(json['agora'])
        : null;
    sessionStatus = json['session_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (agora != null) {
      data['agora'] = agora!.toJson();
    }
    data['session_status'] = sessionStatus;
    return data;
  }
}

class AgoraSettings {
  String? channel;
  String? token;
  String? uid;
  String? role;
  int? expiresIn;

  AgoraSettings({
    this.channel,
    this.token,
    this.uid,
    this.role,
    this.expiresIn,
  });

  AgoraSettings.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    token = json['token'];
    uid = json['uid'];
    role = json['role'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['token'] = token;
    data['uid'] = uid;
    data['role'] = role;
    data['expires_in'] = expiresIn;
    return data;
  }
}

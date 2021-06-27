class Message {
  static const String TYPE_USER = "user";
  static const String TYPE_SYSTEM = "system";
  static const String TYPE_ME = "me";

  final String from;
  final String msg;
  final String meme;

  Message(this.from, this.msg, this.meme);

  Message.fromJson(Map<String, dynamic> json)
    : from = json['type'],
      msg = json['msg'],
      meme = json['meme'];

  Map<String, dynamic> toJson() => <String, dynamic> {
    'type': from,
    'msg': msg,
    'meme': meme
  };
}
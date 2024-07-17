class MessageModel {
  String? dateTime;
  String? reciverId;
  String? senderId;
  String? text;
  MessageModel(this.dateTime, this.reciverId, this.senderId, this.text);

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    reciverId = json['reciverId'];
    senderId = json['senderId'];
    text = json['text'];
  }
  Map<String, dynamic> ToMap() {
    return {
      'dateTime': dateTime,
      'reciverId': reciverId,
      'senderId': senderId,
      'text': text,
    };
  }
}

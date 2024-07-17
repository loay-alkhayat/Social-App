class PostModel {
  String? firstname;
  String? lastname;
  String? uId;
  String? image;
  String? text;
  String? postImage;
  String? dateTime;

  PostModel({
    this.firstname,
    this.lastname,
    this.uId,
    this.image,
    this.text,
    this.postImage,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> ToMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'uId': uId,
      'image': image,
      'text': text,
      'postImage': postImage,
      'dateTime': dateTime,
    };
  }
}

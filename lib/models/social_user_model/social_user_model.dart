class SocialUserModel {
  String? firstname;
  String? lastname;
  String? email;
  String? uId;
  String? image;
  String? bio;
  String? cover;

  SocialUserModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.uId,
      this.image,
      this.bio,
      this.cover});
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }
  Map<String, dynamic> ToMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
    };
  }
}

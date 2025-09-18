class ProfileRequest {
  String? name;
  String? birthday;
  int? height;
  int? weight;
  List<String>? interests;

  ProfileRequest({
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "birthday": birthday,
      "height": height,
      "weight": weight,
      "interests": interests,
    };
  }
}


class ProfileResponse {
  String? message;
  ProfileData? data;

  ProfileResponse({this.message, this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data']),
    );
  }
}

class ProfileData {
   String? email;
   String? username;
   String? name;
   String? birthday;
   String? horoscope;
   String? zodiac;
   String? gender;
   int? height;
   int? weight;
   List<String>? interests;
   

  ProfileData({
    this.email,
    this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.gender,
    this.height,
    this.weight,
    this.interests,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      email: json['email'],
      username: json['username'],
      name: json['name'],
      birthday: json['birthday'],
      horoscope: json['horoscope'],
      zodiac: json['zodiac'],
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      interests: List<String>.from(json['interests'] ?? []),
    );
  }
}


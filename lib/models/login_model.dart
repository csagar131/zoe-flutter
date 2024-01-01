class LoginApiResponse {
  String message;
  UserData data;

  LoginApiResponse({
    required this.message,
    required this.data,
  });

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) {
    return LoginApiResponse(
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  User user;
  Profile profile;
  String token;

  UserData({
    required this.user,
    required this.profile,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user'] ?? {}),
      profile: Profile.fromJson(json['profile']),
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'profile': profile.toJson(),
      'token': token,
    };
  }
}

class User {
  String phone;
  DateTime lastLogin;

  User({
    required this.phone,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phone: json['phone'] ?? '',
      lastLogin: DateTime.parse(json['last_login'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'last_login': lastLogin.toIso8601String(),
    };
  }
}

class Profile {
  String uuid;
  String firstName;
  String lastName;
  String email;
  String dob;
  int age;
  String gender;
  dynamic minRadius;
  dynamic maxRadius;
  dynamic currentCity;
  dynamic country;
  dynamic countryCode;
  dynamic latitude;
  dynamic longitude;
  bool isPhoneVerified;
  bool isEmailVerified;
  String createdAt;
  String updatedAt;

  Profile({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.age,
    required this.gender,
    required this.minRadius,
    required this.maxRadius,
    required this.currentCity,
    required this.country,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.isPhoneVerified,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      uuid: json['uuid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      dob: json['dob'],
      age: json['age'],
      gender: json['gender'],
      minRadius: json['min_radius'],
      maxRadius: json['max_radius'],
      currentCity: json['current_city'],
      country: json['country'],
      countryCode: json['country_code'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isPhoneVerified: json['is_phone_verified'],
      isEmailVerified: json['is_email_verified'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'dob': dob,
      'age': age,
      'gender': gender,
      'min_radius': minRadius,
      'max_radius': maxRadius,
      'current_city': currentCity,
      'country': country,
      'country_code': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'is_phone_verified': isPhoneVerified,
      'is_email_verified': isEmailVerified,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

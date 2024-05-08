class UserResponse {
  final String? message;
  final int? status;
  final UserData? user;

  UserResponse({
    this.message,
    this.status,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      user: UserData.fromJson(json['metadata']['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'metadata': {
        'user': user?.toJson(),
      },
    };
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String role;
  final String address;
  final String avatar;
  final String dateOfBirth;
  final String gender;
  final String mobile;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.address,
    required this.dateOfBirth,
    required this.avatar,
    required this.gender,
    required this.mobile,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      address: json['address'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? "20/09/2003",
      avatar: json['avatar'],
      gender: json['gender'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'address': address,
      'avatar' : avatar,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'mobile': mobile,
    };
  }
}
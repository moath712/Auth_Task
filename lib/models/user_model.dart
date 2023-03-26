class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String about;
  String phoneNumber;
  int yearsOfExperience;
  int freeChemistrySessions;
  String occupation;
  String location;
  int idNumber;
  String gender;
  int scfhsId;
  String institute;
  List<UserRole> userRoles;
  List<BelongsToClientOrganization> belongsToClientOrganizations;
  List<dynamic> belongsToServiceProviders;
  dynamic profileImage;
  int clientOrganizationId;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.phoneNumber,
    required this.yearsOfExperience,
    required this.freeChemistrySessions,
    required this.occupation,
    required this.location,
    required this.idNumber,
    required this.gender,
    required this.scfhsId,
    required this.institute,
    required this.userRoles,
    required this.belongsToClientOrganizations,
    required this.belongsToServiceProviders,
    required this.profileImage,
    required this.clientOrganizationId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      about: json['about'],
      phoneNumber: json['phoneNumber'],
      yearsOfExperience: json['yearsOfExperience'],
      freeChemistrySessions: json['freeChemistrySessions'],
      occupation: json['occupation'],
      location: json['location'],
      idNumber: json['idNumber'],
      gender: json['gender'],
      scfhsId: json['scfhsId'],
      institute: json['institute'],
      userRoles: List<UserRole>.from(
          json['userRoles'].map((role) => UserRole.fromJson(role))),
      belongsToClientOrganizations: List<BelongsToClientOrganization>.from(
        json['belongsToClientOrganizations'].map(
            (clientOrg) => BelongsToClientOrganization.fromJson(clientOrg)),
      ),
      belongsToServiceProviders: json['belongsToServiceProviders'],
      profileImage: json['profileImage'],
      clientOrganizationId: json['clientOrganizationId'],
    );
  }
}

class UserRole {
  int id;
  String role;

  UserRole({
    required this.id,
    required this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'],
      role: json['role'],
    );
  }
}

class BelongsToClientOrganization {
  int role;
  int clientOrganizationId;
  ClientOrganization clientOrganization;

  BelongsToClientOrganization({
    required this.role,
    required this.clientOrganizationId,
    required this.clientOrganization,
  });

  factory BelongsToClientOrganization.fromJson(Map<String, dynamic> json) {
    return BelongsToClientOrganization(
      role: json['role'],
      clientOrganizationId: json['clientOrganizationId'],
      clientOrganization:
          ClientOrganization.fromJson(json['clientOrganization']),
    );
  }
}

class ClientOrganization {
  int id;
  String name;

  ClientOrganization({
    required this.id,
    required this.name,
  });

  factory ClientOrganization.fromJson(Map<String, dynamic> json) {
    return ClientOrganization(
      id: json['id'],
      name: json['name'],
    );
  }
}

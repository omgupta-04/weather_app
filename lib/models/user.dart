class User {
  String name; 
  String email;
  String location;

  User({this.name = '', this.email = '', this.location = ''});

  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'location': location,
    };
  }

  // Create User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      location: map['location'] ?? '',
    );
  }
}


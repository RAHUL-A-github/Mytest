class UserData {
  String email;
  String mobileNumber;
  String lname;
  String name;
  String image;

  UserData({this.email, this.mobileNumber, this.lname, this.name, this.image});

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobileNumber = json['Mobile'];
    lname = json['lname'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['Mobile'] = this.mobileNumber;
    data['lname'] = this.lname;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
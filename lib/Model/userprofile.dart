class userprofile {
  String Email, Name, aboutus, uid, Photo, occupation, phone;

  userprofile(
      {this.Email,
      this.Name,
      this.aboutus,
      this.uid,
      this.Photo,
      this.occupation,
      this.phone});

  factory userprofile.fromDocument(doc) {
    return userprofile(
        Email: doc['Email'],
        Name: doc['Name'],
        aboutus: doc['aboutus'],
        uid: doc['uid'],
        Photo: doc['Photo'],
        occupation: doc['occupation'],
        phone: doc['phone']);
  }
}

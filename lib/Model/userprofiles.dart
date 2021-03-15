class userprofiles {
  String Email, Name, aboutus, uid, Photo, occupation, phone;
  var Date;

  userprofiles(
      {this.Email,
      this.Name,
      this.aboutus,
      this.uid,
      this.Photo,
      this.occupation,
      this.phone,
      this.Date});

  factory userprofiles.fromDocument(doc) {
    return userprofiles(
        Email: doc['Email'],
        Name: doc['Name'],
        aboutus: doc['aboutus'],
        uid: doc['uid'],
        Photo: doc['Photo'],
        occupation: doc['occupation'],
        phone: doc['phone'],
        Date: doc['Date']);
  }
}

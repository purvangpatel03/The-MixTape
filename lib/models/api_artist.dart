class Artist {
  int? id;
  String? name;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? type;

  Artist(
      {this.id,
        this.name,
        this.picture,
        this.pictureSmall,
        this.pictureMedium,
        this.pictureBig,
        this.pictureXl,
        this.type});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
    pictureSmall = json['picture_small'];
    pictureMedium = json['picture_medium'];
    pictureBig = json['picture_big'];
    pictureXl = json['picture_xl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['picture'] = picture;
    data['picture_small'] = pictureSmall;
    data['picture_medium'] = pictureMedium;
    data['picture_big'] = pictureBig;
    data['picture_xl'] = pictureXl;
    data['type'] = type;
    return data;
  }
}
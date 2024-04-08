import 'api_album.dart';
import 'api_artist.dart';

class Data {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  int? duration;
  int? rank;
  String? preview;
  String? md5Image;
  Artist? artist;
  Album? album;
  String? type;

  Data(
      {this.id,
        this.readable,
        this.title,
        this.titleShort,
        this.duration,
        this.rank,
        this.preview,
        this.md5Image,
        this.artist,
        this.album,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readable = json['readable'];
    title = json['title'];
    titleShort = json['title_short'];
    duration = json['duration'];
    rank = json['rank'];
    preview = json['preview'];
    md5Image = json['md5_image'];
    artist =
    json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['readable'] = readable;
    data['title'] = title;
    data['title_short'] = titleShort;
    data['duration'] = duration;
    data['rank'] = rank;
    data['preview'] = preview;
    data['md5_image'] = md5Image;
    if (artist != null) {
      data['artist'] = artist!.toJson();
    }
    if (album != null) {
      data['album'] = album!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

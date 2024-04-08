import 'package:flutter/material.dart';
import 'package:music_streaming_app/api/api_service.dart';

import '../models/api_base_response.dart';

class HomeProvider with ChangeNotifier{

  List<ApiBaseResponse> artist = [];

  getArtistData() async{
    artist.clear();
    artist.add(await ApiService().getArtistData('Dua Lipa'));
    artist.add(await ApiService().getArtistData('Eminem'));
    artist.add(await ApiService().getArtistData('Alan Walker'));
    artist.add(await ApiService().getArtistData('Arjit Singh'));
    artist.add(await ApiService().getArtistData('Ariana Grande'));
    artist.add(await ApiService().getArtistData('Taylor Swift'));
    artist.add(await ApiService().getArtistData('Justin Bieber'));
    artist.add(await ApiService().getArtistData('Rihana'));
    notifyListeners();
  }

  getOtherArtistData(String artistName) async {
    artist.clear();
    artist.add(await ApiService().getArtistData(artistName));
  }

}
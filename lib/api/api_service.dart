import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_streaming_app/api/api_parameters.dart';
import 'package:music_streaming_app/models/api_base_response.dart';

class ApiService {
  Future<ApiBaseResponse> getArtistData(String artistName) async {
    var response = await http.get(
      Uri.parse(
        'https://deezerdevs-deezer.p.rapidapi.com/search?q=$artistName',
      ),
      headers: ApiParameters.headers,
    );
    if (response.statusCode == 200) {
      return ApiBaseResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Api not Connected');
    }
  }
}

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices {
  final String baseUrl =
      'https://fls8oe8xp7.execute-api.ap-south-1.amazonaws.com/dev/nosh-assignment';

  static var client = http.Client();
  getData() async {
    Response response = await client.get(Uri.parse(baseUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

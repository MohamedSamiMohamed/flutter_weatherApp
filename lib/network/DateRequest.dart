import 'package:http/http.dart' as http;

class DateRequest {
  final String baseUrl = 'http://worldtimeapi.org/api/timezone/';
  String city;
  DateRequest({this.city});
  Future<http.Response> getDate() {
    return http.get('$baseUrl$city');
  }
}

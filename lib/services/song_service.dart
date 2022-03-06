import 'package:http/http.dart';

Future<Response> findAllSongs() async {
  return await get(
      Uri.parse('http://siao.webcifra.com.br/index.php?r=mobile/listarMusica'));
}

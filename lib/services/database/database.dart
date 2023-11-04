import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_two/services/models/repository_info_model.dart';

class DataBase {
  DataBase._internal();
  static DataBase instance = DataBase._internal();

  Future<List<RepositoryInfo>> getRepositoryList() async {
    //
    List<RepositoryInfo> repoList = [];

    var response = await http.get(Uri.parse(
      'https://api.github.com/search/repositories?q=created:>2020-04-29&sort=stars&order=desc',
    ));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      List responseList = jsonResponse['items'];

      for (var response in responseList) {
        repoList.add(RepositoryInfo.fromJson(response));
      }

      repoList.sort(((a, b) => b.stargazersCount.compareTo(a.stargazersCount)));
      return repoList;
    } else {
      Exception('No document found');
    }
    return repoList;
  }
}

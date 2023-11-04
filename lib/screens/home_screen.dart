import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:task_two/services/database/database.dart';
import 'package:task_two/services/models/repository_info_model.dart';
import 'package:task_two/utils/circular_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData themeData;

  List<RepositoryInfo> filterList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    isLoading = true;
    filterList = await DataBase.instance.getRepositoryList();

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return isLoading
        ? const CircularIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('Task 2'),
            ),
            body: SafeArea(
              child: KeyboardDismissOnTap(
                child: homeScreenUI(),
              ),
            ),
          );
  }

  Widget homeScreenUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          sizedBoxUI(
            20,
          ),
          Text(
            'GitHub Repositories',
            style: themeData.textTheme.headline6,
          ),
          sizedBoxUI(
            20,
          ),
          for (RepositoryInfo info in filterList) cardUI(info)
        ],
      ),
    );
  }

  Widget cardUI(RepositoryInfo repoInfo) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [profieImageAndNameUI(repoInfo), repoInfoUI(repoInfo)],
            ),
          ),
        ),
      ),
    );
  }

  Widget profieImageAndNameUI(RepositoryInfo repoInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 50,
            height: 50,
            child: repoInfo.owner.avatarUrl.isEmpty
                ? const Text('IM')
                : Image.network(repoInfo.owner.avatarUrl)),
        Expanded(
          flex: 1,
          child: textUI(
              repoInfo.owner.ownerName, themeData.textTheme.titleLarge,
              alignment: TextAlign.center),
        )
      ],
    );
  }

  Widget repoInfoUI(RepositoryInfo repoInfo) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBoxUI(
          8,
        ),
        Container(
          color: Colors.black,
          height: 1,
        ),
        sizedBoxUI(
          8,
        ),
        textUI(
            'Repo Info',
            themeData.textTheme.subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
            alignment: TextAlign.start),
        sizedBoxUI(
          5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textUI(repoInfo.name, themeData.textTheme.subtitle1,
                      alignment: TextAlign.left),
                  sizedBoxUI(
                    2,
                  ),
                  textUI(
                      repoInfo.description,
                      themeData.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                      alignment: TextAlign.left,
                      maxLines: 4)
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Stars',
                    style: themeData.textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    repoInfo.stargazersCount.toString(),
                    style: themeData.textTheme.subtitle1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget sizedBoxUI(double? height) {
    return SizedBox(
      height: height,
    );
  }

  Widget textUI(String text, TextStyle? style,
      {TextAlign? alignment, int? maxLines}) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_github_dev_dojo/model/repository.dart';
import 'package:flutter_app_github_dev_dojo/screen/repository_tab_screen.dart';
import 'package:flutter_app_github_dev_dojo/service/github_service.dart';
import 'package:flutter_app_github_dev_dojo/util/pagination.dart';
import 'package:flutter_app_github_dev_dojo/widgets/async_layout_constructor.dart';
import 'package:flutter_app_github_dev_dojo/widgets/text_icon.dart';

class GitHubSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => query = ""
        )
      ];
    }
    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return RepositoryList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return ListTile(
      leading: const Icon(Icons.book),
      title: Text("Repositories contains $query"),
      onTap: () => showResults(context),
    );
  }

  @override
  String get searchFieldLabel => "Search";
}

class RepositoryList extends StatefulWidget {

  final String query;

  const RepositoryList({Key key, @required this.query}) : super(key: key);

  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {

  final List<Widget> cache = [];
  Future<List<Widget>> future;
  final MAX_GITHUB_RESULT = 1000;
  int page = 1;


  @override
  void initState() {
    future = findAllRepositoryByName();
    super.initState();
  }

  Future <List<Widget>> findAllRepositoryByName() async {
    final pagination = await GithubService.findAllRepositoryByName(
        widget.query, page);
    if (cache.isEmpty) {
      cache.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: const Text("Found repositories")),
                Text("${pagination.total}")
              ],
            ),
          )
      );
    }

    if (cache.last is LoadingList) {
      cache.removeLast();
    }
    cache.addAll(pagination.items.map((it) => RepositoryView(repository: it)));
    if (hasMore(pagination)) {
      cache.add(LoadingList());
    }
    page++;
    return cache;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncLayoutConstructor<List<Widget>>(
      future: future,
      hasDataWidget: (data) {
        return ListView.separated(
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          itemBuilder: (context, index) {
            if (data[index] is LoadingList) {
              future =
                  findAllRepositoryByName().whenComplete(() => setState(() {}));
            }
            return data[index];
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        );
      },
      hasErrorWidget: (err) => Center(child: Text("Error occurred")),
      loadingWidget: () => Center(child: CircularProgressIndicator()),
      hasDataEmptyWidget: () => Container(),
    );
  }

  bool hasMore(Pagination<Repository> pagination) {
    int total = cache
        .where((it) => it is RepositoryView)
        .length;
    if (total < pagination.total && total < MAX_GITHUB_RESULT) {
      return true;
    }

    return false;
  }
}

class RepositoryView extends StatelessWidget {

  final Repository repository;

  const RepositoryView({Key key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context){
            return RepositoryTabScreen(repository: repository);
          })
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.network(
                    repository.owner.avatarUrl, width: 32, height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(repository.owner.login ?? "Name not informed"),
                )
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 5),
            title: Text(repository.name),
            subtitle: Text(repository?.description ?? "No description"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(repository?.language ?? "Undefined"),
                ),
                TextIcon(
                  title: "${repository.stars}",
                  icon: const Icon(Icons.stars, color: Colors.yellow),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/routes/utils.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefrences = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
                onTap: () {
                  userPrefrences.removerUser().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: const Text('LogOut')),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
            builder: (context, value, _) {
              switch (value.moviesList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());

                case Status.ERROR:
                  return Center(
                      child: Text(value.moviesList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.moviesList.data!.movies.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              value.moviesList.data!.movies[index].posterurl
                                  .toString(),
                              errorBuilder: (context, error, stack) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                            ),
                            title: Text(
                                value.moviesList.data!.movies[index].title),
                            subtitle:
                                Text(value.moviesList.data!.movies[index].year),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(Utils.averageRating(value
                                        .moviesList.data!.movies[index].ratings)
                                    .toStringAsFixed(1)),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                default:
              }
              return Container();
            },
          )),
    );
  }
}

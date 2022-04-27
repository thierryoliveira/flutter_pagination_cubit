import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_cubit_pagination/features/posts/cubit/posts_cubit.dart';
import 'package:flutter_cubit_pagination/features/posts/data/datasources/posts_datasource.dart';
import 'package:flutter_cubit_pagination/features/posts/data/repositories/posts_repository.dart';
import 'package:flutter_cubit_pagination/features/posts/presentation/posts_screen.dart';

void main() {
  runApp(PaginationApp(
    repository: PostsRepository(datasource: PostsDatasource()),
  ));
}

class PaginationApp extends StatelessWidget {
  const PaginationApp({
    Key? key,
    required this.repository,
  }) : super(key: key);

  final PostsRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<PostsCubit>(
        create: (context) => PostsCubit(repository),
        child: PostsScreen(),
      ),
    );
  }
}

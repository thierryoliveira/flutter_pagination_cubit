import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_pagination/features/posts/cubit/posts_cubit.dart';
import 'package:flutter_cubit_pagination/features/posts/data/models/post_model.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(body: _postList());
  }

  Widget _postList() {
    bool isLoading = false;
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading && state.isFirstFetch) {
          return _loadingIndicator();
        }

        List<PostModel> posts = <PostModel>[];
        if (state is PostsLoading) {
          isLoading = true;
          posts = state.oldPosts;
        } else if (state is PostsLoaded) {
          posts = state.posts;
        }
        return ListView.separated(
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index < posts.length) {
                return _post(posts[index], context);
              } else {
                Timer(const Duration(milliseconds: 30), () {
                  scrollController.jumpTo(
                    scrollController.position.maxScrollExtent,
                  );
                });

                return _loadingIndicator();
              }
            },
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey[400]),
            itemCount: posts.length + (isLoading ? 1 : 0));
      },
    );
  }

  Widget _loadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _post(PostModel post, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${post.id}. ${post.title}",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Text(post.body ?? '')
        ],
      ),
    );
  }
}

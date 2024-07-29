import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/application/auth/auth_bloc.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/presentation/pages/home/widgets/home_app_bar.dart';
import 'package:mpd_client/presentation/pages/lenta/view/lenta_view.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    context.read<PostBloc>().add(const PostFetched());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldSecondaryBackground,
      appBar: HomeAppbarComponent(),
      body: LentaView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_home_app/blocs/auth/auth_bloc.dart';
import 'package:pet_home_app/screens/create_pet/create_pet_screen.dart';
import 'package:pet_home_app/screens/home/bloc/home_bloc.dart';
import 'package:pet_home_app/screens/home/widgets/pets_list_item.dart';
import 'package:pet_home_app/widgets/refresh_indicator_wrapper.dart';

import 'bottom_loader.dart';

class PetsList extends StatefulWidget {
  const PetsList({Key? key}) : super(key: key);

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(HomeListScrolledEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<dynamic> _onRefresh(state) {
    context.read<HomeBloc>().add(HomeListRefreshedEvent());
    return Future.doWhile(() => state.status == HomeFetchingStatus.initial);
  }

  Widget _buildLoadingStatus(context, state) {
    return RefreshIndicatorWrapper(
      onRefresh: () => _onRefresh(state),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyListStatus(context, state) {
    return RefreshIndicatorWrapper(
      onRefresh: () => _onRefresh(state),
      child: const Center(
        child: Text('No pets were found in your region!'),
      ),
    );
  }

  Widget _buildFailureStatus(context, state) {
    return RefreshIndicatorWrapper(
      onRefresh: () => _onRefresh(state),
      child: const Center(
        child: Text('Failed to get pets.'),
      ),
    );
  }

  Widget _buildSuccessStatus(context, state) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(state),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return index >= state.pets.length
              ? const BottomLoader()
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    PetsListItem(
                      pet: state.pets[index],
                    ),
                    Builder(
                      builder: (context) {
                        if (state.hasReachedMax &&
                            index == state.pets.length - 1) {
                          return const SizedBox(
                            height: 30,
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                );
        },
        itemCount:
            state.hasReachedMax ? state.pets.length : state.pets.length + 1,
        controller: _scrollController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeFetchingStatus.initial:
            return _buildLoadingStatus(context, state);
          case HomeFetchingStatus.failure:
            return _buildFailureStatus(context, state);
          case HomeFetchingStatus.success:
            if (state.pets.isEmpty) {
              return _buildEmptyListStatus(context, state);
            } else {
              return _buildSuccessStatus(context, state);
            }
        }
      },
    );
  }
}

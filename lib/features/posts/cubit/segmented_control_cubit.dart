import 'package:bloc/bloc.dart';
import 'posts_cubit.dart';
import '../data/repositories/posts_repository.dart';

part 'segmented_control_state.dart';

class SegmentedControlCubit extends Cubit<SegmentedControlState> {
  final PostsRepository repository;
  final PostsCubit postsCubit;

  SegmentedControlCubit(
    this.repository,
    this.postsCubit,
  ) : super(
          SegmentedControlInitial(),
        );

  void reset() {
    emit(SegmentedControlReset());
  }

  void setToAll() {
    postsCubit.showAll();
    emit(SegmentedControlSetAllSuccess());
  }

  void setToFavorites() {
    postsCubit.showFavorites();
    emit(SegmentedControlSetFavoritesSuccess());
  }
}

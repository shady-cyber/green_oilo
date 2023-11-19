import '../../screens/data/generalCubit/general_cubit.dart';
import '../../screens/data/generalCubit/general_state.dart';

class NavigationArguments {
  final GeneralOrderData data;
  final GeneralCubit cubit;

  NavigationArguments({required this.data, required this.cubit});
}
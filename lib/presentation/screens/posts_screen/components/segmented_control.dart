import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/segmented_control_cubit.dart';

class SegmentedControl extends StatefulWidget {
  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  int? currentValue = 0;

  final Map<int, Widget> filterMenu = const <int, Widget>{
    0: Text('All'),
    1: Text('Favorites'),
  };

  void _changePosition(int value) {
    setState(() {
      currentValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SegmentedControlCubit, SegmentedControlState>(
      builder: (context, state) {
        if (state is SegmentedControlReset) {
          return buildSegmentedControl(context, 0);
        }
        return buildSegmentedControl(context, currentValue);
      },
    );
  }

  CupertinoSlidingSegmentedControl<int> buildSegmentedControl(
      BuildContext context, int? index) {
    return CupertinoSlidingSegmentedControl(
      thumbColor: Colors.green,
      children: filterMenu,
      onValueChanged: (int? value) {
        _changePosition(value!);
        if (currentValue == 0) {
          BlocProvider.of<SegmentedControlCubit>(context).setToAll();
        } else if (currentValue == 1) {
          BlocProvider.of<SegmentedControlCubit>(context).setToFavorites();
        }
      },
      groupValue: index,
    );
  }
}

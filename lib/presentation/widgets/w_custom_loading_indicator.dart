import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key});

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> {
  int _firstLoadingIndicator = 0;

  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (Timer t) {
      setState(() {
        _firstLoadingIndicator++;
        if (_firstLoadingIndicator == LoadingIndicator.indicatorPosition.length) {
          _firstLoadingIndicator = 0;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      color: Colors.white,
      child: Stack(
        children: List.generate(
          8,
          (index) => Positioned(
              right: LoadingIndicator.indicatorPosition[index].right,
              top: LoadingIndicator.indicatorPosition[index].top,
              left: LoadingIndicator.indicatorPosition[index].left,
              bottom: LoadingIndicator.indicatorPosition[index].bottom,
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: _firstLoadingIndicator == index ? gradientColors(context)[1] : gradientColors(context)[0])),
              )),
        ),
      ),
    );
  }
}

List<List<Color>> gradientColors(BuildContext context) => [
      [
        const Color(0xFFD9D9D9),
        const Color(0xFFD9D9D9),
      ],
      [
        gradientBlueOpacity,
        gradientBlue,
      ]
    ];

class LoadingIndicator {
  double? top;
  double? bottom;
  double? right;
  double? left;

  LoadingIndicator({this.bottom, this.right, this.left, this.top});

  static List<LoadingIndicator> indicatorPosition = [
    LoadingIndicator(top: 0, left: 20, right: 20),
    LoadingIndicator(top: 5.5, right: 5.5),
    LoadingIndicator(top: 20, bottom: 20, right: 0),
    LoadingIndicator(bottom: 5.5, right: 5.5),
    LoadingIndicator(bottom: 0, left: 20, right: 20),
    LoadingIndicator(bottom: 5.5, left: 5.5),
    LoadingIndicator(top: 20, left: 0, bottom: 20),
    LoadingIndicator(top: 5.5, left: 5.5),
  ];
}

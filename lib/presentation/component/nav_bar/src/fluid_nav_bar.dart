import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/nav_bar/src/fluid_nav_bar_icon.dart';
import 'package:orient_motors/presentation/component/nav_bar/src/fluid_nav_bar_style.dart';
import 'dart:ui' as ui;

import './curves.dart';
import './fluid_nav_bar_item.dart';

typedef FluidNavBarChangeCallback = void Function(int selectedIndex);

typedef FluidNavBarItemBuilder = Widget Function(
    FluidNavBarIcon icon, FluidNavBarItem item);

class FluidNavBar extends StatefulWidget {
  static const double nominalHeight = 60.0;

  /// The list of icons to display
  final List<FluidNavBarIcon> icons;

  /// A callback called when an icon has been tapped with its index
  final FluidNavBarChangeCallback? onChange;

  /// The style to use to paint the fluid navigation bar and its icons
  final FluidNavBarStyle? style;

  /// Delay to adjust the overall delay of the animations
  ///   * < 1 is faster
  ///   * = 1 default velocity
  ///   * > 1 is slower
  final double animationFactor;

  /// The scale factor used when an icon is tapped
  /// 1.0 means that the icon is not scaled and 1.5 means the icons is scaled to +50%
  /// An optional builder to change or wrap the builded item
  ///
  /// This is where you can wrap the item with semantic or
  /// other widget
  final double scaleFactor;

  /// Default Index is used for setting up selected item on start of the application.
  /// By default set to 0, meaning that item with index 0 will be selected.
  final int defaultIndex;

  final FluidNavBarItemBuilder itemBuilder;

  const FluidNavBar(
      {super.key,
      required this.icons,
      this.onChange,
      this.style,
      this.animationFactor = 1.0,
      this.scaleFactor = 1.2,
      this.defaultIndex = 0,
      FluidNavBarItemBuilder? itemBuilder})
      : itemBuilder = itemBuilder ?? _identityBuilder,
        assert(icons.length > 1);

  @override
  State createState() => _FluidNavBarState();

  static Widget _identityBuilder(FluidNavBarIcon icon, FluidNavBarItem item) =>
      item;
}

class _FluidNavBarState extends State<FluidNavBar>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late final AnimationController _xController;
  late final AnimationController _yController;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.defaultIndex;

    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_currentIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final appSize = MediaQuery.of(context).size;
    const height = FluidNavBar.nominalHeight;

    return SizedBox(
      width: appSize.width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: height,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildButtons()),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      height: FluidNavBar.nominalHeight,
      child: ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 8.0,
            sigmaY: 8.0,
          ),
          child: CustomPaint(
            painter: _BackgroundCurvePainter(
              _xController.value * MediaQuery.of(context).size.width,
              Tween<double>(
                begin: Curves.easeInExpo.transform(_yController.value),
                end: const ElasticOutCurve(0.38).transform(_yController.value),
              ).transform(_yController.velocity.sign * 0.5 + 0.5),
              widget.style?.barBackgroundColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return widget.icons
        .asMap()
        .entries
        .map(
          (entry) => widget.itemBuilder(
            entry.value,
            FluidNavBarItem(
              entry.value.svgPath ?? entry.value.svgPath,
              entry.value.icon,
              _currentIndex == entry.key,
              () => _handleTap(entry.key),
              entry.value.selectedForegroundColor ??
                  widget.style?.iconSelectedForegroundColor ??
                  Colors.black,
              entry.value.unselectedForegroundColor ??
                  widget.style?.iconUnselectedForegroundColor ??
                  Colors.grey,
              entry.value.backgroundColor ??
                  widget.style?.iconBackgroundColor ??
                  widget.style?.barBackgroundColor ??
                  Colors.white,
              widget.scaleFactor,
              widget.animationFactor,
            ),
          ),
        )
        .toList();
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width - 32;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    var buttonCount = widget.icons.length;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  void _handleTap(int index) {
    if (_currentIndex == index || _xController.isAnimating) return;

    setState(() {
      _currentIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 620) * widget.animationFactor);
    Future.delayed(
      const Duration(milliseconds: 500) * widget.animationFactor,
      () {
        _yController.animateTo(1.0,
            duration:
                const Duration(milliseconds: 1200) * widget.animationFactor);
      },
    );
    _yController.animateTo(0.0,
        duration: const Duration(milliseconds: 300) * widget.animationFactor);

    if (widget.onChange != null) {
      widget.onChange!(index);
    }
  }
}

class _BackgroundCurvePainter extends CustomPainter {
  static const _topDistance = 0.0;
  static final _bottomDistance = 6.h;

  final double _x;
  final double _normalizedY;
  final Color _color;

  _BackgroundCurvePainter(double x, double normalizedY, Color color)
      : _x = x,
        _normalizedY = normalizedY,
        _color = color;

  @override
  void paint(canvas, size) {
    // Paint two cubic bezier curves using various linear interpolations based off of the `_normalizedY` value
    final norm = const LinearPointCurve(0.5, 2.0).transform(_normalizedY) / 2;
    // Point colinear to the top edge of the background pane
    final dist = Tween<double>(begin: _topDistance, end: _bottomDistance)
        .transform(const LinearPointCurve(0.5, 0.0).transform(norm));
    final x0 = _x - (dist / 2) - 16.6;

    Path path_0 = Path();
    path_0.moveTo(x0 + 16, size.height * 0.6333333);
    path_0.cubicTo(x0 + 33, size.height * 0.6333333, x0 + 45,
        size.height * 0.4244000, x0 + 45, size.height * 0.1666667);
    path_0.cubicTo(x0 + 45, size.height * 0.1079468, x0 + 44.5,
        size.height * 0.05176000, x0 + 43, 0);
    path_0.lineTo(size.width * 0.9487179, 0);
    path_0.cubicTo(size.width * 0.9770410, 0, size.width,
        size.height * 0.1492385, size.width, size.height * 0.3333333);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.3333333);
    path_0.cubicTo(0, size.height * 0.1492383, size.width * 0.02295977, 0,
        size.width * 0.05128205, 0);
    path_0.lineTo(x0 - 9, 0);
    path_0.cubicTo(x0 - 10.5, size.height * 0.05176000, x0 - 11.2,
        size.height * 0.1079468, x0 - 11.2, size.height * 0.1666667);
    path_0.cubicTo(x0 - 11.2, size.height * 0.4244000, x0 - 1,
        size.height * 0.6333333, x0 + 17, size.height * 0.6333333);
    path_0.close();
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = _color.withOpacity(0.5);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(_BackgroundCurvePainter oldPainter) {
    return _x != oldPainter._x ||
        _normalizedY != oldPainter._normalizedY ||
        _color != oldPainter._color;
  }
}

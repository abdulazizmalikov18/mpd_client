import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';

class WButtonBottomSheet extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final void Function() onTap;

  const WButtonBottomSheet({
    super.key,
    required this.child,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: white.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(
            color: white.withOpacity(0.2),
          ),
        ),
      ),
      child: WButton(
        isLoading: isLoading,
        onTap: onTap,
        child: child,
      ),
    );
  }
}

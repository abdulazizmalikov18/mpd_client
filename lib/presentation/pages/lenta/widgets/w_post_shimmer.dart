import 'package:flutter/cupertino.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';

class WPostShimmer extends StatelessWidget {
  const WPostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                WShimmer(
                  width: 36,
                  height: 36,
                  radius: 100,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WShimmer(
                      width: 150,
                      height: 20,
                    ),
                    SizedBox(height: 4),
                    WShimmer(
                      width: 100,
                      height: 15,
                    ),
                  ],
                )
              ],
            ),
          ),
          WShimmer(
            width: double.infinity,
            height: 400,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    WShimmer(
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    WShimmer(
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                WShimmer(
                  width: double.infinity,
                  height: 20,
                ),
                SizedBox(height: 4),
                WShimmer(
                  width: 100,
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

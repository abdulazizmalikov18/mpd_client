import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class WPrivacyPolicyBottomSheet extends StatelessWidget {
  const WPrivacyPolicyBottomSheet({super.key});

  String get text => """Lorem ipsum dolor sit amet consectetur.

Morbi fames vel nisl tempus et ut cras. Ligula ipsum mauris platea donec. Feugiat habitant malesuada lorem amet magna morbi. Lacus sit vulputate nisi enim felis tristique pellentesque mauris eget. Donec convallis tellus lorem tellus. Posuere dui fringilla viverra aenean dictumst a adipiscing ullamcorper nec. Hendrerit et consequat sed enim. Id nibh magnis fermentum scelerisque praesent. Nullam cursus mauris malesuada dolor dignissim. Diam eget amet sit consequat ultrices adipiscing sodales commodo ut. Libero enim lectus habitant quam in diam fermentum dis. Vestibulum duis quis aliquet eget nam tortor ac tincidunt. Fames amet risus maecenas diam ac adipiscing. Nibh nunc vitae eget auctor.

Neque vel luctus mauris eu adipiscing sagittis. Ultricies eget ut egestas in adipiscing risus. Id ut erat ac malesuada integer ornare. Eu eu scelerisque quisque enim egestas mattis. Suspendisse nisl nisi praesent accumsan sed est massa quam amet. Diam nisl sed faucibus ultrices vulputate lorem nullam sed. Nunc vivamus lectus ultrices id mauris mattis pretium ut bibendum. Turpis non libero nunc posuere neque bibendum. Ut at turpis penatibus faucibus lacinia pharetra interdum in. Orci eu ac tempor non non sodales ac diam. Leo netus porttitor quam vivamus vitae. At molestie tincidunt odio tellus semper molestie molestie tellus et. Libero id faucibus risus faucibus. Ultricies libero cursus tristique fermentum est tellus elementum porttitor nisi.
Orci id sem ipsum felis hendrerit eget semper suscipit. 

Pharetra molestie tempor amet quam in pulvinar leo dapibus. Nisi morbi ut id sodales ultricies in. In risus est purus porta ac tortor imperdiet sapien quis. Viverra cursus posuere ultrices consequat sagittis nec eget molestie neque. Cursus porta aliquam et rhoncus sit augue faucibus. Mi vel sed proin a aliquam ultricies neque. Eget et laoreet integer laoreet morbi orci viverra amet. In convallis amet sed sollicitudin. Imperdiet dictumst enim justo sollicitudin sed eu metus nunc.
Habitant ultrices non mauris dolor vel. Phasellus ipsum aliquam aliquet ut ultrices tortor nunc. Facilisi tellus mattis odio turpis lorem lacus morbi at. Mi sit augue turpis pharetra libero est duis. Vitae maecenas feugiat malesuada pretium. Fermentum faucibus etiam scelerisque nam sed id quis amet mauris. Urna pellentesque nunc tempor sem. Consectetur dignissim lacinia at sit ut diam sit. Id sed sed et sit pretium quisque diam. Dui nam curabitur sit duis feugiat feugiat in. Erat a feugiat lectus morbi ultricies et tempor volutpat. Mauris tincidunt a congue porttitor cursus dictumst duis. Massa vel amet id tortor neque pellentesque sapien. Suspendisse imperdiet id mattis egestas quis libero sed viverra arcu. Faucibus morbi ut euismod dignissim dignissim molestie viverra at ut.
Amet eleifend lectus tempus duis sem nibh lobortis. Facilisi in a lectus sem sed aliquet. Enim neque sed nunc eget amet sagittis hendrerit libero. Pellentesque montes id convallis tellus. Facilisis sagittis dictum diam urna. Diam tortor mi in eget massa adipiscing ac ornare. Vel ullamcorper enim at sollicitudin at. Condimentum viverra in gravida risus viverra lacus leo. Ac tempor vestibulum velit pulvinar ornare fames aliquam. Diam urna sed egestas morbi egestas volutpat. Scelerisque eleifend eget purus sit. Eros tellus orci aenean tellus ut. Commodo non ipsum diam ac vitae a aliquet. Vulputate semper odio sagittis convallis odio. Duis consequat pharetra molestie nunc cursus sed lacus eu.""";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        WButton(
          width: 48,
          height: 48,
          shadow: const [],
          border: Border.all(),
          color: closeButton,
          margin: const EdgeInsets.only(right: 16),
          borderRadius: 100,
          onTap: () {
            context.pop();
          },
          // child: AppIcons.close.svg(),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: SizedBox(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Text(
                                'Ommaviy oferta shartlari',
                                style: context.textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                text,
                                style: context.textTheme.labelSmall!.copyWith(
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Spacer(),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  black,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Spacer(),
                          WButton(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            text: "Accept",
                            onTap: () {
                              context.pop("true");
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

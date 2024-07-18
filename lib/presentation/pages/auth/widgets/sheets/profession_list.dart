import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/application/auth/controller/registration_view_model.dart';
import 'package:mpd_client/domain/entity/account/profession_entity.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_scale_animation.dart';

class ProfessionListView extends StatefulWidget {
  const ProfessionListView({
    super.key,
    required this.profession,
    required this.controller,
    required this.index,
    required this.isLoading,
  });

  final List<ProfessionEntity> profession;
  final PageController controller;
  final int index;
  final bool isLoading;

  @override
  State<ProfessionListView> createState() => _ProfessionListViewState();
}

class _ProfessionListViewState extends State<ProfessionListView> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.profession.length,
            itemBuilder: (context, index) => WScaleAnimation(
              onTap: () {
                if (widget.profession[index].isParent) {
                  Log.w(widget.profession[index].isParent.toString());
                  if (widget.controller.hasClients) {
                    widget.controller.animateToPage(
                      widget.index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                  $regVM().selectPagProffesion(
                    context,
                    widget.index,
                    widget.profession[index].name,
                    widget.profession[index].id,
                  );
                } else {
                  Navigator.pop(context, MapEntry(widget.profession[index].id, widget.profession[index].name));
                  $regVM().selectPagProffesion(context, 0, "", 0);
                }

                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 40,
                      child: widget.profession[index].image.isEmpty
                          ? const SizedBox()
                          : Image.network(
                              widget.profession[index].image,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(),
                            ),
                    ),
                    Expanded(child: Text(widget.profession[index].name)),
                    if (widget.profession[index].isParent)
                      const Icon(
                        CupertinoIcons.right_chevron,
                        color: gray,
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}

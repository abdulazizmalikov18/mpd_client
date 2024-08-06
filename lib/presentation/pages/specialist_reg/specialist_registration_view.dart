import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/app_bar_widget.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_custom_text_field.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class SpecialistRegisterPage extends StatefulWidget {
  const SpecialistRegisterPage({super.key});

  @override
  State<SpecialistRegisterPage> createState() => _SpecialistRegisterPageState();
}

class _SpecialistRegisterPageState extends State<SpecialistRegisterPage> {
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _extension;

  void _pickFiles() async {
    _resetState();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false) ? _extension?.replaceAll(' ', '').split(',') : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _fileName = _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  void _logException(String message) {
    print(message);
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _fileName = null;
      _paths = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "About you"),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AnimatedContainer(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        margin: const EdgeInsets.only(bottom: 24),
        duration: const Duration(milliseconds: 300),
        child: LongButton(
          onPress: () {},
          buttonName: "Register",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              title: "About you",
              hintText: "Write here ",
              onChanged: (value) {},
              minLines: 5,
              maxLines: 8,
              noHeight: true,
              expands: false,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  "Education & certifications (1)",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            CustomTextField(
              hintText: "Write here ",
              onChanged: (value) {},
              minLines: 1,
              maxLines: 6,
              noHeight: true,
              expands: false,
            ),
            SizedBox(height: 16.h),
            Builder(
              builder: (context) => _paths != null && _paths!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: _paths != null && _paths!.isNotEmpty ? _paths!.length : 1,
                      itemBuilder: (context, index) {
                        final bool isMultiPath = _paths != null && _paths!.isNotEmpty;
                        final String name = isMultiPath ? _paths!.map((e) => e.name).toList()[index] : _fileName ?? '...';

                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: border),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: grey,
                                  border: Border.all(color: border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: AppIcons.files.svg(),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: black,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (_paths!.length > 1) {
                                    _paths!.removeAt(index);
                                  } else {
                                    _paths!.clear();
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    )
                  : const SizedBox(),
            ),
            InkWell(
              onTap: () {
                _pickFiles();
              },
              child: DottedBorder(
                color: border,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                child: SizedBox(
                  height: 106.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 48.h,
                        width: 48.h,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: border.withOpacity(.5),
                        ),
                        child: AppIcons.files.svg(),
                      ),
                      SizedBox(height: 4.h),
                      const Text(
                        "Add File",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF677294),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

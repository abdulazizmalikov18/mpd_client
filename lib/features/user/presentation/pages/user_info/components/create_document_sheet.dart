import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/custom_snackbar.dart';
import 'package:mpd_client/src/widgets/label_input_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';


class CreateDocumentSheet extends StatefulWidget {
  const CreateDocumentSheet({super.key});

  @override
  State<CreateDocumentSheet> createState() => _CreateDocumentSheetState();
}

class _CreateDocumentSheetState extends State<CreateDocumentSheet> {
  final TextEditingController _descController = TextEditingController();
  File? _selectedFile;
  bool _isPicking = false;

  Future<void> _pickFile() async {
    if (_isPicking) return;
    _isPicking = true;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } finally {
      _isPicking = false;
    }
  }

  void _submit() {
    if (_selectedFile == null) {
      CustomSnackbar.show(context, "Iltimos avval hujjat yuklang!");
      return;
    }
    context.read<UserInfoBloc>().add(
          CreateDocumentEvent(
            filePath: _selectedFile!.path,
            description: _descController.text.trim(),
            onSuccess: () {
              Navigator.pop(context);
              CustomSnackbar.show(context, "Muvaffaqiyatli saqlandi!");
            },
            onError: () {
              CustomSnackbar.show(context, "Hujjat yuklashda xatolik yuz berdi");
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Yangi hujjat qo'shish",
                style: Styles.headline7.copyWith(color: context.color.black, fontSize: 18.sp),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: context.color.background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: context.color.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(
                color: context.color.background,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: context.color.grey.withValues(alpha: 0.3),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.attach_file,
                    color: _selectedFile != null
                        ? context.color.mainBlue
                        : context.color.grey,
                    size: 32.h,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _selectedFile != null
                        ? _selectedFile!.path.split('/').last
                        : "Hujjatni tanlang (PDF, PNG, JPG, DOC)",
                    style: Styles.headline5.copyWith(
                      color: _selectedFile != null
                          ? context.color.mainBlue
                          : context.color.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          LabelInputWidget(
            controller: _descController,
            topHint: "Tavsif (ixtiyoriy)",
            inputHint: "Hujjat haqida qisqacha",
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 24.h),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              return LongButton(
                loading: state.statusDocCreate == FormzSubmissionStatus.inProgress,
                buttonName: "Saqlash",
                onPress: _submit,
              );
            },
          ),
        ],
      ),
    );
  }
}

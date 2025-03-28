import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';
import 'package:mpd_client/src/loading/download_file.dart';
import 'package:open_file/open_file.dart';

class WChatFileView extends StatefulWidget {
  final String file;
  final bool isLocalFile;

  const WChatFileView(
      {super.key, required this.file, required this.isLocalFile});

  @override
  State<WChatFileView> createState() => _WChatFileViewState();
}

class _WChatFileViewState extends State<WChatFileView> {
  late final DownloadFile _downloadFile = DownloadFile(
    file: widget.file,
    setState: setState,
  );

  @override
  void initState() {
    super.initState();
    _downloadFile.initFile();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        WButton(
          onTap: () async {
            if (widget.isLocalFile) {
              OpenFile.open(widget.file);
            }
            _downloadFile.fileExists && !_downloadFile.dowloading
                ? _downloadFile.openfile()
                : _downloadFile.startDownload();
          },
          color: blue,
          borderRadius: 100,
          height: 40,
          width: 40,
          child: _downloadFile.fileExists
              ? Icon(
                  Icons.save,
                  color: context.color.black,
                )
              : _downloadFile.dowloading
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: _downloadFile.progress,
                          strokeWidth: 3,
                          backgroundColor: context.color.black,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            blue,
                          ),
                        ),
                        Text(
                          (_downloadFile.progress * 100).toStringAsFixed(2),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  :  Icon(
                      Icons.download,
                      color: context.color.white,
                    ),
        ),
        const SizedBox(width: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 0,
            maxWidth: 120,
          ),
          child: Text(
            widget.file.substring(
              8,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
              fontSize: 16,
              color: context.color.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}

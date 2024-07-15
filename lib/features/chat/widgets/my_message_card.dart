import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/features/chat/widgets/display_text_image_gif.dart';
import 'package:whatsapp_ui/colors.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.isSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    void handleLeftSwipe(DragUpdateDetails) {
      onLeftSwipe();
    }

    void handleTap() {
      if (type == MessageEnum.image) {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: PhotoView(
              imageProvider: NetworkImage(message),
            ),
          ),
        );
      } else if (type == MessageEnum.video) {
        // Implement VideoPlayerScreen similar to the example provided previously
        // showDialog(
        //   context: context,
        //   builder: (_) => Dialog(
        //     child: VideoPlayerScreen(videoUrl: message),
        //   ),
        // );
      }
    }

    return SwipeTo(
      onLeftSwipe: handleLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: InkWell(
              onTap: handleTap,
              child: Stack(
                children: [
                  Padding(
                    padding: type == MessageEnum.text
                        ? const EdgeInsets.only(left: 10, right: 30, top: 5, bottom: 20)
                        : const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 25),
                    child: Column(
                      children: [
                        if (isReplying) ...[
                          Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: DisplayTextImageGIF(
                              message: repliedText,
                              type: repliedMessageType,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        DisplayTextImageGIF(
                          message: message,
                          type: type,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(
                      children: [
                        Text(date, style: const TextStyle(fontSize: 13, color: Colors.white60)),
                        const SizedBox(width: 5),
                        Icon(isSeen ? Icons.done_all : Icons.done, size: 20, color: isSeen ? Colors.blue : Colors.white60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

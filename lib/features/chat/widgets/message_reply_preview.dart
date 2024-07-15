import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';
import 'package:whatsapp_ui/features/chat/widgets/display_text_image_gif.dart';

import '../../../common/enums/message_enum.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.state).update((state) => null);
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    final containerHeight = messageReply?.messageEnum == MessageEnum.image
        ? MediaQuery.of(context).size.height / 4
        : null; // Use null or a specific value for default height

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: containerHeight,
        width: 350,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    messageReply!.isMe ? 'Me' : 'Opposite',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onTap: () => cancelReply(ref),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (messageReply.messageEnum == MessageEnum.image)
              Expanded(
                child: CachedNetworkImage(
                  imageUrl:messageReply.message,
                  fit: BoxFit.fill, // Using BoxFit.fitWidth as an example
                ),
              )
            else
            // Fallback for other message types
              DisplayTextImageGIF(
                message: messageReply.message,
                type: messageReply.messageEnum,
              ),
          ],
        ),
      ),
    );
  }
}
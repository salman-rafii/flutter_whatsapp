import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_whatsapp/colors.dart';
import 'package:flutter_whatsapp/common/enums/message_enum.dart';
import 'package:flutter_whatsapp/common/provider/message_reply_provider.dart';
import 'package:flutter_whatsapp/common/utils/utils.dart';
import 'package:flutter_whatsapp/features/chat/controller/chat_controller.dart';
import 'package:flutter_whatsapp/features/chat/widgets/message_reply_preview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  const BottomChatField({Key? key, required this.receiverUserId})
      : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  // #################### VARIABLES ################################

  final TextEditingController textController = TextEditingController();
  bool isShowSendButton = false;
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();
  bool isRecorderInit = false;
  FlutterSoundRecorder? flutterSoundRecorder;
  bool isRecording = false;
  // #################### METHODS ################################

  @override
  void initState() {
    flutterSoundRecorder = FlutterSoundRecorder();
    super.initState();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic Permission is not granted!');
    }
    await flutterSoundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            textController.text.trim(),
            widget.receiverUserId,
          );

      setState(() {
        textController.text = "";
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = "${tempDir.path}/flutter_sound.aac";
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await flutterSoundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await flutterSoundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(File file, MessageEnum messageEnum) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.receiverUserId,
          messageEnum,
        );
  }

  void selectImage() async {
    File? pickedImage = await pickImageFromGallery(context);
    if (pickedImage != null) {
      sendFileMessage(pickedImage, MessageEnum.image);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      ref
          .read(chatControllerProvider)
          .sendGIF(context, gif.url, widget.receiverUserId);
    }
  }

  void selectVideo() async {
    File? video = await pickImageFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

// function to upadate the emoji container
  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    textController.dispose();
    flutterSoundRecorder!.closeRecorder();
    isRecorderInit = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply
            ? const MessageReplyPreview()
            : Row(
                children: [
                  Expanded(
                    child: TextField(
                        focusNode: focusNode,
                        controller: textController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: mobileChatBoxColor,
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: toggleEmojiKeyboardContainer,
                                    icon: isShowEmojiContainer
                                        ? const Icon(
                                            Icons.emoji_emotions,
                                            color: Colors.grey,
                                          )
                                        : const Icon(Icons.keyboard),
                                  ),
                                  IconButton(
                                    onPressed: selectGIF,
                                    icon: const Icon(
                                      Icons.gif,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          suffixIcon: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: selectVideo,
                                  icon: const Icon(
                                    Icons.attach_file,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hintText: 'Type a message!',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            isShowSendButton = false;
                          } else {
                            isShowSendButton = true;
                          }
                          setState(() {});
                        }),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(right: 2, bottom: 8, left: 2),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xff128c7e),
                      child: GestureDetector(
                        onTap: sendTextMessage,
                        child: Icon(
                          isShowSendButton
                              ? Icons.send
                              : isRecording
                                  ? Icons.close
                                  : Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      textController.text = textController.text + emoji.emoji;
                    });

                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  },
                ),
              )
            : Container()
      ],
    );
  }
}

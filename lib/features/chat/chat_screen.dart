import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/get_profile_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/widgets/circular_loading.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'dart:math' as math;

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    this.uuid,
    this.type,
    this.channel,
    this.dataUuid,
    this.channelId,
    this.giglistTitle,
  });

  final String? uuid;
  final String? type;
  final String? dataUuid;
  final String? channelId;
  final Channel? channel;
  final String? giglistTitle;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  Channel? channel;
  String? error;

  late final messageInputController = StreamMessageInputController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    getChannel();

    var id = getUserId();
    if (id != null) {
      ref.read(getProfileControllerProvider(id));
    }
  }

  Future<void> getChannel() async {
    if (widget.channel != null) {
      channel = widget.channel;

      await channel!.markRead();

      return;
    }

    var uuid = ref.read(profileControllerProvider).value!.uuid;
    var chat = StreamChat.of(context);

    try {
      ChannelState state;

      if (widget.channelId != null) {
        state = await chat.client.queryChannel(
          widget.type ?? 'messaging',
          channelId: widget.channelId,
        );
      } else {
        state = await chat.client.queryChannel(
          widget.type ?? 'messaging',
          channelData: {
            if (widget.dataUuid != null) 'uuid': widget.dataUuid,
            'members': [uuid, widget.uuid],
          },
        );
      }

      if (state.channel == null) return;

      channel = Channel(
        chat.client,
        state.channel!.type,
        state.channel!.id,
        name: state.channel!.name,
        extraData: state.channel!.extraData,
      );

      setState(() {});

      var r = await channel!.watch();

      if (widget.giglistTitle != null) {
        if (r.messages?.isEmpty ?? true) {
          var members = channel!.state!.members;
          final otherMembers = members.where(
            (member) => member.userId != channel!.client.state.currentUser!.id,
          );

          var name = otherMembers.firstOrNull?.user?.name;

          await channel!.sendMessage(
            Message(
              text:
                  'Hi ${name ?? ''} I am interested in this announcement ${widget.giglistTitle}',
            ),
          );
        }
      }

      await channel!.markRead();
    } catch (e) {
      error = e.toString();
      setState(() {});
    }
  }

  String? getUserId() {
    if (widget.uuid != null) {
      return widget.uuid;
    }

    if (widget.channel != null) {
      var members = widget.channel!.state!.members;
      final otherMembers = members.where(
        (member) =>
            member.userId != widget.channel!.client.state.currentUser!.id,
      );

      return otherMembers.firstOrNull?.user?.id;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, color: colorRed, size: 36),
              SizedBox(height: 10),
              TextViewWidget(
                text: kDebugMode
                    ? error.toString()
                    : 'This user is not ready to chat',
                color: colorTextGrey,
              ),
            ],
          ),
        ),
      );
    }

    if (channel == null) {
      return Scaffold(body: CircularLoading());
    }

    return StreamChannel(
      channel: channel!,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: TextViewWidget(text: 'This user is not ready to chat'),
        );
      },
      child: Scaffold(
        appBar: StreamChannelHeader(
          onImageTap: () async {
            if (widget.uuid != null) {
              ProfileRoute(uuid: widget.uuid).push(context);
              return;
            }

            if (widget.channel != null) {
              var members = widget.channel!.state!.members;
              final otherMembers = members.where(
                (member) =>
                    member.userId !=
                    widget.channel!.client.state.currentUser!.id,
              );

              var id = otherMembers.firstOrNull?.user?.id;
              if (id == null) return;
              ProfileRoute(uuid: id).push(context);
            }
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamMessageListView(
                showScrollToBottom: true,
                showUnreadIndicator: false,
                markReadWhenAtTheBottom: true,
                showFloatingDateDivider: false,
                threadBuilder: (_, parent) => ThreadPage(parent: parent!),
                messageBuilder: (
                  context,
                  messageDetails,
                  messages,
                  defaultWidget,
                ) {
                  // The threshold after which the message is considered
                  // swiped.
                  const threshold = 0.2;

                  final isMyMessage = messageDetails.isMyMessage;

                  // The direction in which the message can be swiped.
                  final swipeDirection = isMyMessage
                      ? SwipeDirection.endToStart
                      : SwipeDirection.startToEnd;

                  return Swipeable(
                    key: ValueKey(messageDetails.message.id),
                    direction: swipeDirection,
                    swipeThreshold: threshold,
                    onSwiped: (details) => reply(messageDetails.message),
                    backgroundBuilder: (context, details) {
                      // The alignment of the swipe action.
                      final alignment = isMyMessage
                          ? Alignment.centerRight //
                          : Alignment.centerLeft;

                      // The progress of the swipe action.
                      final progress =
                          math.min(details.progress, threshold) / threshold;

                      // The offset for the reply icon.
                      var offset = Offset.lerp(
                        const Offset(-24, 0),
                        const Offset(12, 0),
                        progress,
                      )!;

                      // If the message is mine, we need to flip the offset.
                      if (isMyMessage) {
                        offset = Offset(-offset.dx, -offset.dy);
                      }

                      final _streamTheme = StreamChatTheme.of(context);

                      return Align(
                        alignment: alignment,
                        child: Transform.translate(
                          offset: offset,
                          child: Opacity(
                            opacity: progress,
                            child: SizedBox.square(
                              dimension: 30,
                              child: CustomPaint(
                                painter: AnimatedCircleBorderPainter(
                                  progress: progress,
                                  color: _streamTheme.colorTheme.borders,
                                ),
                                child: Center(
                                  child: SizedBox
                                      .shrink(), // This hides the widget completely
                                ),

                                //! need to fix
                                // child: Center(
                                //   child: StreamSvgIcon(
                                //     icon: const StreamSvgIcon.reply(),
                                //     size: lerpDouble(0, 18, progress),
                                //     color:
                                //         _streamTheme.colorTheme.accentPrimary,
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: defaultWidget.copyWith(
                      onReplyTap: reply,
                      showUsername: false,
                    ),
                  );
                },
              ),
            ),
            StreamMessageInput(
              focusNode: focusNode,
              disableAttachments: true,
              showCommandsButton: false,
              messageInputController: messageInputController,
              onQuotedMessageCleared: messageInputController.clearQuotedMessage,
            ),
          ],
        ),
      ),
    );
  }

  void reply(Message message) {
    messageInputController.quotedMessage = message;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    messageInputController.dispose();
    super.dispose();
  }
}

class ThreadPage extends StatelessWidget {
  const ThreadPage({
    super.key,
    required this.parent,
  });

  final Message parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamThreadHeader(parent: parent),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamMessageListView(
              parentMessage: parent,
            ),
          ),
          StreamMessageInput(
            messageInputController: StreamMessageInputController(
              message: Message(parentId: parent.id),
            ),
          ),
        ],
      ),
    );
  }
}

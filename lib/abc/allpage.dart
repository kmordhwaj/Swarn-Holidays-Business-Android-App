import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swarn_holidays_business_main/user_data.dart';
import 'package:swarn_holidays_business_main/msssenger/views/chatscreen.dart';
import 'package:swarn_holidays_business_main/abc/custom_tile.dart';
import 'package:swarn_holidays_business_main/utilities/constants.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = Provider.of<UserData>(context, listen: false).currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ChatListContainer(
        currentUserId: currentUserId!,
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  const NewChatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          //  gradient: UniversalVariables.fabGradient,
          borderRadius: BorderRadius.circular(50)),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: const EdgeInsets.all(15),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  final String? currentUserId;
  const ChatListContainer({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chatRooms')
                .where('users', arrayContains: widget.currentUserId)
                .orderBy('lastMessageSendTs', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      bool isDeleted = ds['isDeleted'];
                      String fname = ds['lastMessageSendByFN'];
                      String sname = ds['lastMessageSendBySN'];
                      String fnameO = ds['lastMessageSendToFN'];
                      String snameO = ds['lastMessageSendToSN'];
                      String? profImg = ds['lastMessageSenderDp'];
                      String? profImgO = ds['lastMessageSendDp'];
                      String? profId = ds['lastMessageSenderId'];
                      String? profIdO = ds['lastMessageSendId'];
                      Timestamp time = ds['lastMessageSendTs'];
                      String? msg = ds['lastMessage'];
                      String? voice = ds['lastVoiceMsgUrl'];
                      String? music = ds['lastMusicMsgUrl'];
                      String? photo = ds['lastPhotoMsgUrl'];
                      String? video = ds['lastVideoMsgUrl'];
                      String? pdf = ds['lastPdfMsgUrl'];
                      bool isVoice = voice == null;
                      bool isMusic = music == null;
                      bool isPhoto = photo == null;
                      bool isVideo = video == null;
                      bool isPdf = pdf == null;
                      bool isProfImg = profImg == null;
                      bool isProfImgO = profImgO == null;
                      bool isMe = profId == widget.currentUserId;
                      DateTime dateNow = DateTime.now();
                      Timestamp timeNow = Timestamp.fromDate(dateNow);
                      Timestamp timeYest = Timestamp.fromDate(DateTime(
                          dateNow.year,
                          dateNow.month,
                          dateNow.day - 1,
                          dateNow.hour,
                          dateNow.minute,
                          dateNow.second,
                          dateNow.microsecond));
                      DateTime daydate = time.toDate();
                      String day = daydate.day.toString();
                      String today = timeNow.toDate().day.toString();
                      String yesterday = timeYest.toDate().day.toString();
                      bool isToday = day == today;
                      bool isYest = day == yesterday;

                      return isMe
                          ? CustomTile(
                              mini: false,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              profileId: profIdO,
                                              currentUserId: currentUserId,
                                              myfirstname: firstName,
                                              mysecondname: secondName,
                                              myprofImg: profileImageUrl,
                                              firstname: fnameO,
                                              secondname: snameO,
                                              profImg: profImgO,
                                            )));
                              },
                              title: Text(
                                '$fnameO $snameO',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              subtitle: isDeleted
                                  ? Row(
                                      children: const [
                                        Icon(Icons.access_time_outlined,
                                            color: Colors.grey, size: 18),
                                        SizedBox(width: 6),
                                        Text(
                                          'This message is deleted',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        isPhoto
                                            ? isVoice
                                                ? isMusic
                                                    ? isVideo
                                                        ? isPdf
                                                            ? Container()
                                                            : Row(
                                                                children: const [
                                                                  Icon(
                                                                      Icons
                                                                          .file_copy_rounded,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 18),
                                                                  SizedBox(
                                                                      width: 8)
                                                                ],
                                                              )
                                                        : Row(
                                                            children: const [
                                                              Icon(
                                                                  Icons
                                                                      .video_camera_back_rounded,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 18),
                                                              SizedBox(width: 8)
                                                            ],
                                                          )
                                                    : Row(
                                                        children: const [
                                                          Icon(
                                                              Icons
                                                                  .music_note_rounded,
                                                              color:
                                                                  Colors.grey,
                                                              size: 18),
                                                          SizedBox(width: 8)
                                                        ],
                                                      )
                                                : Row(
                                                    children: const [
                                                      Icon(Icons.mic,
                                                          color: Colors.grey,
                                                          size: 18),
                                                      SizedBox(width: 8)
                                                    ],
                                                  )
                                            : Row(
                                                children: const [
                                                  Icon(Icons.photo,
                                                      color: Colors.grey,
                                                      size: 18),
                                                  SizedBox(width: 8)
                                                ],
                                              ),
                                        Text(
                                          msg!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                              trailing: Text(
                                isToday
                                    ? '${time.toDate().hour.toString()}:${time.toDate().minute.toString()}'
                                    : isYest
                                        ? 'Yesterday'
                                        : DateFormat.yMMMd().format(daydate),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 13),
                              ),
                              leading: Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 50, maxWidth: 50),
                                child: Stack(
                                  children: [
                                    isProfImgO
                                        ? CircleAvatar(
                                            maxRadius: 25,
                                            backgroundColor:
                                                Colors.purple.shade800,
                                            child: Text(
                                                '${fnameO[0].toUpperCase()} ${snameO[0].toUpperCase()}'),
                                          )
                                        : CircleAvatar(
                                            maxRadius: 25,
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    profImgO),
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : CustomTile(
                              mini: false,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              profileId: profId,
                                              currentUserId: currentUserId,
                                              myfirstname: firstName,
                                              mysecondname: secondName,
                                              myprofImg: profileImageUrl,
                                              firstname: fname,
                                              secondname: sname,
                                              profImg: profImg,
                                            )));
                              },
                              title: Text(
                                '$fname $sname',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              subtitle: isDeleted
                                  ? Row(
                                      children: const [
                                        Icon(Icons.access_time_outlined,
                                            color: Colors.grey, size: 18),
                                        SizedBox(width: 6),
                                        Text(
                                          'This message is deleted',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        )
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        isPhoto
                                            ? isVoice
                                                ? isMusic
                                                    ? isVideo
                                                        ? isPdf
                                                            ? Container()
                                                            : Row(
                                                                children: const [
                                                                  Icon(
                                                                      Icons
                                                                          .file_copy_rounded,
                                                                      color: Colors
                                                                          .grey,
                                                                      size: 18),
                                                                  SizedBox(
                                                                      width: 8)
                                                                ],
                                                              )
                                                        : Row(
                                                            children: const [
                                                              Icon(
                                                                  Icons
                                                                      .video_camera_back_rounded,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 18),
                                                              SizedBox(width: 8)
                                                            ],
                                                          )
                                                    : Row(
                                                        children: const [
                                                          Icon(
                                                              Icons
                                                                  .music_note_rounded,
                                                              color:
                                                                  Colors.grey,
                                                              size: 18),
                                                          SizedBox(width: 8)
                                                        ],
                                                      )
                                                : Row(
                                                    children: const [
                                                      Icon(Icons.mic,
                                                          color: Colors.grey,
                                                          size: 18),
                                                      SizedBox(width: 8)
                                                    ],
                                                  )
                                            : Row(
                                                children: const [
                                                  Icon(Icons.photo,
                                                      color: Colors.grey,
                                                      size: 18),
                                                  SizedBox(width: 8)
                                                ],
                                              ),
                                        Text(
                                          msg!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                              trailing: Text(
                                isToday
                                    ? '${time.toDate().hour.toString()}:${time.toDate().minute.toString()}'
                                    : isYest
                                        ? 'Yesterday'
                                        : DateFormat.yMMMd().format(daydate),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 13),
                              ),
                              leading: Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 50, maxWidth: 50),
                                child: Stack(
                                  children: [
                                    isProfImg
                                        ? CircleAvatar(
                                            maxRadius: 25,
                                            backgroundColor:
                                                Colors.purple.shade800,
                                            child: Text(
                                                '${fname[0].toUpperCase()} ${sname[0].toUpperCase()}'),
                                          )
                                        : CircleAvatar(
                                            maxRadius: 25,
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    profImg),
                                          ),
                                  ],
                                ),
                              ),
                            );
                    });
              }
              return Container();
            }));
  }
}

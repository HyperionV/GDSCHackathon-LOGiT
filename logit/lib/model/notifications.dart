import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> message = [
  ' đã gửi cho bạn một tin nhắn.',
  ' đã xác nhận yêu cầu đặt lịch khám của bạn.',
  ' đã yêu cầu bạn đặt lịch khám.',
  ' đã đặt lịch khám.',
  ' đã chấp nhận yêu cầu kết nối.',
  ' đã tạo một báo cáo sức khỏe mới.',
  ' đã có dấu hiệu bất thường, hãy liên hệ với bệnh nhân sớm nhất có thể.',
];

// type of notification
// 0 - message -> redirect to the connection panel
// 1 - confirmed appointment -> redirect to calendar at the date
// 2 - appointment request -> open create reminder with the given date and time
// 3 - appointment offered -> open create reminder
// 4 - connection accepted -> open connection panel
// 5 - new medical record -> open health diary, exclusively for doctor
// 6 - critical conditions -> open connection confirmation panel, exclusively for doctor

class NotificationData {
  final String uid;
  final String sender;
  final int type;
  bool isRead;
  final Timestamp createTime;
  final Timestamp timeAttached;
  // final String treatmentAttached;

  NotificationData(
    this.uid,
    this.sender,
    this.type,
    this.createTime,
    this.timeAttached,
    // this.treatmentAttached,
    this.isRead,
  );
}

List<NotificationData> notifications = [];

Future<void> fetchNotifications() async {
  notifications.clear();
  final notificationCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notifications');
  final NotificationSnapshot = await notificationCollection.get();
  for (final noti in NotificationSnapshot.docs) {
    if (noti.exists) {
      Map<String, dynamic> notiRecord = noti.data();
      notifications.add(
        NotificationData(
          noti.id,
          notiRecord['sender'] as String,
          notiRecord['type'] as int,
          notiRecord['createTime'] as Timestamp,
          notiRecord['timeAttached'] as Timestamp,
          // notiRecord['treatmentAttached'] as String,
          notiRecord['isRead'] as bool,
        ),
      );
    }
  }
}

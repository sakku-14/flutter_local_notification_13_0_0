import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsUtils {
  // 今すぐ通知する
  static Future<void> notifyNow() async {
    final flnp = FlutterLocalNotificationsPlugin();
    flnp.show(
      0,
      '手動通知',
      'あなたがボタンをタップしました',
      const NotificationDetails(
        iOS: DarwinNotificationDetails(categoryIdentifier: 'plainCategory'),
      ),
    );
  }

  static Future<void> scheduleNotifications(DateTime dateTime,
      {DateTimeComponents? dateTimeComponents}) async {
    // 日時をTimeZoneを考慮した日時に変換する
    final scheduleTime = tz.TZDateTime.from(dateTime, tz.local);

    // 通知をスケジュールする
    final flnp = FlutterLocalNotificationsPlugin();
    await flnp.zonedSchedule(
      1,
      'スケジュール通知',
      'あなたがスケジュールした時間になりました',
      scheduleTime,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(categoryIdentifier: 'plainCategory'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  // 通知をキャンセル
  static Future<void> cancelNotificationsSchedule() async {
    final flnp = FlutterLocalNotificationsPlugin();
    await flnp.cancelAll();
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.alertId,
    required this.userId,
  });

  final String title, subTitle, alertId, userId;
  final IconData icon;

  Future<void> sendResponse(String alertId, String response) async {
    CollectionReference notifications = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications');

    await notifications.doc(alertId).update({
      'response': response,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'icon': icon.codePoint, // Convert IconData to codePoint
      'alertId': alertId,
    };
  }

  factory AlertBox.fromJson(Map<String, dynamic> json) {
    return AlertBox(
      title: json['title'],
      subTitle: json['subTitle'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      alertId: json['alertId'],
      userId: json['userId'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 16,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 180,
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  title,
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                  )),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 10,
                  ),
                  child: Text(
                    subTitle,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: kTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await sendResponse(alertId, 'yes');
                      },
                      icon: const FaIcon(FontAwesomeIcons.check,
                          size: 35, color: kTextColor),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendResponse(alertId, 'no');
                      },
                      icon: const FaIcon(FontAwesomeIcons.times,
                          size: 35, color: kTextColor),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  right: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

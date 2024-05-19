import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBar extends StatelessWidget {
  String barText;
  bool isChat = true;
  CustomBar({
    Key? key,
    required this.isChat,
    required this.barText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.85,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100], // Soft Gray
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange[200], // Soft Orange
            ),
            child: Icon(
              isChat ? Icons.chat : Icons.mic,
              size: 30,
              color: Colors.orange[800], // Darker Orange for icon
            ),
          ),
          Expanded(
            child: Text(
              barText,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black, // Black text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_right_sharp,
            size: 30,
            color: Colors.black, // Black icon color
          ),
        ],
      ),
    );
  }
}

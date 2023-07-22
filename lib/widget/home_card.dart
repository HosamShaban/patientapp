import 'package:patientapp/Consts/colors.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String image;
  const HomeCard({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffEAEAEA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        const SizedBox(width: 180),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ConstColors.textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage("assets/images/doctor(1).png"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SizedBox(width: 15),
                    Text(
                      "0599999999",
                      style: TextStyle(
                        fontSize: 14,
                        color: ConstColors.text2Color,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.phone,
                      color: Color(0xff909090),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "غزة",
                      style: TextStyle(
                        fontSize: 14,
                        color: ConstColors.text2Color,
                      ),
                    ),
                    Icon(
                      Icons.home,
                      color: Color(0xff909090),
                      size: 25,
                    ),
                  ],
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

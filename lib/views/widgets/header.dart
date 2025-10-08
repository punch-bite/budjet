import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
        bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello!",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Text(
                "Prèt à controler vos dépenses?",
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 25),
          CircleAvatar(child: Image.asset("images/Person.png")),
        ],
      ),
    );
  }
}

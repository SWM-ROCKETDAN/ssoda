import 'package:flutter/material.dart';
import 'package:hashchecker_web/api.dart';
import 'package:hashchecker_web/constants.dart';

class HeaderWithReward extends StatelessWidget {
  const HeaderWithReward({
    Key? key,
    required this.size,
    required this.rewardImagePath,
  }) : super(key: key);

  final Size size;
  final rewardImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.4 + size.width * 0.25,
      child: Stack(children: [
        Container(
          width: size.width,
          height: size.height * 0.4,
          child: ClipRRect(
              child: Image.asset(
                'assets/images/confetti.png',
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(150))),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
            color: kThemeColor.withOpacity(0.22),
          ),
        ),
        Positioned(
          child: Card(
            child: Column(children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    '$s3Url$rewardImagePath',
                    fit: BoxFit.cover,
                    height: size.width * 0.5,
                    width: size.width * 0.5,
                  )),
            ]),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 12,
          ),
          bottom: 0,
          left: size.width * 0.25,
          right: size.width * 0.25,
        ),
        Positioned(
          bottom: size.width * 0.44,
          left: size.width * 0.425,
          right: size.width * 0.425,
          child: Container(
              height: size.width * 0.15,
              width: size.width * 0.15,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Colors.black.withOpacity(0.3))
                  ],
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/sample/storeLogo.jpg'),
                      fit: BoxFit.cover))),
        )
      ]),
    );
  }
}

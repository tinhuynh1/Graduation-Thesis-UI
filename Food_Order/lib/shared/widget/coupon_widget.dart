import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  //final double margin;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;

  const Ticket({
    Key key,
    //this.margin = 20,
    this.borderRadius = 10,
    this.clipRadius = 10,
    this.smallClipRadius = 3,
    this.numberOfSmallClips = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketWidth = MediaQuery.of(context).size.width;
    final ticketHeight = MediaQuery.of(context).size.height / 8.2;

    return Container(
      width: ticketWidth,
      height: ticketHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 37,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipPath(
        clipper: TicketClipper(
          borderRadius: borderRadius,
          clipRadius: clipRadius,
          smallClipRadius: smallClipRadius,
          numberOfSmallClips: numberOfSmallClips,
        ),
        child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.all(20),
                  child: ClipRect(
                    child: Image.asset(
                      'assets/logo_intro.jpg',
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  padding: EdgeInsets.only(top: 30, left: 20, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '- Ưu đãi 25% khi đặt Pick Up (tự đến lấy) từ 2 món ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        'Hạn sử dụng đến 30/11/2020',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  static const double clipPadding = 5;

  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;

  const TicketClipper({
    this.borderRadius,
    this.clipRadius,
    this.smallClipRadius,
    this.numberOfSmallClips,
  });

  @override
  Path getClip(Size size) {
    var path = Path();

    final clipCenterX = size.width * 0.25 + clipRadius;

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    final clipPath = Path();

    // circle on the top
    clipPath.addOval(Rect.fromCircle(
      center: Offset(clipCenterX, 0),
      radius: clipRadius,
    ));

    // circle on the bottom
    clipPath.addOval(Rect.fromCircle(
      center: Offset(clipCenterX, size.height),
      radius: clipRadius,
    ));

    // draw small clip circles
    final clipContainerSize = size.height - clipRadius * 2 - clipPadding * 2;
    final smallClipSize = smallClipRadius * 2;
    final smallClipBoxSize = clipContainerSize / numberOfSmallClips;
    final smallClipPadding = (smallClipBoxSize - smallClipSize) / 2;
    final smallClipStart = clipRadius + clipPadding;

    final smallClipCenterOffsets = List.generate(numberOfSmallClips, (index) {
      final boxX = smallClipStart + smallClipBoxSize * index;
      final centerY = boxX + smallClipPadding + smallClipRadius;

      return Offset(clipCenterX, centerY);
    });

    smallClipCenterOffsets.forEach((centerOffset) {
      clipPath.addOval(Rect.fromCircle(
        center: centerOffset,
        radius: smallClipRadius,
      ));
    });

    // combine two path together
    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper old) =>
      old.borderRadius != borderRadius ||
      old.clipRadius != clipRadius ||
      old.smallClipRadius != smallClipRadius ||
      old.numberOfSmallClips != numberOfSmallClips;
}

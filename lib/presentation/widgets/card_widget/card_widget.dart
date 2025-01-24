import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, this.imgUrl, this.title, this.artist});

  final imgUrl;
  final title;
  final artist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Color(0xfff3ffd3), Color(0xffa86cd9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 13),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[900]!),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 28),
            child: Column(
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/muoz.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  title ?? '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900]),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  artist ?? '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Tambahkan Google Fonts 💕

enum BubbleType {
  top,
  middle,
  bottom,
  alone,
}

enum Direction {
  left,
  right,
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.direction,
    required this.message,
    required this.type,
    this.photoUrl,
    this.backgroundColor = Colors.grey,
  });

  final Direction direction;
  final String message;
  final String? photoUrl;
  final BubbleType type;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isOnLeft = direction == Direction.left;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isOnLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isOnLeft) _buildLeading(type),
          SizedBox(width: isOnLeft ? 4 : 0),
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Efek 3D
              ..rotateX(isOnLeft ? -0.1 : 0.1) // Rotasi untuk efek 3D
              ..rotateY(isOnLeft ? -0.1 : 0.1), // Rotasi untuk efek 3D
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: _borderRadius(direction, type),
                gradient: LinearGradient(
                  colors: isOnLeft
                      ? [Colors.blue.shade700, Colors.purple.shade700] // Warna chat AI 💙💜
                      : [
                          const Color.fromARGB(255, 213, 196, 35),
                          Colors.pink.shade700
                        ], // Warna chat pengguna ✨
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: isOnLeft ? Colors.blue.shade800 : Colors.pink.shade800,
                  width: 2,
                ),
              ),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, Colors.white70],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    // Gunakan font Poppins ✨
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Warna teks lebih jelas 🌟
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeading(BubbleType type) {
    if (type == BubbleType.alone || type == BubbleType.bottom) {
      if (photoUrl != null) {
        return CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(photoUrl!),
        );
      }
    }
    return const SizedBox(width: 24);
  }

  BorderRadius _borderRadius(Direction dir, BubbleType type) {
    const radius1 = Radius.circular(20);
    const radius2 = Radius.circular(5);
    return switch (type) {
      BubbleType.top => dir == Direction.left
          ? const BorderRadius.only(
              topLeft: radius1,
              topRight: radius1,
              bottomLeft: radius2,
              bottomRight: radius1)
          : const BorderRadius.only(
              topLeft: radius1,
              topRight: radius1,
              bottomLeft: radius1,
              bottomRight: radius2),
      BubbleType.middle => BorderRadius.circular(5),
      BubbleType.bottom => BorderRadius.circular(20),
      BubbleType.alone => BorderRadius.circular(20),
    };
  }
}
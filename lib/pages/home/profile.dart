import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../login/google/google_auth.dart';
import 'widgets/chat_bubble.dart'; // Import ChatBubble

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey:
          'AIzaSyCemWq4HMckBt9903Ug6bunb2AQ7kJ0gC8'); // Ganti dengan API key Anda
  final messageController = TextEditingController();
  bool isLoading = false;
  bool isDarkMode = false;

  List<ChatBubble> messages = [
    const ChatBubble(
      direction: Direction.left,
      message: 'Halo, saya Gemini AI. Ada yang bisa saya bantu?',
      photoUrl: 'https://i.pravatar.cc/150?img=47',
      type: BubbleType.alone,
      backgroundColor: Colors.blueGrey,
    ),
  ];

  void sendMessage() async {
    if (messageController.text.isEmpty) return;
    setState(() => isLoading = true);

    messages.add(ChatBubble(
      direction: Direction.right,
      message: messageController.text,
      type: BubbleType.alone,
      backgroundColor: Colors.blueAccent,
    ));

    try {
      final response =
          await model.generateContent([Content.text(messageController.text)]);
      messages.add(ChatBubble(
        direction: Direction.left,
        message: response.text ?? 'Tidak dapat memproses pesan',
        photoUrl: 'https://i.pravatar.cc/150?img=47',
        type: BubbleType.alone,
        backgroundColor: Colors.blueGrey,
      ));
    } catch (_) {
      messages.add(const ChatBubble(
        direction: Direction.left,
        message: 'Terjadi kesalahan',
        photoUrl: 'https://i.pravatar.cc/150?img=47',
        type: BubbleType.alone,
        backgroundColor: Colors.red,
      ));
    }

    messageController.clear();
    setState(() => isLoading = false);
  }

  void deleteAllMessages() {
    setState(() {
      messages = [
        const ChatBubble(
          direction: Direction.left,
          message: 'Halo, saya Gemini AI. Ada yang bisa saya bantu?',
          photoUrl: 'https://i.pravatar.cc/150?img=47',
          type: BubbleType.alone,
          backgroundColor: Colors.blueGrey,
        ),
      ];
    });
  }

  // 🔹 FUNGSI LOGOUT
  Future<void> _handleLogout() async {
    try {
      final firebaseServices = FirebaseServices();
      await firebaseServices.googleSignOut();
      if (mounted) {
        await Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint('Error during logout: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal logout: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                ),
              )
            : ThemeData.light().copyWith(
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                ),
              ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Gemini AI ✨',
                style: TextStyle(color: Colors.white)),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade800, Colors.purple.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_6, color: Colors.white),
                onPressed: () => setState(() => isDarkMode = !isDarkMode),
                tooltip: 'Toggle Theme',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Hapus Chat'),
                      content: const Text(
                          'Apakah Anda yakin ingin menghapus semua pesan?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteAllMessages();
                            Navigator.pop(context);
                          },
                          child: const Text('Hapus'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Hapus Chat',
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Apakah Anda yakin ingin keluar?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _handleLogout();
                          },
                          child: const Text('Keluar'),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Logout',
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [Colors.black, Colors.grey.shade900]
                    : [Colors.blue.shade100, Colors.purple.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    reverse: true,
                    padding: const EdgeInsets.all(10),
                    children: messages.reversed.toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: isDarkMode
                                  ? [Colors.grey.shade800, Colors.grey.shade900]
                                  : [Colors.white, Colors.grey.shade200],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.grey.shade700,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blue.shade800, Colors.purple.shade800],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.send, color: Colors.white),
                                onPressed: sendMessage,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
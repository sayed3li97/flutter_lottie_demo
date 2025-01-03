import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottie Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  late final AnimationController _likeController;
  bool isLiked = false;
  bool _likeLottieLoaded = false;
  bool _thanksLottieLoaded = false;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Lottie Animations'),
        elevation: 0,
        backgroundColor: const Color(0xFF64B5F6),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Conditional Center Animation
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isLiked // Show different animation based on like state
                    ? Column(
                  children: [
                    Lottie.asset(
                      'assets/animations/thanks.json', // Thanks animation
                      width: 120,
                      height: 120,
                      onLoaded: (composition) {
                        setState(() {
                          _thanksLottieLoaded = true;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Thank You!',
                      style: TextStyle(
                          fontSize: 18, color: Colors.green[700]),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    Lottie.asset(
                      'assets/animations/loading.json', // Loading animation
                      width: 120,
                      height: 120,
                      repeat: true,
                      onLoaded: (composition) {
                        setState(() {
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading...',
                      style: TextStyle(
                          fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),

            // Enhanced Like Button (Animation on the Left)
            InkWell(
              onTap: () {
                setState(() {
                  isLiked = !isLiked;
                  if (isLiked && _likeLottieLoaded) {
                    _likeController.forward().whenComplete(() => _likeController.reset());
                  } else if (isLiked && !_likeLottieLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Animation is still loading")));
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isLiked
                          ? const Color.fromARGB(255, 172, 235, 175)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/like.json',
                        controller: _likeController,
                        width: 40,
                        height: 40,
                        onLoaded: (composition) {
                          setState(() {
                            _likeLottieLoaded = true;
                            _likeController.duration = composition.duration;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isLiked ? 'Liked' : 'Like',
                        style: TextStyle(
                            color: isLiked
                                ? Colors.green[800]
                                : Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
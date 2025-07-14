import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/components/color.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:lottie/lottie.dart';

class KvadratQasri extends StatefulWidget {
  final VoidCallback? onComplete;
  const KvadratQasri({this.onComplete, super.key});

  @override
  State<KvadratQasri> createState() => _KvadratQasriState();
}

class _KvadratQasriState extends State<KvadratQasri> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  LottieComposition? _firstComposition;
  LottieComposition? _loopingComposition;
  bool _showFirstAnimation = true;

  double previousProgress = 0.0;
  late Future<void> _loadStateFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _loadAnimations();
    _loadStateFuture = _loadGameState(); // 🔄 wait for Firestore values
  }

  Future<void> _loadGameState() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await GameState.loadState(userId);
    }
  }

  Future<void> _loadAnimations() async {
    final first = await AssetLottie('assets/animations/MrSquareCastle1.json').load();
    final looping = await AssetLottie('assets/animations/MrSquareCastle2.json').load();

    setState(() {
      _firstComposition = first;
      _loopingComposition = looping;

      _controller
        ..duration = _firstComposition!.duration
        ..forward();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _showFirstAnimation) {
        setState(() {
          _showFirstAnimation = false;
        });
        _controller
          ..reset()
          ..repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadStateFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        return _buildMainContent(context);
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double currentProgress = GameState.currentXP / GameState.maxXP;

    // Update previousProgress and trigger onComplete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (previousProgress != currentProgress) {
          setState(() {
            previousProgress = currentProgress;
          });
        }

        if (currentProgress >= 1.0) {
          widget.onComplete?.call();
        }
      }
    });

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.4,
          child: Center(
            child: _firstComposition == null || _loopingComposition == null
                ? const CircularProgressIndicator()
                : Lottie(
                    composition: _showFirstAnimation ? _firstComposition : _loopingComposition,
                    controller: _controller,
                    repeat: !_showFirstAnimation,
                  ),
          ),
        ),
        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: previousProgress, end: currentProgress),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              double barWidth = screenWidth * 0.85;
              int segments = 10;
              double filledWidth = barWidth * value.clamp(0.0, 1.0);

              return Center(
                child: SizedBox(
                  width: barWidth,
                  height: 20,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: greyColor,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: filledWidth,
                            decoration: BoxDecoration(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(segments - 1, (i) {
                        double left = (barWidth / segments) * (i + 1);
                        return Positioned(
                          left: left - 0.75,
                          top: 2,
                          bottom: 2,
                          child: Container(
                            width: 1.5,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


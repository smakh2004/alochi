import 'package:alochi_math_app/components/color.dart';
import 'package:flutter/material.dart';
import 'package:alochi_math_app/pages/GameState.dart';
import 'package:lottie/lottie.dart';

class UchburchakPiramidasi extends StatefulWidget {
  final VoidCallback? onComplete;
  const UchburchakPiramidasi({this.onComplete, super.key});

  @override
  State<UchburchakPiramidasi> createState() => _UchburchakPiramidasiState();
}

class _UchburchakPiramidasiState extends State<UchburchakPiramidasi> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  LottieComposition? _firstComposition;
  LottieComposition? _loopingComposition;
  bool _showFirstAnimation = true;

  double previousProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _loadAnimations();

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

  Future<void> _loadAnimations() async {
    final first = await AssetLottie('assets/animations/MrTriangleCastle1.json').load();
    final looping = await AssetLottie('assets/animations/MrTriangleCastle2.json').load();

    setState(() {
      _firstComposition = first;
      _loopingComposition = looping;

      _controller
        ..duration = _firstComposition!.duration
        ..forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double currentProgress = GameState.currentXP2 / GameState.maxXP2;

    // Update previousProgress only after rendering
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
          height: screenHeight * 0.37,
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

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: previousProgress, end: currentProgress),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              double barWidth = screenWidth * 0.75;
              int segments = 10;
              double filledWidth = barWidth * value.clamp(0.0, 1.0);

              return Center(
                child: SizedBox(
                  width: barWidth,
                  height: 16,
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
                              color: primaryRedd,
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(segments - 1, (i) {
                        double left = (barWidth / segments) * (i + 1);
                        return Positioned(
                          left: left - 0.75,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 2,
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

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PARTICLES BACKGROUND
// Animated floating particles for the hero section
// ─────────────────────────────────────────────────────────────────────────────

class ParticlesBackground extends StatefulWidget {
  const ParticlesBackground({super.key});

  @override
  State<ParticlesBackground> createState() => _ParticlesBackgroundState();
}

class _ParticlesBackgroundState extends State<ParticlesBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final _random = math.Random(42); // Fixed seed for consistent appearance

  @override
  void initState() {
    super.initState();
    _particles = List.generate(50, (_) => _Particle(_random));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _ParticlesPainter(
            particles: _particles,
            progress: _controller.value,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _Particle {
  _Particle(math.Random random)
      : x = random.nextDouble(),
        y = random.nextDouble(),
        size = random.nextDouble() * 2.5 + 0.5,
        speedX = (random.nextDouble() - 0.5) * 0.15,
        speedY = (random.nextDouble() - 0.5) * 0.1,
        opacity = random.nextDouble() * 0.5 + 0.1;

  final double x;
  final double y;
  final double size;
  final double speedX;
  final double speedY;
  final double opacity;
}

class _ParticlesPainter extends CustomPainter {
  _ParticlesPainter({
    required this.particles,
    required this.progress,
  });

  final List<_Particle> particles;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // Calculate position with wraparound
      final x = ((particle.x + particle.speedX * progress * 100) % 1.0) * size.width;
      final y = ((particle.y + particle.speedY * progress * 100) % 1.0) * size.height;

      // Draw particle dot
      final paint = Paint()
        ..color = AppColors.accent.withOpacity(particle.opacity * 0.6)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }

    // Draw subtle connection lines
    final linePaint = Paint()
      ..color = AppColors.accent.withOpacity(0.04)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < particles.length; i++) {
      final xi = ((particles[i].x + particles[i].speedX * progress * 100) % 1.0) * size.width;
      final yi = ((particles[i].y + particles[i].speedY * progress * 100) % 1.0) * size.height;

      for (int j = i + 1; j < particles.length; j++) {
        final xj = ((particles[j].x + particles[j].speedX * progress * 100) % 1.0) * size.width;
        final yj = ((particles[j].y + particles[j].speedY * progress * 100) % 1.0) * size.height;

        final distance = math.sqrt(math.pow(xi - xj, 2) + math.pow(yi - yj, 2));
        if (distance < 120) {
          canvas.drawLine(Offset(xi, yi), Offset(xj, yj), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

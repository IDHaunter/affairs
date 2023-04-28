import '../../core/common_export.dart';

//Рисователь круга (или чего угодно) -------------------------------------------------------------------------
class CirclePainter extends CustomPainter {
  final warningPaint = Paint()
    ..color = curITheme.failure() //Color(0xff63aa65)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(0, 0), size.width, warningPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CirclePaint extends StatelessWidget {
  final double radius;
  const CirclePaint({Key? key, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: radius, height: radius, child: CustomPaint(painter: CirclePainter(),));
  }
}


//Реализация вечной анимации мигания -------------------------------------------------------------------------
class AnimatedCircle extends StatefulWidget {
  final double radius;
  const AnimatedCircle({Key? key, required this.radius}) : super(key: key);

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle> with TickerProviderStateMixin {
  //создаём контроллер
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )
    ..repeat(reverse: true); //Этот параметр означает вечное повторение с реверсом
  //создаём анимацию с использованием созданного контроллера
  late final Animation<double> _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  void dispose() {
    //Не забываем уничтожать контроллер
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: CirclePaint(radius: widget.radius),
      ),
    );
  }
}

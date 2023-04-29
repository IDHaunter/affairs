import '../../core/common_export.dart';

//Рисователь круга (или чего угодно) -------------------------------------------------------------------------
class CirclePainter extends CustomPainter {
  final Color instanceColor;
  CirclePainter({required this.instanceColor});

  @override
  void paint(Canvas canvas, Size size) {
    final customPaint = Paint()
      ..color =  instanceColor //curITheme.failure() //Color(0xff63aa65)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(0, 0), size.width, customPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CirclePaint extends StatelessWidget {
  final double radius;
  final Color instanceColor;
  const CirclePaint({Key? key, required this.radius, required this.instanceColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: radius, height: radius, child: CustomPaint(painter: CirclePainter(instanceColor: instanceColor),));
  }
}


//Реализация вечной анимации мигания -------------------------------------------------------------------------
class AnimatedFading extends StatefulWidget {
  final Widget customWidget;
  const AnimatedFading({Key? key, required this.customWidget, }) : super(key: key);

  @override
  State<AnimatedFading> createState() => _AnimatedFadingState();
}

class _AnimatedFadingState extends State<AnimatedFading> with TickerProviderStateMixin {
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
        child: widget.customWidget,
      ),
    );
  }
}

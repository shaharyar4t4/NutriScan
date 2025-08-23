import 'package:nutriscan/core/constants/app_linker.dart';

class NavBarController extends State<StatefulWidget>
    with ChangeNotifier, SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  int selectedIndex = 0;

  final TickerProvider vsync;

  NavBarController({required this.vsync}) {
    animationController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward();
  }

  void disposeController() {
    animationController.dispose();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    animationController.reset();
    animationController.forward();
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
  }

  @override
  DiagnosticsNode toDiagnosticsNode(
      {String? name, DiagnosticsTreeStyle? style}) {
    // TODO: implement toDiagnosticsNode
    throw UnimplementedError();
  }

  @override
  String toStringShort() {
    // TODO: implement toStringShort
    throw UnimplementedError();
  }

  @override
  // TODO: implement widget
  StatefulWidget get widget => throw UnimplementedError();
}

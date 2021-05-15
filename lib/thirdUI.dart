import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThirdUI extends StatefulWidget {
  @override
  _ThirdUIState createState() => _ThirdUIState();
}

class _ThirdUIState extends State<ThirdUI> {
  List<String> questions = [
    "Who is PM of india",
    "Who is The CM of Uttar pradesh",
    "Who is the President of india",
    "Choose Greatest Number"
  ];

  List<List<String>> options = [
    ["YOGI", "MODI", "AMBANI", "RamNath"],
    ["MODI", "YOGI", "AMBANI", "RamNath"],
    ["AMIT SAH", "MODI", "AMBANI", "RamNath"],
    ["10", "23", "9", "81"]
  ];

  List<int> answer = [2, 2, 4, 4];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                ArrowIcon(),
                Plane(),
                Line(),
                //Page()
              ],
            ),
          )),
    );
  }
}

//arrow icon
class ArrowIcon extends StatefulWidget {
  @override
  _ArrowIconState createState() => _ArrowIconState();
}

class _ArrowIconState extends State<ArrowIcon> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.arrow_upward),
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.arrow_downward),
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

//plane
class Plane extends StatefulWidget {
  final int state;
  Plane({this.state = 0});
  @override
  _PlaneState createState() => _PlaneState();
}

class _PlaneState extends State<Plane> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  double left = 100;
  double top = 100;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40,
      top: 52,
      child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.airplanemode_active,
            size: 64,
            color: Colors.white,
          )),
    );
  }
}

//line
class Line extends StatefulWidget {
  @override
  _LineState createState() => _LineState();
}

class _LineState extends State<Line> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40.0 + 32,
      top: 60,
      bottom: 0,
      width: 1,
      child: Container(
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}

//page
class Page extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;
  final VoidCallback onOptionSelected;
  const Page(
      {Key key,
      @required this.number,
      @required this.answers,
      @required this.question,
      @required this.onOptionSelected});
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  List<GlobalKey<_ItemFaderState>> keys;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keys = List.generate(5, (_) => GlobalKey<_ItemFaderState>());
    onInit();
  }

  onInit() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.show();
    }
  }

  onTap() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
    }
    widget.onOptionSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32,
        ),
        ItemFader(
          key: keys[0],
          child: StepNumber(
            number: widget.number,
          ),
        ),
        ItemFader(
          key: keys[1],
          child: StepQuestion(
            question: widget.question,
          ),
        ),
        Spacer(),
        // ...Widget.answers.map((String answer) {
        //   int answerIndex = widget.answers.indexOf(answer);
        //   int keyIndex = answerIndex + 2;
        //   return ItemFader(
        //     key: keys[keyIndex],
        //     child: OptionItem(name: answer, onTap: widget.onOptionSelected),
        //   );
        // }),
        SizedBox(
          height: 54,
        )
      ],
    );
  }
}

class StepNumber extends StatefulWidget {
  final int number;
  StepNumber({this.number});
  @override
  _StepNumberState createState() => _StepNumberState();
}

class _StepNumberState extends State<StepNumber> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class StepQuestion extends StatefulWidget {
  final String question;
  StepQuestion({this.question});
  @override
  _StepQuestionState createState() => _StepQuestionState();
}

class _StepQuestionState extends State<StepQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//option Item
class OptionItem extends StatefulWidget {
  final Function onTap;
  final String name;

  const OptionItem({Key key, @required this.onTap, @required this.name});

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RenderBox object = context.findRenderObject();
        Offset globalPosition = object.localToGlobal(Offset.zero);
        widget.onTap(globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SizedBox(
              height: 26,
            ),
            Dot(),
            SizedBox(
              height: 26,
            ),
            Expanded(
              child: Text(widget.name),
            )
          ],
        ),
      ),
    );
  }
}

//item fader
class ItemFader extends StatefulWidget {
  final Widget child;

  const ItemFader({@required this.child, Key key});
  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  int position = 1; //
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: widget.child,
        builder: (context, child) => Transform.translate(
              offset: Offset(0, 64 * position * (1 - controller.value)),
              child: Opacity(
                opacity: controller.value,
                child: child,
              ),
            ));
  }

  void show() {
    setState(() {
      position = 1;
    });
    controller.forward();
  }

  void hide() {
    setState(() {
      position = -1;
    });
    controller.reverse();
  }
}

class Dot extends StatefulWidget {
  @override
  _DotState createState() => _DotState();
}

class _DotState extends State<Dot> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*


Future<void> animateDot(Offset offset) async {
    OverlayEntry entry = OverlayEntry(builder: (context) {
      double minTop = MediaQuery.of(context).padding.top + 52;
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Positioned(
          left: 76,
          top: minTop + (offset.dy - minTop) * (1 - controller.value),
          child: child,
        ),
        child: Dot(),
      );
    });
    Overlay.of(context).insert(entry);
    await controller.forward(from: 0);
    entry.remove();
  }
  */

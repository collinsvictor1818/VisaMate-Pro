import 'package:flutter/material.dart';

class BuildList extends StatefulWidget {
  final BuildContext? context; // Pass BuildContext as a parameter
  final String? title;
  final String? desc;
  final IconData? icon;
  final VoidCallback? onClicked;
  final bool isSelected;
  final Function(bool, String?) onSelectionChange;

  const BuildList({
    Key? key,
    this.context, // Pass BuildContext as a parameter
    this.title,
    this.desc,
    this.icon,
    this.onClicked,
    required this.isSelected,
    required this.onSelectionChange,
  }) : super(key: key);

  @override
  State<BuildList> createState() => _buildListState();
}

class _buildListState extends State<BuildList> {
  @override
  void initState() {
    super.initState();
    _choiceController = TextEditingController();
  }

  @override
  void dispose() {
    _choiceController.dispose();
    super.dispose();
  }

  late TextEditingController _choiceController;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 5)
          .add(const EdgeInsets.symmetric(horizontal: 5)),
      // padding: EdgeInsets.symmetric(horizontal: 15),
      child: PhysicalModel(
        clipBehavior: Clip.none,
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        child: Center(
          child: Container(
              height: 68,
              child: ListTile(
                  dense: true,
                  leading: Transform.translate(
                      offset: Offset(0, 0),
                      child: Icon(widget.icon,
                          color: Theme.of(context).colorScheme.tertiary)),
                  title: Transform.translate(
                      offset: Offset(-10, 2),
                      child: Text(
                        '${widget.title}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontFamily: 'Gilmer',
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )),
                  subtitle: Transform.translate(
                      offset: Offset(-10, -2),
                      child: Text(
                        '${widget.desc}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: 'Gilmer',
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )),
                  // trailing: Transform.translate(
                  //   offset: Offset(10, 0),
                  //   child: IconButton(
                  //       icon: Icon(Icons.chevron_right_rounded),
                  //       iconSize: 25,
                  //       onPressed: widget.onClicked),
                  // ),
                  trailing:  Checkbox(
                          visualDensity: VisualDensity.compact,
                          checkColor: Theme.of(context).colorScheme.tertiary,
                          value: widget.isSelected,
                          onChanged: (bool? newValue) {
                            setState(() {
                                ;
                            });
                          },
                        ),
                  onTap: widget.onClicked)),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CustomDropdownButtonAlign { top, bottom, center }

class CustomDropdownButton<T> extends StatefulWidget {
  ///a hint widget is used when the value is null
  final Widget? hint;

  ///the list items
  ///must be of type[CustomDropdownButtonItem]
  final List<CustomDropdownButtonItem<T>> items;

  /// a dynamic variable which represent the current value of the bottom
  final T? value;

  ///called when the user select an item from the list
  final void Function(T) onChange;

  ///called when the user press the button
  final void Function()? onTap;

  ///a widget used to separate the list items
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  ///the color used for the list
  ///if this is null will tke the same value from the button color
  final Color? listColor;

  /// the color used for the button
  final Color buttonColor;

  ///the duration of the animation used to open and close the list
  final int animationDurationInMilliseconds;

  /// the trailing button icon
  final Widget? icon;

  ///the maximum height that the list must has
  ///if null the list will take the same height of [items.length * button height]
  final double? maxHeight;

  ///the align of the list respect the button
  final CustomDropdownButtonAlign align;

  ///the button height
  final double? height;

  ///the button width without calculating the width of the icon
  final double? width;

  ///the animation curve
  final Curve curves;

  ///the button content padding
  final EdgeInsets padding;

  ///this radius is used for both the button and the list
  final double borderRadius;

  ///this list os used only for the list shadow
  final List<BoxShadow> listShadow;

  ///this parameter consider wither the main button will disappear when the list open or not
  final bool hide;

  ///this parameter will create a border on the button and the list,
  ///so for better look please make sure that tha [hide] is set to true
  final Border? border;

  const CustomDropdownButton({
    Key? key,
    this.hint,
    required this.items,
    this.value,
    required this.onChange,
    this.onTap,
    this.separatorBuilder,
    this.listColor,
    this.buttonColor = const Color.fromRGBO(247, 248, 249, 1),
    this.animationDurationInMilliseconds = 400,
    this.icon,
    this.maxHeight,
    this.align = CustomDropdownButtonAlign.bottom,
    this.height,
    this.width,
    this.curves = Curves.decelerate,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.borderRadius = 10,
    this.listShadow = const <BoxShadow>[],
    this.hide = false,
    this.border,
  }) : super(key: key);
  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  ///creating a global key for the button to get its height, width, x position and y position
  GlobalKey key = LabeledGlobalKey("button");

  ///creating the selected item widget
  Container item = Container();

  ///creating an overlay entry to insert a new layer to hod the list
  late OverlayEntry _listOverLay;

  ///we gonna use this variable to know wether ot's open or not
  bool _isOpen = false;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  ///in this function we are setting the value of the button item
  void getSelectedWidget() {
    //checking if the value is not null
    if (widget.value != null) {
      //looping into all the items to get the right item
      bool found = false;
      for (CustomDropdownButtonItem<T> element in widget.items) {
        //comparing the value of the item by the giving item
        if (element.value == widget.value) {
          item = Container(
            child: element,
          );
          found = true;
          return;
        }
      }
      if (!found) {
        throw "There must be an item with the giving value";
      }
    } else {
      //setting the item to the hint value
      item = Container(child: widget.hint);
    }
  }

  ///in this function we are adding a new layer which has the items list
  void showDropdownList({
    ///the width of the list
    required double width,

    ///the height pf the entire list
    required double height,

    ///the height of a single item
    required double itemHeight,

    ///the list x position
    required double xPosition,

    /// the list y position
    required double yPosition,
  }) async {
    ScrollController controller = ScrollController(
        initialScrollOffset: widget.items
                .indexWhere((CustomDropdownButtonItem<T> element) =>
                    element.value == widget.value)
                .toDouble() *
            itemHeight);

    //creating the new layer
    _listOverLay = OverlayEntry(
      builder: (_) {
        //we are creating a stack to close the list when the user click out of the list
        return Stack(
          children: <Widget>[
            //creating a gesture detector with the entire screen size to close the list
            GestureDetector(
              onTap: () async {
                //rotating the button icon
                setState(() {
                  _isOpen = false;
                });
                //rebuilding the layer to animate the list when close
                _listOverLay.markNeedsBuild();
                //waiting until the animation complete
                // ignore: always_specify_types
                await Future.delayed(
                  Duration(
                    milliseconds: widget.animationDurationInMilliseconds,
                  ),
                );
                //removing the layer
                _listOverLay.remove();
              },
              //creating a container to fill all the screen size
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            //positioning and defining the size of the list
            Positioned(
              width: width,
              height: height,
              left: xPosition,
              top: yPosition,
              //creating a tween animation to animate the list when open/close
              child: TweenAnimationBuilder<double>(
                //assigning the list animation curve
                curve: widget.curves,
                //defining the list tween values
                tween: Tween<double>(
                  begin: _isOpen ? 0 : height,
                  end: !_isOpen ? 0 : height,
                ),
                //defining the animation duration
                duration: Duration(
                    milliseconds: widget.animationDurationInMilliseconds),
                builder: (BuildContext ctx, double value, Widget? child) {
                  return Column(
                    //positioning the start animation point
                    mainAxisAlignment:
                        widget.align == CustomDropdownButtonAlign.bottom
                            ? MainAxisAlignment.start
                            : widget.align == CustomDropdownButtonAlign.center
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //creating a container to control the list
                      Container(
                        //giving the tween value to the container height
                        height: value,
                        //decorating the list
                        decoration: BoxDecoration(
                          color: widget.listColor ?? widget.buttonColor,
                          borderRadius: widget.hide
                              ? BorderRadius.circular(widget.borderRadius)
                              : widget.align == CustomDropdownButtonAlign.bottom
                                  ? BorderRadius.vertical(
                                      bottom: Radius.circular(
                                        widget.borderRadius,
                                      ),
                                    )
                                  : widget.align ==
                                          CustomDropdownButtonAlign.top
                                      ? BorderRadius.vertical(
                                          top: Radius.circular(
                                            widget.borderRadius,
                                          ),
                                        )
                                      : BorderRadius.circular(
                                          widget.borderRadius),
                          boxShadow: widget.listShadow,
                          border: widget.border,
                        ),
                        padding: widget.padding,
                        alignment: Alignment.center,
                        //creating the items list
                        child: ListView.separated(
                          //adding a zero padding to the list
                          padding: EdgeInsets.zero,
                          controller: controller,
                          //building the list
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                //rebuilding the layer to animate the list when close
                                _listOverLay.markNeedsBuild();
                                //rotating the button icon
                                setState(() {
                                  _isOpen = false;
                                });
                                //waiting until the animation complete
                                // ignore: always_specify_types
                                await Future.delayed(
                                  Duration(
                                    milliseconds:
                                        widget.animationDurationInMilliseconds,
                                  ),
                                );
                                //removing the layer
                                _listOverLay.remove();
                                //getting the item value
                                dynamic value = widget.items[index].value;
                                //calling the on change method with the given value
                                widget.onChange(value);
                              },
                              child: Container(
                                color: Colors.transparent,
                                width: double.infinity,
                                height: itemHeight,
                                alignment: Alignment.centerLeft,
                                child: widget.items[index],
                              ),
                            );
                          },
                          //creating a separator widget between each item
                          separatorBuilder: widget.separatorBuilder == null
                              ? (BuildContext context, int index) {
                                  return Container();
                                }
                              : widget.separatorBuilder!,
                          itemCount: widget.items.length,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
    //inserting the new layer to the widget tree
    Overlay.of(context)!.insert(_listOverLay);
  }

  @override
  Widget build(BuildContext context) {
    //initializing the button item
    getSelectedWidget();
    return Opacity(
      opacity: widget.items.isNotEmpty ? 1 : 0.5,
      child: GestureDetector(
        onTap: widget.items.isNotEmpty
            ? () {
                FocusScope.of(context).unfocus();
                //executing the on tap function
                (widget.onTap ?? () {})();
                //starting the calculation for the new layer
                if (key.currentContext != null) {
                  //declaring the single item height
                  final double singleHeight = key.currentContext!.size!.height;
                  //calculating the total list height
                  final double totalHeigh =
                      //checking if the user had inserted a max height for the list and
                      //the list require a more height or not
                      widget.maxHeight != null &&
                              key.currentContext!.size!.height *
                                      widget.items.length >
                                  widget.maxHeight!
                          ?
                          //in case its true we will assign the user height to the total height variable
                          widget.maxHeight!
                          :
                          //checking if the list require a height greater than the screen size
                          key.currentContext!.size!.height *
                                      widget.items.length >
                                  MediaQuery.of(context).size.height - 20
                              ?
                              //in this case we will only get the screen size
                              MediaQuery.of(context).size.height
                              :
                              //otherwise we will give the list the height it need
                              singleHeight * widget.items.length +
                                  widget.padding.top +
                                  widget.padding.bottom;
                  //declaring the list width
                  double width = key.currentContext!.size!.width;
                  //getting the render box from the button global key to get its x, y positions
                  RenderBox render =
                      key.currentContext!.findRenderObject() as RenderBox;
                  //saving the button x position (the horizontal position)
                  double xPosition = render.localToGlobal(Offset.zero).dx;
                  //saving the button y position (vertical position)
                  double yPosition = render.localToGlobal(Offset.zero).dy;
                  if (!widget.hide) {
                    switch (widget.align) {
                      case CustomDropdownButtonAlign.bottom:
                        //the y position can be the same
                        double equation = widget.hide
                            ? widget.borderRadius
                            : singleHeight -
                                widget.borderRadius +
                                widget.padding.bottom;
                        //checking if the list will het the bottom or not
                        if (yPosition + equation + totalHeigh >
                            MediaQuery.of(context).size.height - 20) {
                          //if true we will start avoiding a 20 dx from the bottom
                          yPosition =
                              MediaQuery.of(context).size.height - totalHeigh;
                        } else {
                          //saving the same value
                          yPosition += equation;
                        }
                        break;
                      case CustomDropdownButtonAlign.top:
                        //calculating the initial point from the bottom top position
                        double equationResult = widget.hide
                            ? widget.borderRadius - totalHeigh
                            : yPosition - totalHeigh + widget.borderRadius;
                        yPosition = equationResult >= 20 ? equationResult : 20;
                        break;
                      case CustomDropdownButtonAlign.center:
                        double equationResult = yPosition +
                            (singleHeight + 20) / 2 -
                            totalHeigh / 2;
                        yPosition = equationResult >= 0
                            ? yPosition + equationResult + totalHeigh >
                                    MediaQuery.of(context).size.height - 20
                                ? equationResult
                                : MediaQuery.of(context).size.height - 0
                            : 0;
                        break;
                    }
                  }
                  setState(() {
                    _isOpen = true;
                  });
                  //showing up the list in new layer
                  showDropdownList(
                    width: width,
                    height: totalHeigh,
                    itemHeight: singleHeight,
                    xPosition: xPosition,
                    yPosition: yPosition,
                  );
                }
              }
            : () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "no-items-to-show".tr,
                    textScaleFactor: 1,
                  ),
                ));
              },
        child: WillPopScope(
          onWillPop: () async {
            if (_isOpen) {
              //removing the layer
              _listOverLay.remove();
              //rotating the button icon
              setState(() {
                _isOpen = false;
              });
            }
            return true;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedOpacity(
                opacity: widget.hide
                    ? _isOpen
                        ? 0
                        : 1
                    : 1,
                duration: Duration(
                    milliseconds: widget.animationDurationInMilliseconds),
                curve: Curves.bounceIn,
                child: Container(
                  key: key,
                  height: widget.height,
                  width: widget.width,
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: widget.buttonColor,
                    borderRadius: _isOpen
                        ? BorderRadius.vertical(
                            top: Radius.circular(
                              widget.borderRadius,
                            ),
                          )
                        : BorderRadius.circular(
                            widget.borderRadius,
                          ),
                    boxShadow: widget.listShadow,
                    border: widget.border,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Opacity(
                          opacity: _isOpen ? 0.7 : 1,
                          child: item,
                        ),
                      ),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: _isOpen ? 0 : pi, end: !_isOpen ? 0 : pi),
                        duration: Duration(
                            milliseconds:
                                widget.animationDurationInMilliseconds),
                        builder:
                            (BuildContext ctx, double value, Widget? child) =>
                                Transform.rotate(
                          angle: value,
                          child: widget.icon ??
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDropdownButtonItem<T> extends StatelessWidget {
  final T value;
  final Widget child;
  final void Function()? onTap;

  const CustomDropdownButtonItem(
      {Key? key, required this.value, this.onTap, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        key: key,
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_app/modules/item/cubit/cubit.dart';
import 'package:warehouse_app/modules/item/cubit/states.dart';
import 'package:warehouse_app/modules/item/navbar_item.dart';
import 'package:warehouse_app/shared/components/components.dart';
import 'package:warehouse_app/styles/icon_broken.dart';

import 'comment_form.dart';


class ItemScreen extends StatefulWidget {
  final String name;
  final String statue;
  final String image;
  final String details;
  final String sheet;
  final int id;

  const ItemScreen(
      {super.key,
      required this.name,
      required this.statue,
      required this.image,
      required this.details,
      required this.sheet,
      required this.id});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final GlobalKey _commentBuilderKey = GlobalKey();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _jobNameController = TextEditingController();
  final TextEditingController _workOrderController = TextEditingController();
  final TextEditingController _estimatedCheckoutDateController =
      TextEditingController();
  final TextEditingController _estimatedCheckinDateController =
      TextEditingController();

  final FocusNode _commentFocus = FocusNode();
  late FocusAttachment _focusAttachment;


  @override
  void initState() {
    super.initState();
    _focusAttachment = _commentFocus.attach(context);
    // Add a listener to the focus node
    _commentFocus.addListener(() {
      _commentBuilderKey.currentState?.setState(() {
        
      });;
    });
  }

  @override
  void dispose() {
    _focusAttachment.detach();
    _commentController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }

  void submitComment() {
    // Handle the comment submission logic here
    _commentFocus.unfocus();
    debugPrint('Comment submitted: ${_commentController.text}');
    // Clear the comment field after submission
    _commentController.clear();
  }

  String? dropdownValue = 'Assign';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit(),
      child: BlocConsumer<ItemCubit, ItemStates>(
        listener: (context, state) {
          if (state is ItemCheckoutSuccessState) {
            toast(
                context: context,
                message: state.message,
                state: ToastState.success);
          }
        },
        builder: (context, state) {
          final GlobalKey<ScaffoldState> scaffoldKey =
              GlobalKey<ScaffoldState>();

          ItemCubit cubit = ItemCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.name,
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle!
                          .copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  IconBroken.arrowLeft_2,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image(image: NetworkImage(widget.image)),
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color.fromRGBO(0, 226, 91, 1),
                          radius: 7,
                        ),
                        const SizedBox(width: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Item state : ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.black),
                              ),
                              TextSpan(
                                text: widget.statue,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        NavBarItem(
                          index: 0,
                          currentNavIndex: cubit.currentNavIndex,
                          onTap: cubit.changBottomNavIndex,
                          title: "Sheet",
                        ),
                        NavBarItem(
                          index: 1,
                          currentNavIndex: cubit.currentNavIndex,
                          onTap: cubit.changBottomNavIndex,
                          title: "Details",
                        ),
                        //TODO: Handle comments section
                        /*
                          wrap coments with inkwell to open user page

                         */
                        NavBarItem(
                          index: 2,
                          currentNavIndex: cubit.currentNavIndex,
                          onTap: cubit.changBottomNavIndex,
                          title: "Comment",
                        ),
                      ],
                    ),
                    //Comments screen
                    if (cubit.currentNavIndex == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.sheet),
                      )
                    else if (cubit.currentNavIndex == 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.details),
                      )
                    else if (cubit.currentNavIndex == 2)
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          //TODO: add list comments
                          child: Column(
                            children: [Text("username")],
                          )),
                    if (cubit.currentNavIndex == 2)
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                                height: 60,
                                width: double.infinity,
                                child: CommentField(
                                  key: _commentBuilderKey,
                                  commentController: _commentController,
                                  commentFocus: _commentFocus,
                                  submitComment: submitComment,),
                            )],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: DefaultButton(
                              child: const Text(
                                "Check out",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              //TODO:
                              /*
                              chick out
                              ظبط بس الحاجات و المحتاجات

                               */
                              onPressed: () =>
                                  scaffoldKey.currentState!.showBottomSheet(
                                (context) => StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 5,
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(40.0),
                                          topRight: Radius.circular(40.0),
                                        ),
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Container(
                                                  height: 3,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Check out",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  left: 15.0,
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "choose:",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15.0,
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                          0.08,
                                                        ),
                                                        spreadRadius: 7,
                                                        blurRadius: 10,
                                                        offset: const Offset(
                                                          0,
                                                          3,
                                                        ),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    value: dropdownValue,
                                                    underline: Container(),
                                                    icon: const Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 160.0,
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    iconSize: 24,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                    isExpanded: true,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(
                                                        () {
                                                          dropdownValue =
                                                              newValue;
                                                        },
                                                      );
                                                    },
                                                    items: <String>[
                                                      'Assign',
                                                      'Lend',
                                                    ].map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: SizedBox(
                                                            width: 130,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 8.0,
                                                              ),
                                                              child: Text(
                                                                value,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Visibility(
                                                visible:
                                                    (dropdownValue == 'Assign'),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        // height: 50,
                                                        width: 250,
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                try {
                                                                  var date =
                                                                      await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime
                                                                            .now(),
                                                                    lastDate: DateTime
                                                                        .parse(
                                                                            '2024-12-31'),
                                                                  );
                                                                  _estimatedCheckoutDateController
                                                                      .text = DateFormat
                                                                          .yMMMd()
                                                                      .format(
                                                                          date!);
                                                                } catch (error) {
                                                                  _estimatedCheckoutDateController
                                                                      .text = "";
                                                                }
                                                              },
                                                              child:
                                                                  defaultTextFormField(
                                                                enable: false,
                                                                controller:
                                                                    _estimatedCheckoutDateController,
                                                                type: TextInputType
                                                                    .datetime,
                                                                hint:
                                                                    "estimated Checkout Date",
                                                                // prefix: Icons.qr_code_rounded,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 15),
                                                      SizedBox(
                                                        // height: 50,
                                                        width: 250,
                                                        child: Column(
                                                          children: [
                                                            defaultTextFormField(
                                                              controller:
                                                                  _jobNameController,
                                                              type:
                                                                  TextInputType
                                                                      .text,
                                                              hint:
                                                                  "Job Name...",
                                                              // prefix: Icons.qr_code_rounded,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    (dropdownValue == 'Lend'),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    width: 250,
                                                    child: defaultTextFormField(
                                                      controller:
                                                          _companyController,
                                                      type: TextInputType.text,
                                                      hint: "Company...",
                                                      // prefix: Icons.qr_code_rounded,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: DefaultButton(
                                                    child: const Text(
                                                      "Complete",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      cubit.createCheckOut(
                                                        itemId: widget.id,
                                                        employeeId: 1,
                                                        estimatedCheckInDate:
                                                            _estimatedCheckoutDateController
                                                                .text,
                                                        jobAssigned:
                                                            _jobNameController
                                                                .text,
                                                        companyLended:
                                                            _companyController
                                                                .text,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: (const EdgeInsets.all(21)),
                            color: const Color.fromRGBO(227, 150, 0, 0.7),
                            onPressed: () {
                              {
                                scaffoldKey.currentState!.showBottomSheet(
                                  (context) => StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              spreadRadius: 5,
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 3,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Book",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(height: 50),
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  // height: 50,
                                                  width: 250,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      try {
                                                        var date =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.parse(
                                                                  '2024-12-31'),
                                                        );
                                                        _estimatedCheckoutDateController
                                                            .text = DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(date!);
                                                      } catch (error) {
                                                        _estimatedCheckoutDateController
                                                            .text = "";
                                                      }
                                                    },
                                                    child: defaultTextFormField(
                                                      enable: false,

                                                      controller:
                                                          _estimatedCheckoutDateController,
                                                      type: TextInputType
                                                          .datetime,
                                                      hint:
                                                          "estimated CheckOut Date",
                                                      // prefix: Icons.qr_code_rounded,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  // height: 50,
                                                  width: 250,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      try {
                                                        var date =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime.parse(
                                                                  '2024-12-31'),
                                                        );
                                                        _estimatedCheckinDateController
                                                            .text = DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(date!);
                                                      } catch (error) {
                                                        _estimatedCheckinDateController
                                                            .text = "";
                                                      }
                                                    },
                                                    child: defaultTextFormField(
                                                      enable: false,

                                                      controller:
                                                          _estimatedCheckinDateController,
                                                      type: TextInputType
                                                          .datetime,
                                                      hint:
                                                          "estimated CheckIn Date",
                                                      // prefix: Icons.qr_code_rounded,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  // height: 50,
                                                  width: 250,
                                                  child: defaultTextFormField(
                                                    controller:
                                                        _workOrderController,
                                                    type:
                                                        TextInputType.datetime,
                                                    hint: "work order...",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: DefaultButton(
                                                    child: const Text(
                                                      "Complete",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      cubit.createCheckOut(
                                                        itemId: widget.id,
                                                        employeeId: 1,
                                                        estimatedCheckInDate:
                                                            _estimatedCheckoutDateController
                                                                .text,
                                                        jobAssigned:
                                                            _jobNameController
                                                                .text,
                                                        companyLended:
                                                            _companyController
                                                                .text,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            child: const Icon(
                              IconBroken.bookmark,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

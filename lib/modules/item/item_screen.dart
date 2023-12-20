import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/modules/item/cubit/cubit.dart';
import 'package:warehouse_app/modules/item/cubit/states.dart';
import 'package:warehouse_app/modules/item/navbar_item.dart';
import 'package:warehouse_app/shared/components/components.dart';
import 'package:warehouse_app/styles/icon_broken.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  String? dropdownValue = 'Assign';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit(),
      child: BlocConsumer<ItemCubit, ItemStates>(
        listener: (context, state) {},
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
                      text: "Megger MIT510\n",
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle!
                          .copyWith(
                            color: Colors.black,
                            // height: .2,
                          ),
                    ),
                    TextSpan(
                      text: "code:HIRMEGMIT510",
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle!
                          .copyWith(
                            color: Colors.grey,
                            fontSize: 14,
                            height: 1,
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
                    const SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image(
                          image: NetworkImage(
                              "https://media.megger.com/mediacontainer/medialibraries/meggerglobal/product-images/mit510-2/image_1-small-auto-sized.jpg")),
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
                                text: 'available',
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
                          title: "Sheets",
                        ),
                        NavBarItem(
                          index: 1,
                          currentNavIndex: cubit.currentNavIndex,
                          onTap: cubit.changBottomNavIndex,
                          title: "Details",
                        ),
                        NavBarItem(
                          index: 2,
                          currentNavIndex: cubit.currentNavIndex,
                          onTap: cubit.changBottomNavIndex,
                          title: "Comment",
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Placeholder(),
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
                              onPressed: () {
                                /* TODO :
                                implement the BottomSheet that is in design
                                more details:
                                for check out
                                  1-when user choses to lend the item
                                  display text form felid to inter company name mandatory
                                  2-if user choses to assign it to a job
                                  display tff to inter work order mandatory and optional to input jop name
                                  if user choses book it for a job
                                  3-  display tff to inter work order mandatory*/
                                scaffoldKey.currentState!.showBottomSheet(
                                    (context) => StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        height: 3,
                                                        width: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        )),
                                                  ),
                                                  const Text(
                                                    "Check out",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left: 15.0),
                                                    child: Align(alignment: Alignment.centerLeft,child: Text("choose:",style: TextStyle(color: Colors.grey),)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.08),
                                                            spreadRadius: 7,
                                                            blurRadius: 10,
                                                            offset:
                                                                const Offset(0, 3),
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: DropdownButton<
                                                          String>(
                                                        value: dropdownValue,
                                                        underline: Container(),

                                                        icon: const Padding(
                                                          padding:
                                                              EdgeInsets
                                                                  .only(
                                                                  left: 160.0),
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
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            dropdownValue =
                                                                newValue;
                                                          });
                                                        },
                                                        items: <String>[
                                                          'Assign',
                                                          'Lend',
                                                        ].map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: SizedBox(
                                                                width: 170,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                  child: Text(
                                                                    value,
                                                                  ),
                                                                )),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 200,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: DefaultButton(
                                                          child: const Text(
                                                            "Complete",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          onPressed: () {}),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }));
                              },
                            ),
                          ),
                          const SizedBox(width: 5),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: (const EdgeInsets.all(21)),
                            color: const Color.fromRGBO(227, 150, 0, 0.7),
                            onPressed: () {},
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

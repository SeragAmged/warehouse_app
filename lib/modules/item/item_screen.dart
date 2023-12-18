import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/modules/item/cubit/cubit.dart';
import 'package:warehouse_app/modules/item/cubit/states.dart';
import 'package:warehouse_app/modules/item/navbar_item.dart';
import 'package:warehouse_app/shared/components/components.dart';
import 'package:warehouse_app/styles/icon_broken.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

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
                                  elevation: 20.0,
                                  (context) => SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Check out"),
                                        DropdownButton<String>(
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                            color: Colors.deepPurple,
                                          ),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {},
                                          items: <String>[
                                            'One',
                                            'Two',
                                            'Free',
                                            'Four'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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

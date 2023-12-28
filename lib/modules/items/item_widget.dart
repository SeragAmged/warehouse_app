import 'package:flutter/material.dart';
import 'package:warehouse_app/modules/item/item_screen.dart';
import 'package:warehouse_app/shared/components/functions.dart';

class ItemWidget extends StatelessWidget {
  final String name;
  final int seId;
  final String statue;
  final String image;

  final String detail;

  final String sheet;
  const ItemWidget(
      {super.key,
      required this.name,
      required this.seId,
      required this.statue,
      required this.image,
      required this.detail,
      required this.sheet});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Color.fromRGBO(0, 0, 0, 0.025),
              offset: Offset(-1, 0),
              blurRadius: 26,
              spreadRadius: 5,
            ),
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Color.fromRGBO(0, 0, 0, 0.08),
              offset: Offset(0, 1),
              blurRadius: 80,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              navigateTo(
                context,
                ItemScreen(
                  seId: seId,
                  image: image,
                  name: name,
                  statue: statue,
                  details: detail,
                  sheet: sheet,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      // const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: $seId",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Item state ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                TextSpan(
                                  text: statue,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

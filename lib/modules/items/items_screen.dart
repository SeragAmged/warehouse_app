import 'package:flutter/material.dart';
import 'package:warehouse_app/modules/item/item_screen.dart';
import 'package:warehouse_app/shared/components/functions.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) => Container(
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
              navigateTo(context, const ItemScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Megger MIT510",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 25),
                      Column(
                        children: [
                          Text(
                            "ID: 2183579852408",
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
                                  text: 'available',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: NetworkImage(
                          "https://media.megger.com/mediacontainer/medialibraries/meggerglobal/product-images/mit510-2/image_1-small-auto-sized.jpg"),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

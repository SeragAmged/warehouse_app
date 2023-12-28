import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_app/layout/cubit/cubit.dart';
import 'package:warehouse_app/layout/cubit/states.dart';
import 'package:warehouse_app/modules/login/cubit/cubit.dart';
import 'package:warehouse_app/modules/login/cubit/states.dart';
import 'package:warehouse_app/modules/settings/settings_screen.dart';
import 'package:warehouse_app/shared/components/functions.dart';
import 'package:warehouse_app/styles/icon_broken.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
          appBar: AppBar(
            centerTitle: true,
            title: Text(cubit.titles[cubit.currentBottomNavIndex]),
            actions:
                cubit.screens[cubit.currentBottomNavIndex] is SettingsScreen
                    ? [
                        IconButton(
                          onPressed: () => cubit.changeMode(),
                          icon: const Icon(Icons.dark_mode_outlined),
                        ),
                        IconButton(
                          onPressed: () => logOut(context),
                          icon: const Icon(Icons.logout),
                        ),
                      ]
                    : [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(IconBroken.search),
                        ),
                      ],
          ),
          body: SafeArea(
            child: ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) => cubit.screens[cubit.currentBottomNavIndex],
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            onTap: (index) {
              cubit.changBottomNavIndex(index);
            },
            currentIndex: cubit.currentBottomNavIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(IconBroken.home),
                label: cubit.titles[0],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.manage_search_rounded),
                label: cubit.titles[1],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_alt_rounded),
                label: cubit.titles[2],
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  IconBroken.setting,
                ),
                label: cubit.titles[3],
              ),
            ],
          ),
        );
      },
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:productivityapp/presentation/state/categories_management/categories_cubit.dart";
import "package:productivityapp/presentation/state/navigation/navigation_cubit.dart";
import "package:productivityapp/presentation/ui/resources/app_colors.dart";
import "package:productivityapp/presentation/ui/resources/app_icons.dart";
import "package:productivityapp/presentation/ui/screens/tasks_screen/tasks_screen.dart";

import 'navigation_data.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return NavigationScreenState();
  }
}

class NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late TabController controllerTab;
  TextEditingController controllerTitleName = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerTab =
        TabController(length: NavigationData.titles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: controllerTab,
            children: const [
              TasksScreen(),
              TasksScreen(),
              TasksScreen(),
              TasksScreen(),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 165,
          child: Column(
            children: [
              _getAddTaskButton(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      NavigationData.titles.length,
                      (index) => InkWell(
                        onTap: () {
                          controllerTab.animateTo(index);
                          context.read<NavigationCubit>().changeActive(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  context.read<NavigationCubit>().activeIndex ==
                                          index
                                      ? AppColors.enabledPurple
                                      : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 75,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                NavigationData.icons[index],
                                colorFilter: ColorFilter.mode(
                                    context
                                                .read<NavigationCubit>()
                                                .activeIndex ==
                                            index
                                        ? Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.color ??
                                            AppColors.textWhite
                                        : AppColors.textGray,
                                    BlendMode.srcIn),
                              ),
                              Text(
                                NavigationData.titles[index],
                                style: TextStyle(
                                  color: context
                                              .read<NavigationCubit>()
                                              .activeIndex ==
                                          index
                                      ? Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.color ??
                                          AppColors.textWhite
                                      : AppColors.textGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _getAddTaskButton() => GestureDetector(
        onTap: () {
          showDialog(
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.enabledPurple,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.darkPurple,
                  ),
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create New Tasks',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        cursorColor: AppColors.enabledPurple,
                        controller: controllerTitleName,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.titleLarge,
                          hintText: 'Title',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.enabledPurple,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add a sub-task',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SvgPicture.asset(AppIcons.addIcon),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      _getTaskDialogButtons(),
                    ],
                  ),
                ),
              );
            },
            context: context,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.enabledPurple,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.enabledPurple,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppIcons.addTask),
              const SizedBox(
                width: 15,
              ),
              Text(
                'Add a Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
  _getTaskDialogButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: 96,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            border: Border.all(
              width: 1,
              color: AppColors.enabledPurple,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: 96,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            border: Border.all(
              width: 1,
              color: AppColors.enabledPurple,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Date & Time',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      InkWell(
        onTap: () {
          context.read<CategoriesCubit>().addTask(
                title: controllerTitleName.text,
                time: DateTime(1900),
              );
          controllerTitleName.clear();
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: 96,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.enabledPurple,
            border: Border.all(
              width: 1,
              color: AppColors.enabledPurple,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Set',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    ]);
  }
}

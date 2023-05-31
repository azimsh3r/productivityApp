import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productivityapp/presentation/state/tasks_cubit_expansion_tile/expansion_cubit.dart';
import 'package:productivityapp/presentation/ui/data/data_tasks.dart';
import 'package:productivityapp/presentation/ui/resources/app_colors.dart';
import 'package:productivityapp/presentation/ui/resources/app_icons.dart';
import 'package:productivityapp/presentation/ui/resources/app_images.dart';
import 'package:productivityapp/presentation/ui/widgets/appbar.dart';
import 'package:productivityapp/presentation/ui/widgets/padding.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TasksScreenState();
  }
}

class TasksScreenState extends State<TasksScreen> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: CustomPadding(
        child: BlocBuilder<ExpansionCubit, ExpansionState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                ...List.generate(
                  DatabaseTasks.categories.length,
                  (index) => _getExpansionTiles(
                    currentIndex: index,
                    isRightTile: index == 0 ? true : false,
                    onTap: () {
                      if (index ==
                          context.read<ExpansionCubit>().ExpandedIndex) {
                        context.read<ExpansionCubit>().clear();
                      } else {
                        context.read<ExpansionCubit>().expand(index: index);
                      }
                    },
                    activeIndex: context.read<ExpansionCubit>().ExpandedIndex,
                    label: DatabaseTasks.categories[index].name,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _getAppBar() => PreferredSize(
        preferredSize: const Size(double.infinity, 96),
        child: CustomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.lightPurple,
                        image: DecorationImage(
                          image: NetworkImage(AppImages.avatarImage),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hello Azimjon!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Keep plan for 1 day',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                AppIcons.searchIcon,
                width: 26,
              ),
            ],
          ),
        ),
      );
  _getExpansionTiles({
    required String label,
    required void Function() onTap,
    required int activeIndex,
    required int currentIndex,
    bool isRightTile = false,
  }) =>
      Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2),
              ],
              color: AppColors.darkPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (isRightTile) ...{
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppIcons.addIcon,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 14,
                            bottom: 14,
                            left: 14,
                          ),
                          child: activeIndex != currentIndex
                              ? SvgPicture.asset(
                                  AppIcons.moreIcon,
                                  width: 18,
                                )
                              : RotationTransition(
                                  turns:
                                      const AlwaysStoppedAnimation(180 / 360),
                                  child: SvgPicture.asset(
                                    AppIcons.moreIcon,
                                    width: 18,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                } else ...{
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 14,
                        bottom: 14,
                        left: 14,
                      ),
                      child: activeIndex != currentIndex
                          ? SvgPicture.asset(
                              AppIcons.moreIcon,
                              width: 18,
                            )
                          : RotationTransition(
                              turns: const AlwaysStoppedAnimation(180 / 360),
                              child: SvgPicture.asset(
                                AppIcons.moreIcon,
                                width: 18,
                              ),
                            ),
                    ),
                  ),
                }
              ],
            ),
          ),
          if (currentIndex == activeIndex) ...{
            ...List.generate(
              DatabaseTasks.categories[currentIndex].tasks.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2),
                  ],
                  color: AppColors.darkPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppIcons.seemoreIcon),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          DatabaseTasks
                              .categories[currentIndex].tasks[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          DatabaseTasks
                              .categories[currentIndex].tasks[index].time,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          },
        ],
      );
}

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
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ...List.generate(
                    DatabaseTasks.categories.length,
                    (index) => _getExpansionTiles(
                      currentIndex: index,
                      isRightTile: index == 0 ? true : false,
                      onTap: () {
                        if (context
                            .read<ExpansionCubit>()
                            .openTilesIndexes
                            .contains(index)) {
                          context.read<ExpansionCubit>().clearTile(index);
                        } else {
                          context.read<ExpansionCubit>().expand(index: index);
                        }
                      },
                      activeIndex: context.read<ExpansionCubit>().expandedIndex,
                      label: DatabaseTasks.categories[index].name,
                    ),
                  ),
                ],
              ),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 2,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: context
                            .read<ExpansionCubit>()
                            .openTilesIndexes
                            .contains(currentIndex)
                        ? 7
                        : 2),
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
          if (context
              .read<ExpansionCubit>()
              .openTilesIndexes
              .contains(currentIndex)) ...{
            ...List.generate(
              (context.read<ExpansionCubit>().seeMore.contains(currentIndex) &&
                      DatabaseTasks.categories[currentIndex].tasks.length > 3)
                  ? DatabaseTasks.categories[currentIndex].tasks.length
                  : (DatabaseTasks.categories[currentIndex].tasks.length > 3)
                      ? 3
                      : DatabaseTasks.categories[currentIndex].tasks.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
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
                          width: 10,
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
                          '${DatabaseTasks.categories[currentIndex].tasks[index].time.day}/${DatabaseTasks.categories[currentIndex].tasks[index].time.month}/${DatabaseTasks.categories[currentIndex].tasks[index].time.year}',
                        ),
                        const SizedBox(width: 26),
                        SvgPicture.asset(
                          AppIcons.tickIcon,
                          colorFilter: ColorFilter.mode(
                              DatabaseTasks.categories[currentIndex].tasks
                                          .length <=
                                      3
                                  ? AppColors.tickColors[index]
                                  : AppColors.tickColors[index % 3],
                              BlendMode.srcIn),
                        ),
                        const SizedBox(width: 26),
                        SvgPicture.asset(AppIcons.addIcon),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (DatabaseTasks.categories[currentIndex].tasks.length > 3 &&
                context.read<ExpansionCubit>().seeMore.contains(currentIndex) ==
                    false) ...{
              GestureDetector(
                onTap: () {
                  context.read<ExpansionCubit>().showMore(index: currentIndex);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'See More',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(AppIcons.moreIcon),
                    ],
                  ),
                ),
              ),
            },
            if (DatabaseTasks.categories[currentIndex].tasks.length <= 3 ||
                context.read<ExpansionCubit>().seeMore.contains(currentIndex) ==
                    true) ...{
              const SizedBox(
                height: 20,
              ),
            },
            const SizedBox(height: 12),
          },
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productivityapp/presentation/data/data_tasks.dart';
import 'package:productivityapp/presentation/state/categories_management/categories_cubit.dart';
import 'package:productivityapp/presentation/state/tasks_cubit_expansion_tile/expansion_cubit.dart';
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

class TasksScreenState extends State<TasksScreen>
    with TickerProviderStateMixin {
  bool isOpen = false;
  TextEditingController controllerTitle = TextEditingController();
  late Animation<Offset> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animation =
        Tween<Offset>(begin: const Offset(0, -0.05), end: const Offset(0, 0))
            .animate(animationController);
  }

  @override
  void dispose() {
    super.dispose();
    controllerTitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return CustomPadding(
            child: BlocBuilder<ExpansionCubit, ExpansionState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _getCategoriesTile(),
                      ...List.generate(
                        DataTasks.taskTypes.length,
                        (index) => _getExpansionTiles(
                          currentIndex: index,
                          onTap: () {
                            if (context
                                .read<ExpansionCubit>()
                                .openTilesIndexes
                                .contains(index)) {
                              animationController.reverse();

                              context.read<ExpansionCubit>().clearTile(index);
                            } else {
                              context
                                  .read<ExpansionCubit>()
                                  .expand(index: index);
                              animationController.forward();
                            }
                          },
                          activeIndex:
                              context.read<ExpansionCubit>().expandedIndex,
                          label: DataTasks.taskTypes[index].name,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
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
  _getCategoriesTile() => Column(
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
                            .contains(-1)
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
                  'Categories',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 30,
                                  ),
                                  height: 240,
                                  decoration: BoxDecoration(
                                      color: AppColors.darkPurple,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create New Category',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      TextField(
                                        controller: controllerTitle,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                          hintText: 'Title',
                                        ),
                                      ),
                                      _getDialogButtons(),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                          AppIcons.addIcon,
                          width: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if (context
                            .read<ExpansionCubit>()
                            .openTilesIndexes
                            .contains(-1)) {
                          context.read<ExpansionCubit>().clearTile(-1);
                        } else {
                          context.read<ExpansionCubit>().expand(index: -1);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 14,
                          left: 14,
                        ),
                        child: context
                                .read<ExpansionCubit>()
                                .openTilesIndexes
                                .contains(-1)
                            ? RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: SvgPicture.asset(
                                  AppIcons.moreIcon,
                                  width: 18,
                                ),
                              )
                            : SvgPicture.asset(
                                AppIcons.moreIcon,
                                width: 18,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (context.read<ExpansionCubit>().openTilesIndexes.contains(-1)) ...{
            Wrap(
              children: [
                ...List.generate(
                  context.read<ExpansionCubit>().seeMore.contains(-1)
                      ? DataTasks.categories.length
                      : 5,
                  (index) => GestureDetector(
                    onTap: () {
                      // TODO: Add Function to open necessary Tabs
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.7,
                              color: DataTasks.categories[index].color,
                            ),
                            color: AppColors.darkPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 179,
                          height: 70,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 3),
                            decoration: BoxDecoration(
                              color: AppColors.darkPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 178,
                            height: 69,
                            child: Row(
                              children: [
                                Icon(
                                  DataTasks.categories[index].iconData,
                                  color: DataTasks.categories[index].color,
                                  size: 28,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  DataTasks.categories[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color:
                                            DataTasks.categories[index].color,
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
                if (DataTasks.categories.length > 5 &&
                    !context.read<ExpansionCubit>().seeMore.contains(-1)) ...{
                  GestureDetector(
                    onTap: () {
                      context.read<ExpansionCubit>().showMore(index: -1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 3),
                      decoration: BoxDecoration(
                        color: AppColors.darkPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 178,
                      height: 69,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppIcons.moreIcon),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'More',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                }
              ],
            ),
          }
        ],
      );

  _getExpansionTiles({
    required String label,
    required void Function() onTap,
    required int activeIndex,
    required int currentIndex,
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
              ],
            ),
          ),
          SlideTransition(
            position: animation,
            child: _getTasks(currentIndex: currentIndex),
          ),
        ],
      );

  _getDialogButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              controllerTitle.clear();
            },
            child: Container(
              width: 88,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.enabledPurple,
                  width: 1,
                ),
              ),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              context
                  .read<CategoriesCubit>()
                  .addCategory(title: controllerTitle.text);
              Navigator.pop(context);
              controllerTitle.clear();
            },
            child: Container(
              width: 88,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.enabledPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      );
  _getTasks({required int currentIndex}) => Column(
        children: [
          if (context
              .read<ExpansionCubit>()
              .openTilesIndexes
              .contains(currentIndex)) ...{
            ...List.generate(
              (context.read<ExpansionCubit>().seeMore.contains(currentIndex) &&
                      DataTasks.taskTypes[currentIndex].tasks.length > 3)
                  ? DataTasks.taskTypes[currentIndex].tasks.length
                  : (DataTasks.taskTypes[currentIndex].tasks.length > 3)
                      ? 3
                      : DataTasks.taskTypes[currentIndex].tasks.length,
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
                          DataTasks.taskTypes[currentIndex].tasks[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${DataTasks.taskTypes[currentIndex].tasks[index].time.day}/${DataTasks.taskTypes[currentIndex].tasks[index].time.month}/${DataTasks.taskTypes[currentIndex].tasks[index].time.year}',
                        ),
                        const SizedBox(width: 26),
                        SvgPicture.asset(
                          AppIcons.tickIcon,
                          colorFilter: ColorFilter.mode(
                              DataTasks.taskTypes[currentIndex].tasks[index]
                                  .category.color,
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
            if (DataTasks.taskTypes[currentIndex].tasks.length > 3 &&
                context.read<ExpansionCubit>().seeMore.contains(currentIndex) ==
                    false) ...{
              InkWell(
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
            if (DataTasks.taskTypes[currentIndex].tasks.length <= 3 ||
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_2/core/constants/theme.dart';
import 'package:todo_app_2/domain/entities/todo_entity.dart';
import 'package:todo_app_2/presentation/doing/bloc/doing_bloc.dart';
import 'package:todo_app_2/presentation/widgets/connection_error_widget.dart';
import 'package:todo_app_2/presentation/widgets/connection_loading_widget.dart';
import 'package:todo_app_2/presentation/widgets/sizer.dart';

class DoingPage extends StatefulWidget {
  const DoingPage({super.key});

  @override
  State<DoingPage> createState() => _DoingPageState();
}

class _DoingPageState extends State<DoingPage>
    with SingleTickerProviderStateMixin {
  ScrollController? scrollController = ScrollController();
  DoingBloc? blocController;
  @override
  void initState() {
    blocController = BlocProvider.of<DoingBloc>(context);
    blocController!.add(Init());
    super.initState();
    scrollController!.addListener(() {
      if (scrollController!.offset ==
          scrollController!.position.maxScrollExtent) {
        blocController!.add(LoadMore());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoingBloc, DoingState>(builder: (context, state) {
      Map<String, List<TaskEntity>>? showTask;
      if (state is DoingInitial) {
        BlocProvider.of<DoingBloc>(context).add(Init());
      } else if (state is DoingLoading) {
        return const ConnectionLoadingWidget();
      } else if (state is DoingLoadFailue) {
        return const ConnectionErrorWidget();
      } else if (state is DoingLoaded) {
        showTask = state.dateGroup;
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Sizer(context).w,
          child: SingleChildScrollView(
            key: const Key('scroll'),
            controller: scrollController,
            child: Builder(builder: (context) {
              if (showTask != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130),
                    ...showTask.keys.map<Widget>((item) {
                      List<TaskEntity> val = showTask![item] ?? [];
                      return Container(
                        width: Sizer(context).w * 0.8,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "${item} ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            itemList(val),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                );
              }
              return SizedBox();
            }),
          ),
        ),
      );
    });
  }

  Widget boxUnselected(String text) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints.expand(width: 100),
      height: 10,
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget boxSelected(String text) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: primaryColor),
            color: primaryColor,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget itemList(List<TaskEntity> val) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: val.length,
      itemBuilder: (context, index) {
        TaskEntity only = val[index];
        return ClipRect(
          child: Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    BlocProvider.of<DoingBloc>(context).add(Remove(only.id!));
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete_outline,
                ),
              ],
            ),
            child: Builder(builder: (context) {
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${only.title ?? ""} ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${only.description ?? ""} ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

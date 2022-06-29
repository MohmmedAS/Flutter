import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_project/components/components.dart';
import 'package:todo_project/cubit/cubit.dart';
import 'package:todo_project/cubit/states.dart';

class Tasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var tasks = AppCubit.get(context).tasks;
        return taskBuilder(tasks);
      },
    );
  }
}

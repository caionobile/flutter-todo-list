import 'package:flutter/material.dart';

import '../widgets/add_todo_modal.dart';
import '../widgets/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _handleTabAnimation() {
    if (_tabController.animation!.value == _tabController.index.toDouble()) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animation!.addListener(_handleTabAnimation);
  }

  @override
  void dispose() {
    _tabController.animation!.removeListener(_handleTabAnimation);
    _tabController.dispose();
    super.dispose();
  }

  void _showAddTodoModal() {
    showDialog(context: context, builder: (context) => const AddTodoModal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do list', textAlign: TextAlign.center),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(12, 61, 101, 1),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Color.fromRGBO(28, 109, 176, 1),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(_tabController.index == 0 ? 36 : 0),
                    right: Radius.circular(_tabController.index == 2 ? 36 : 0),
                  ),
                ),
                dividerHeight: 0,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'pending'),
                  Tab(text: 'done'),
                ],
              ),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                TodoList(filter: TodoFilter.all),
                TodoList(filter: TodoFilter.pending),
                TodoList(filter: TodoFilter.done),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoModal,
        backgroundColor: Color.fromRGBO(12, 61, 101, 1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(120)),
        child: const Icon(Icons.add),
      ),
    );
  }
}

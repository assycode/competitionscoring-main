//用户信息管理页面(管理员端)

import 'package:flutter/material.dart';

class AdminUserInfoManagementPage extends StatefulWidget {
  const AdminUserInfoManagementPage({super.key});

  @override
  State<AdminUserInfoManagementPage> createState() => _AdminUserInfoManagementPageState();
}

class _AdminUserInfoManagementPageState extends State<AdminUserInfoManagementPage> {
  int currentPage = 1;
  final int itemsPerPage = 5;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> allData = List.generate(15, (index) {
    return {
      'name': ['张三', '李四', '王五', '赵六', '孙七', '周八'][index % 6],
      'role': ['学生', '管理员'][index % 2],
      'college': ['计算机', '设计', '管理'][index % 3],
      'major': ['软件工程', '设计学', '工商管理'][index % 3],
      'enrollmentYear': '2023年',
    };
  });

  String selectedCollege = '学院：计算机与大数据';
  String selectedRole = '角色：辅导员或学生';
  String selectedMajor = '专业：软件工程';

  final List<String> collegeOptions = ['学院：计算机与大数据', '计算机与大数据', '设计', '管理'];
  final List<String> roleOptions = ['角色：辅导员或学生', '学生', '管理员', '辅导员'];
  final List<String> majorOptions = ['专业：软件工程', '设计学', '工商管理','软件工程'];

  @override
  Widget build(BuildContext context) {

    const Color primaryBlue = Color(0xFF4A90E2);
    const Color bgColor = Color(0xFFF7F8FA);
    const double cardRadius = 12;

    // 当前页数据
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, allData.length);
    final currentData = allData.sublist(start, end);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '用户信息管理',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/adminHome',
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 搜索栏
            Container(
              width: 340,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _handleSearch, // 点击图标也可触发搜索
                  ),
                  hintText: '搜索姓名',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) => _handleSearch(), // 按回车搜索
              ),
            ),
            const SizedBox(height: 16),

            // 筛选行
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown('学院', selectedCollege, collegeOptions, (v) {
                  setState(() => selectedCollege = v!);
                }),
                const SizedBox(width: 8),
                _buildDropdown('专业', selectedMajor, majorOptions, (v) {
                  setState(() => selectedMajor = v!);
                }),
                const SizedBox(width: 8),
                _buildDropdown('角色', selectedRole, roleOptions, (v) {
                  setState(() => selectedRole = v!);
                }),
              ],
            ),
            const SizedBox(height: 16),

            // 表格头
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Row(
                children: [
                  Expanded(flex: 1, child: Center(child: Text('姓名', style: TextStyle(fontWeight: FontWeight.bold)))),
                  Expanded(flex: 2, child: Center(child: Text('角色', style: TextStyle(fontWeight: FontWeight.bold)))),
                  Expanded(flex: 2, child: Center(child: Text('学院', style: TextStyle(fontWeight: FontWeight.bold)))),
                  Expanded(flex: 2, child: Center(child: Text('管理专业', style: TextStyle(fontWeight: FontWeight.bold)))),
                  Expanded(flex: 2, child: Center(child: Text('管理年级', style: TextStyle(fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),

            // 表格数据
            Expanded(
              child: ListView.separated(
                itemCount: currentData.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = currentData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Center(child: Text(item['name']!))),
                        Expanded(flex: 2, child: Center(child: Text(item['role']!))),
                        Expanded(flex: 2, child: Center(child: Text(item['college']!))),
                        Expanded(flex: 2, child: Center(child: Text(item['major']!))),
                        Expanded(flex: 2, child: Center(child: Text(item['enrollmentYear']!))),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1, height: 1),

            // 分页控制
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: currentPage > 1
                        ? () => setState(() => currentPage--)
                        : null,
                    child: const Text('上一页'),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$currentPage / ${((allData.length - 1) ~/ itemsPerPage) + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: end < allData.length
                        ? () => setState(() => currentPage++)
                        : null,
                    child: const Text('下一页'),
                  ),
                ],
                
              ),
            ),
            
          ],
          
        ),
      ),
    );
  }

  // 搜索逻辑
  void _handleSearch() {
    final input = _searchController.text.trim();
    if (input.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('搜索结果'),
        content: Text('搜索了姓名: $input'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  // 下拉框组件
  Widget _buildDropdown(String label, String value, List<String> options, ValueChanged<String?> onChanged) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            onChanged: onChanged,
            items: options
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

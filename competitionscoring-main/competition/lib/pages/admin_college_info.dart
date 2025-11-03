// 学院信息管理页面(管理员端)

import 'package:competition/util/edit_college_dialog.dart';
import 'package:flutter/material.dart';

class CollegeInfoPage extends StatefulWidget {
  const CollegeInfoPage({super.key});

  @override
  State<CollegeInfoPage> createState() => _CollegeInfoPageState();
}

class _CollegeInfoPageState extends State<CollegeInfoPage> {
  int currentPage = 1;
  final int itemsPerPage = 5;
  final TextEditingController _searchController = TextEditingController();

  String selectedCollege = '计算机与大数据';
  String selectedMajor = '软件工程';
  final List<String> collegeOptions = ['计算机与大数据', '外国语', '管理'];
  final List<String> majorOptions = ['软件工程', '人工智能', '网络安全'];

  final List<Map<String, String>> allData = List.generate(5, (i) {
    return {'college': '计算机与大数据', 'major': '软件工程'};
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '学院信息管理',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/adminHome');
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 搜索栏
            Container(
              width: double.infinity,
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
                    onPressed: () {}, // 预留搜索操作
                  ),
                  hintText: '搜索学院或专业',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 下拉筛选行
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDropdown(
                  '学院',
                  selectedCollege,
                  collegeOptions,
                  (value) => setState(() => selectedCollege = value!),
                ),
                _buildDropdown(
                  '专业',
                  selectedMajor,
                  majorOptions,
                  (value) => setState(() => selectedMajor = value!),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 表头
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        '学院',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '专业',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, thickness: 1),

            // 数据表格
            Expanded(
              child: ListView.separated(
                itemCount: allData.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = allData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(child: Text(item['college'] ?? '')),
                        ),
                        Expanded(
                          child: Center(child: Text(item['major'] ?? '')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 操作按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text('新增'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                      ),
                      builder: (_) => const EditCollegeDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text('修改'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 分页控制
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: currentPage > 1
                      ? () => setState(() => currentPage--)
                      : null,
                  child: const Text('上一页'),
                ),
                Text(
                  '$currentPage/5',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: currentPage < 5
                      ? () => setState(() => currentPage++)
                      : null,
                  child: const Text('下一页'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 底部状态栏
            const Text(
              '2025年10月9日 14:30   系统版本v2.3.1   服务状态：正常',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
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

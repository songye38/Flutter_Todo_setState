# Flutter Todo App 간단 단계별 구현 가이드

---

## 프로젝트 개요

**프로젝트명:** Flutter Todo App

**기간:** 2025년 6월 13일 ~ 6월 18일 

**목표:**
* 처음 Flutter 관련 세팅을 하고 Flutter 찍먹 해보기!!!!
* Flutter를 활용한 모바일 투두 리스트 애플리케이션 개발
* 직접 만든 REST API 서버와 연동하여 CRUD(생성, 조회, 수정, 삭제) 기능 구현
* 기본 상태 관리 및 비동기 데이터 처리 경험 쌓기

**설명:**
이 프로젝트는 3개월간 진행되는 Code Rounge 동아리 활동 중 6월 첫 번째 프로젝트에 해당합니다. 3개월 동안 간단한 뽀모도로 앱을 모바일, 데스크탑, 웹 환경에서 구현하며 본격적인 소프트웨어 개발 역량을 쌓는 것을 목표로 하고 있습니다.
그중 6월에는 Flutter를 처음 접하며 앱 개발 경험을 쌓기 위해 간단한 투두 리스트 앱을 제작하였습니다. 본격적인 뽀모도로 앱 개발에 앞서 Flutter 사용법과 앱 개발 프로세스를 익히는 데 중점을 둔 프로젝트입니다.


---

## Step 1: 기본 투두리스트 목록 만들기

* `TodoItem` 모델 정의 (id, text, done)
* API로 서버에서 할 일 목록 불러오기
* `ListView`로 할 일 리스트 보여주기

```dart
// TodoItem 모델 예시
class TodoItem {
  final int id;
  final String text;
  bool done;

  TodoItem({required this.id, required this.text, this.done = false});
}
```

```dart
// ListView에 todos 띄우기 (간단히)
ListView(
  children: todos.map((todo) => Text(todo.text)).toList(),
);
```
![시연 장면](screenRecording/STEP_1.gif)

---

## Step 2: 체크박스 눌러 완료 여부 수정하기

* `TodoItemWidget`에 `Checkbox` 추가
* 체크 상태 바뀌면 API 호출해서 서버에 업데이트
* 상태 변경되면 UI 다시 렌더링

```dart
Checkbox(
  value: todo.done,
  onChanged: (bool? value) {
    if (value == null) return;
    // 부모에 변경 사항 알려주기
    onChanged(TodoItem(id: todo.id, text: todo.text, done: value));
  },
),
```
![시연 장면](screenRecording/STEP_2.gif)

---

## Step 3: 투두 아이템 삭제 기능 추가하기

* `TodoItemWidget`에 삭제 버튼 추가
* 삭제 버튼 누르면 해당 아이템 서버에서 삭제
* 상태에서 해당 아이템 제거 후 UI 업데이트

```dart
IconButton(
  icon: Icon(Icons.delete, color: Colors.red),
  onPressed: () {
    onDelete(todo);
  },
),
```
![시연 장면](screenRecording/STEP_3.gif)

---

## Step 4: ✏️ 할 일 수정 기능 추가하기

* `TodoItemWidget`에서 제목 부분을 탭하면 `AlertDialog`로 수정 UI 띄우기
* 사용자가 새로운 제목을 입력하면 서버에 PATCH 요청
* 성공 시 로컬 `todos` 리스트도 갱신

```dart
onTap: () async {
  final newTitle = await showDialog<String>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('할 일 수정'),
      content: TextField(
        controller: TextEditingController(text: todo.text),
        decoration: InputDecoration(hintText: '새 제목 입력'),
        autofocus: true,
      ),
      actions: [
        TextButton(child: Text('취소'), onPressed: () => Navigator.pop(context)),
        ElevatedButton(child: Text('저장'), onPressed: () {
          Navigator.pop(context, editController.text);
        }),
      ],
    ),
  );

  if (newTitle != null && newTitle.trim().isNotEmpty) {
    await ApiService.updateTodoTitle(todo.id, newTitle);
    onEditTitle(todo.copyWith(text: newTitle));
  }
},
```
![시연 장면](screenRecording/STEP_4.gif)

---

## Step 5: ✅ 삭제/수정/추가/체크 시 토스트(스낵바) 알림 띄우기

* 재사용 가능한 `showAppToast()` 함수 만들기 (`utils/show_toast.dart`)
* 각 액션 완료 후 `showAppToast(context, '할 일이 삭제되었습니다!')` 형태로 사용
* 디자인 통일과 사용자 피드백 강화

```dart
// utils/show_toast.dart
void showAppToast(BuildContext context, String message,
    {Color backgroundColor = Colors.black87,
     IconData icon = Icons.check_circle}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Expanded(child: Text(message, style: TextStyle(color: Colors.white))),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: Duration(seconds: 2),
    ),
  );
}
```

```dart
// 사용 예
showAppToast(context, '삭제되었습니다!', backgroundColor: Colors.red, icon: Icons.delete);
showAppToast(context, '수정 완료!');
showAppToast(context, '할 일이 추가되었습니다!');
```
![시연 장면](screenRecording/STEP_5.gif)

---

## Step 6: 🧭 하단 네비게이션바로 메인 화면 구성

* `BottomNavigationBar`를 활용해서 여러 페이지로 구성
* 예: Todo 목록 / 완료된 목록 / 설정 등
* 각각의 페이지는 `IndexedStack`이나 `PageView`로 관리

```dart
int _selectedIndex = 0;
final List<Widget> _pages = [TodoPage(), DonePage(), SettingsPage()];

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _pages[_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: '할 일'),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: '완료'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
      ],
    ),
  );
}
```

![시연 장면](screenRecording/STEP_6.gif)


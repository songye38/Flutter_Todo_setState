# Flutter Todo App 간단 단계별 구현 가이드

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
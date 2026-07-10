/*
  1. BLoC là gì?
  - BLoC (Business Logic Component) là một mẫu kiến trúc (design pattern) giúp tách biệt logic nghiệp vụ
  (business logic) khỏi giao diện người dùng (UI).
  - Nguyên lý hoạt động: BLoC hoạt động theo cơ chế luồng dữ liệu một chiều (unidirectional data flow):
                  UI (View) ---Sự kiện (Event)--> BLoC ---Trạng thái (State)---> UI (View)
    + UI gửi Event đến BLoC
    + BLoC xử lý Event, thực hiện logic nghiệp vụ
    + BLoC phát ra State mới
    + UI lắng nghe State và tự động cập nhật lại giao diện
  2. Các khái niệm cốt lõi
  2.1. Event (Sự kiện)
  Event là đầu vào của BLoC. Nó đại diện cho các hành động hoặc sự tương tác của người dùng như nhấn nút,
  nhập dữ liệu, hoặc các sự kiện từ hệ thống.
 */

// Định nghĩa các Event cho Counter
abstract class CounterEvent {}
class IncrementEvent extends CounterEvent {}
class DecrementEvent extends CounterEvent {}
class ResetEvent extends CounterEvent {}

// 2.2. State (Trạng thái)
// State là đầu ra của BLoC. Nó đại diện cho trạng thái của ứng dụng tại một thời điểm nhất định.
// Định nghĩa State cho Counter
class CounterState {
  final int value;
  const CounterState(this.value);
}

/*
  2.3. Transition
  Transition là sự thay đổi từ một State sang State khác, bao gồm: current state, event, và next state.

  2.4. BLoC (Business Logic Component)
  BLoC là thành phần trung gian nhận Event, xử lý logic, và phát ra State mới.

  3. Cài đặt và cấu hình
  Thêm các package cần thiết vào pubspec.yaml:
  dependencies:
    flutter:
      sdk: flutter
    bloc: ^9.2.1         # Core BLoC
    flutter_bloc: ^9.1.1  # Flutter widgets cho BLoC
    equatable: ^2.1.0     # Hỗ trợ so sánh đối tượng (khuyến nghị)

  dev_dependencies:
    flutter_test:
      sdk: flutter
    bloc_test: ^10.0.0    # Hỗ trợ test BLoC
 */
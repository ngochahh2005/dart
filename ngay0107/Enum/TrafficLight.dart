/* 
  Yêu cầu:

    Tạo một Enum tên là TrafficLight gồm 3 trạng thái: red, yellow, green.

    Viết một hàm TrafficLight getNextLight(TrafficLight current) để trả về màu đèn tiếp theo theo quy luật:

    Đỏ (red) chuyển sang Xanh (green).

    Xanh (green) chuyển sang Vàng (yellow).

    Vàng (yellow) chuyển sang Đỏ (red).

    Bắt buộc: Sử dụng lệnh switch bên trong hàm. Hãy thử cố tình thiếu một case để xem trình biên dịch Dart cảnh báo như thế nào, sau đó viết đầy đủ lại.
*/

enum TrafficLight { red, yellow, green }

TrafficLight getNextLight(TrafficLight cur) {
  switch (cur) {
    case TrafficLight.red:
      return TrafficLight.green;
    case TrafficLight.green:
      return TrafficLight.yellow;
    default:
      return TrafficLight.red;
  }
}


void main() {
  var state = TrafficLight.green;
  print(getNextLight(state));
}

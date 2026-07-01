/* 
  Runes: tập hợp các điểm mã Unicode của 1 chuỗi
  Dùng để xử lý các ký tự Unicode đặc biệt như emoji, ký tự đặc biệt
  Mỗi ký tự Unicode được biểu diễn bởi 1 số nguyên
  Với các ký tự có từ 2 code units trở lên -> vẫn coi là 1 ký tự 
    -> UD thực tế: giới hạn ký tự khách hàng được điền, 
    cắt ký tự để hiển thị ... khi văn vản dài
*/

void main() {
  // Cach khai bao
  String str = 'Hello';
  Runes runes = str.runes;

  Runes runes2 = Runes('\u2665'); // ky tu trai tim ♥

  Runes runes3 = Runes('\u{1F600}'); // Emoji cuoi 😀
  print(runes3);

  // CAC PHUONG THUC VA THUOC TINH

  // 1. Chuyen doi:
  // Tu Runes -> String
  String heartSymbol = String.fromCharCodes(runes2);
  print(heartSymbol);

  // Tu ma Unicode -> String
  String emoji = String.fromCharCode(0x1F600); // emoji mat cuoi 😀
  print(emoji);
  String symbol = String.fromCharCode(0x2665); // ky tu trai tim ♥
  print(symbol);

  // 2. Xu ly:
  print(runes.length); // so luong diem ma
  // print(runes2.length);
  print(runes.first); // diem ma dau tien
  print(runes.last); // diem ma cuoi cung

  // Duyet qua tung diem ma
  runes = 'Xin chào 😀, tôi rất ♥ bạn'.runes;
  runes.forEach((int rune) {
    print('Unicode: $rune, ky tu: ${String.fromCharCode(rune)}');
  });

  // Kiem tra
  print(runes.isEmpty);
  print(runes.isNotEmpty);
}

/* 
  Ứng dụng:
  - Xử lý emoji trong ứng dụng chat
  - Hiển thị ký tự đặc biệt (copyright, trademark)
  - Tạo các biểu tượng đánh giá (sao, tim)
  - Xử lý văn bản đa ngôn ngữ có ký tự đặc biệt
*/
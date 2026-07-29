# MeowCollector – Ứng dụng khám phá và sưu tầm ảnh mèo

> **Ứng dụng dành riêng cho tín đồ yêu mèo** – cho phép khám phá hàng trăm giống mèo qua ảnh chất lượng cao, lưu trữ danh sách yêu thích ngoại tuyến và đồng bộ tài khoản cá nhân an toàn.

---

## 🐱 Giới thiệu

**MeowCollector** là một ứng dụng di động đa nền tảng được xây dựng bằng **Flutter**, tích hợp hoàn toàn với **The Cat API** để cung cấp kho ảnh và thông tin chi tiết về các giống mèo trên thế giới. Ứng dụng không chỉ là một "cuốn bách khoa toàn thư về mèo" mà còn là một **trình quản lý bộ sưu tập cá nhân**, cho phép "thả tim" những chú mèo yêu thích và lưu chúng vào cơ sở dữ liệu cục bộ – có thể xem lại ngay cả khi không có kết nối mạng.

---

## ✨ Tính năng nổi bật

### 📸 Khám phá giống mèo
- Gọi API từ [The Cat API](https://api.thecatapi.com/v1/breeds) để lấy danh sách tất cả các giống mèo.
- Hiển thị ảnh đại diện, tên giống, nguồn gốc, tính cách và các chỉ số (mức độ thân thiện, thông minh, rụng lông, …).
- Hỗ trợ tải ảnh chất lượng cao từ CDN.

### ❤️ Sưu tầm yêu thích (Offline)
- Nhấn biểu tượng trái tim trên mỗi thẻ mèo để lưu vào danh sách yêu thích.
- Dữ liệu được ghi vào cơ sở dữ liệu **Sqflite** ngay trên thiết bị.
- Mở mục "Yêu thích" khi mất mạng vẫn xem được đầy đủ ảnh và thông tin đã lưu.

### 🔐 Xác thực và bảo mật
- **Firebase Authentication** (Email & Password): Yêu cầu đăng nhập trước khi truy cập kho ảnh.
- **Flutter Secure Storage**: Mã hóa và lưu trữ token đăng nhập an toàn, giúp duy trì phiên đăng nhập.
- **GoRouter + Auth Guard**: Tự động chặn các route chưa đăng nhập và chuyển hướng về màn hình đăng nhập.

### 🎨 Tùy chỉnh giao diện
- **SharedPreferences** lưu lại:
  - Chế độ xem: **Dạng lưới** hay **Dạng danh sách**.
  - Màu chủ đề theo sở thích của người dùng.
- Ứng dụng ghi nhớ lựa chọn và áp dụng ngay khi khởi động lại.

### 📱 Giao diện thích ứng (Adaptive & Responsive)
- **Responsive với LayoutBuilder + GridView.builder**:
  - Điện thoại ( < 600px ): 2 cột.
  - Tablet nhỏ (600 – 1200px): 3 cột.
  - Tablet lớn, Web, Desktop ( > 1200px ): 4 – 5 cột, tận dụng tối đa không gian.
- **Adaptive với tương tác nền tảng**:
  - Trên mobile: Hỗ trợ vuốt (swipe) và hiệu ứng ripple khi chạm.
  - Trên web/desktop: Thêm hiệu ứng hover, thanh cuộn dạng desktop, padding phù hợp với chuột.

---

## 🧩 Kiến trúc kỹ thuật

### Công nghệ sử dụng
| Thành phần | Công nghệ |
|------------|-----------|
| Framework | Flutter (Dart) |
| API | The Cat API (miễn phí, không cần key) |
| Xác thực | Firebase Authentication |
| Điều hướng | GoRouter (có Auth Guard) |
| Lưu trữ bảo mật | Flutter Secure Storage (token) |
| Lưu trạng thái UI | SharedPreferences |
| Database offline | Sqflite (SQLite) |
| Quản lý state | Provider hoặc Riverpod (tùy chọn) |

### Luồng dữ liệu
1. **Khởi động** → Kiểm tra token trong Secure Storage → Nếu có, tự động refresh Firebase.
2. **Nếu chưa đăng nhập** → GoRouter chặn và chuyển đến màn hình Login/Register.
3. **Đăng nhập thành công** → Lưu token vào Secure Storage → Chuyển đến màn hình chính.
4. **Tại màn hình chính**:
   - Gọi Cat API `/breeds` → Parse JSON → Lấy `reference_image_id` → Gọi tiếp `/images/search?breed_ids=...` để lấy URL ảnh (hoặc cache sẵn).
   - Hiển thị danh sách theo chế độ Grid/List đã lưu.
5. **Yêu thích** → Bấm tim → Lưu vào Sqflite (bảng `favorites` với `id`, `breed_name`, `image_url`, `breed_type`).
6. **Chế độ ngoại tuyến** → Truy vấn Sqflite hiển thị danh sách yêu thích.

### Bảo mật dữ liệu
- Mật khẩu và token không bao giờ được lưu dạng plaintext – luôn được mã hóa bởi **Flutter Secure Storage**.
- Firebase Authentication đảm bảo chỉ người dùng hợp lệ mới truy cập được nội dung.

---

## 🖥️ Hướng dẫn sử dụng

1. **Tải ứng dụng** về thiết bị (chạy trên iOS, Android, Web hoặc Desktop).
2. **Đăng ký** tài khoản bằng email và mật khẩu.
3. **Đăng nhập** – ứng dụng sẽ tự động lưu token để lần sau không cần nhập lại.
4. **Khám phá** danh sách các giống mèo, cuộn để xem ảnh và thông tin.
5. **Thả tim** cho những chú mèo bạn yêu thích – chúng sẽ được lưu vào mục "Yêu thích".
6. **Tùy chỉnh** giao diện bằng cách chuyển đổi giữa lưới/danh sách hoặc đổi màu chủ đề.
7. **Tắt mạng** và mở "Yêu thích" để thấy danh sách vẫn đầy đủ.
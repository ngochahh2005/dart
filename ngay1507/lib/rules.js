/*
    1. Các từ khóa quan trọng
    Từ khóa	        |                        Ý nghĩa
    ================|================================================================================
    .read	        |    Cho phép đọc dữ liệu tại node này và các node con
    .write	        |    Cho phép ghi (tạo, sửa, xóa) tại node này và node con
    .validate	    |    Kiểm tra dữ liệu khi ghi (không ảnh hưởng đến quyền, chỉ kiểm tra hợp lệ)
    $variable	    |    Biến đại diện cho key động (ví dụ $uid, $chatId)
    auth	        |    Object thông tin xác thực (có uid, token, email...)
    data	        |    Dữ liệu hiện có tại node đó (trước khi ghi)
    newData	        |    Dữ liệu mới sẽ được ghi (khi dùng .write hoặc .validate)
    root	        |    Tham chiếu đến gốc của database
    now	            |    Thời gian hiện tại theo mili giây (dùng cho timestamp)

    2. Các mẫu rules phổ biến (dùng cho bài tập)
    2.1. Dữ liệu công khai (mọi người đều đọc và ghi)
    "public_data": {
      ".read": true,
      ".write": true
    }
    /!\ Chỉ dùng trong phát triển, không dùng production.

    2.2. Dữ liệu chỉ đọc, không ghi
    "static_info": {
      ".read": true,
      ".write": false
    }

    2.3. Chỉ user đã đăng nhập mới được đọc/ghi
    "user_posts": {
      ".read": "auth != null",
      ".write": "auth != null"
    }

    2.4. Mỗi user chỉ được truy cập dữ liệu của chính mình (dùng $uid)
    "users": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid"
      }
    }

    2.5. Dữ liệu có người sở hữu (owner) – chỉ owner mới được ghi, nhưng mọi người đọc
    "items": {
      "$itemId": {
        ".read": true,
        ".write": "data.child('owner').val() === auth.uid || newData.child('owner').val() === auth.uid"
      }
    }

    2.6. Chat – chỉ participants mới được đọc/ghi
    "chats": {
      "$chatId": {
        ".read": "data.child('participants').child(auth.uid).exists()",
        ".write": "data.child('participants').child(auth.uid).exists()"
      }
    }

    2.7. Chỉ cho phép tạo mới, không cho sửa/xóa (dùng newData và data)
    "logs": {
      "$logId": {
        ".write": "!data.exists() && newData.exists()", // chỉ tạo mới
        ".validate": "newData.hasChildren(['timestamp', 'message'])"
      }
    }

    2.8. Giới hạn kích thước hoặc số lượng con
    "posts": {
      ".write": "auth != null",
      "$postId": {
        ".validate": "newData.child('content').val().length < 1000"
      }
    }

    2.9. Đánh index để truy vấn nhanh (dùng .indexOn)
    "messages": {
      ".indexOn": ["timestamp", "senderId"],
      "$chatId": {
        ...
      }
    }

    3. Cách áp dụng cho các tình huống cụ thể
    a) Khi dùng Authentication
    - Luôn dùng auth.uid để xác định user.
    - Nếu cần kiểm tra email, dùng auth.token.email.

    b) Khi dữ liệu có quan hệ (ví dụ user tạo bài viết)
    - Lưu trường userId hoặc owner trong mỗi bản ghi.
    - Trong rules, kiểm tra newData.child('userId').val() === auth.uid để đảm bảo
    user chỉ tạo dữ liệu cho chính mình.

    c) Khi có tham chiếu chéo (ví dụ chat, nhóm)
    Dùng root để kiểm tra quyền ở node khác (như bạn đã làm với root.child('chats').child($chatId)...).

    d) Khi cần validate dữ liệu đầu vào
    Dùng .validate để kiểm tra kiểu, độ dài, giá trị, các trường bắt buộc.

    4. Cách test rules mà không cần deploy
        (1) Mở Firebase Console → Realtime Database → Rules.
        (2) Chọn Simulator (góc phải trên).
        (3) Nhập đường dẫn, loại thao tác (read/write), và thông tin xác thực (auth uid).
        (4) Xem kết quả (Allow/Deny).

    5. Hướng dẫn tự viết rules cho bài tập mới
    Khi bạn có yêu cầu cho một bài tập mới, hãy thực hiện các bước:
    (1) Xác định cấu trúc dữ liệu (có bao nhiêu node chính, quan hệ giữa chúng).
    (2) Xác định ai đọc/ghi:
        Public? Cần đăng nhập? Chỉ owner? Nhóm cụ thể?
    (3) Viết rules theo nguyên tắc:
        - Bắt đầu từ node gốc với .read/.write mặc định là false (khóa toàn bộ).
        - Mở dần quyền cho từng node con dựa trên logic.
        - Dùng $ cho key động.
        - Dùng auth.uid và data/newData để kiểm tra.
    (4) Thêm .validate để đảm bảo dữ liệu sạch (định dạng, kiểu, giá trị).
    (5) Thêm .indexOn nếu cần truy vấn theo trường nào đó (tối ưu hiệu năng).
*/

{
    "rules": {
        // Khai bao cac quy tac cho tung duong dan du lieu
        "node_1": {
            ".read": true,  // ai cung doc duoc
            ".write": false,    // khong ai ghi duoc
        },
        "node_2": {
            ".read": "auth != null",    // chi user da dang nhap
            ".write": "auth.uid == 'some_uid'"  // chi 1 uid cu the
        },
        "$dynamic_key": {
            // $dynamic_key la bien dai dien cho key bat ky
            ".read": "data.child('owner').val() == auth.uid"
        }
    }
}
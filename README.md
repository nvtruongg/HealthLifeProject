# HealthLife - E-Commerce Platform for Supplements & Pharmaceuticals

## Giới thiệu dự án
**HealthLife** là một ứng dụng web thương mại điện tử chuyên biệt phục vụ phân phối thực phẩm chức năng và dược phẩm bảo vệ sức khỏe. Dự án được phát triển nhằm giải quyết bài toán minh bạch thông tin sản phẩm và tối ưu hóa trải nghiệm mua sắm trực tuyến của người tiêu dùng trong bối cảnh nhu cầu chăm sóc sức khỏe ngày càng tăng cao.

Hệ thống được thiết kế và vận hành đồng bộ, phân tách rõ ràng giữa phân hệ **Khách hàng** (Tìm kiếm, bộ lọc động, giỏ hàng bất đồng bộ, thanh toán) và phân hệ **Quản trị - Admin Dashboard** (Quản lý sản phẩm, danh mục, kiểm soát kho và xử lý đơn hàng theo máy trạng thái)[cite: 6].

---

## Kiến trúc mã nguồn & Stack công nghệ
Dự án áp dụng mô hình kiến trúc **MVC (Model - View - Controller)** kết hợp **Kiến trúc 3 lớp (3-Layer Architecture)** chặt chẽ nhằm đảm bảo mã nguồn sạch (Clean Code), tính đơn trách nhiệm (Single Responsibility) và dễ dàng mở rộng, nâng cấp[cite: 6].

### 1. Stack công nghệ sử dụng:
*   **Backend Core:** Java Web (Servlets v4.0, JSP, JSTL)[cite: 6].
*   **Data Access Layer:** JDBC (Java Database Connectivity) truyền thống, kết nối hệ quản trị cơ sở dữ liệu **MySQL 8.0** (Tuân thủ chuẩn hóa 3NF, hỗ trợ giao dịch ACID)[cite: 6].
*   **Web Server:** Apache Tomcat 9.0 / 10.0 (Servlet Container)[cite: 6].
*   **Frontend UI:** HTML5, CSS3, JavaScript (ES6+), Bootstrap 5 Framework (Responsive Grid System)[cite: 6].
*   **Libraries & Protocols:** Giao thức **SMTP** (`javax.mail`) phục vụ dịch vụ mail tự động, **jQuery AJAX** xử lý tương tác bất đồng bộ[cite: 6].
*   **Tools:** NetBeans IDE, Git/GitHub, PlantUML[cite: 6].

### 2. Sơ đồ phân tách kiến trúc 3 lớp (3-Tier Packages):
*   `com.healthlife.controller`: Tiếp nhận HTTP Request, điều hướng dữ liệu và phản hồi HTTP Response[cite: 6].
*   `com.healthlife.service`: Xử lý toàn bộ logic nghiệp vụ (Kiểm tra tồn kho, tính toán dòng tiền, điều phối giao dịch)[cite: 6].
*   `com.healthlife.dal` (Data Access Object - DAO): Nơi duy nhất chứa mã nguồn JDBC và thực thi các truy vấn SQL xuống database thông qua `PreparedStatement`[cite: 6].

---

## Vai trò cá nhân & Các module đảm nhiệm
Trong dự án này, tôi đảm nhiệm vai trò **Project Lead & Core Developer**, trực tiếp chịu trách nhiệm thiết kế hệ thống phần mềm và lập trình các phân hệ cốt lõi[cite: 6]:

*   **Thiết kế & Kiến trúc:** Phân tích yêu cầu bài toán, trực tiếp thiết kế lược đồ quan hệ thực thể (ERD CSDL) gồm các bảng ràng buộc khóa ngoại chặt chẽ (`nguoi_dung`, `san_pham`, `don_hang`, `chi_tiet_don_hang`, `so_dia_chi`)[cite: 6]. Sử dụng PlantUML để mô tả luồng nghiệp vụ qua hệ thống sơ đồ Use Case và sơ đồ thiết kế hệ thống[cite: 6].
*   **Quản lý mã nguồn nhóm:** Thiết lập cấu trúc thư mục tiêu chuẩn, điều phối luồng làm việc nhóm (Git Workflow), quản lý phiên bản và trực tiếp xử lý xung đột mã nguồn (Merge conflicts) cho toàn nhóm[cite: 6].
*   **Phát triển Module Sản phẩm (Full-stack):** Lập trình trọn vẹn logic truy vấn và giao diện hiển thị cho phân hệ sản phẩm, áp dụng kỹ thuật phân trang phía máy chủ (**Server-side Pagination** với `LIMIT/OFFSET`) kết hợp với bộ lọc động đa tiêu chí[cite: 6].
*   **Phát triển Module Giỏ hàng (Cart) & Đặt hàng (Checkout):** Xây dựng luồng lưu trữ giỏ hàng động trong `HttpSession`. Thiết lập tiến trình Checkout kết nối sổ địa chỉ (`so_dia_chi`) và kiểm soát số lượng tồn kho (`so_luong_ton`) trước khi kích hoạt tạo đơn hàng[cite: 6].

---

## Giải pháp cho các thách thức kỹ thuật cốt lõi
Dự án tập trung giải quyết triệt để các bài toán logic nghiệp vụ phức tạp bằng tư duy lập trình thuần túy:

### 1. Đảm bảo toàn vẹn dữ liệu khi Thanh toán (ACID Transaction)
*   **Thách thức:** Rủi ro sai lệch dữ liệu nghiêm trọng nếu hệ thống tạo hóa đơn thành công nhưng quá trình trừ số lượng tồn kho trong database gặp sự cố (lỗi mạng, hết hàng đột xuất khi nhiều người nhấn mua cùng lúc)[cite: 6].
*   **Giải pháp:** Triển khai cơ chế **Database Transaction Management** ở tầng Service thông qua JDBC (`conn.setAutoCommit(false)`)[cite: 6]. Gom nhóm các thao tác ghi dữ liệu vào bảng `don_hang`, `chi_tiet_don_hang` và cập nhật `updateStock` vào một giao dịch đồng nhất[cite: 6]. Hệ thống chỉ kích hoạt `conn.commit()` khi mọi tác vụ thành công, và tự động gọi `conn.rollback()` ngay lập tức khi bắt được bất kỳ ngoại lệ (Exception) nào để hủy bỏ toàn bộ tiến trình lỗi[cite: 6].

### 2. Khắc phục lỗi phình to mã nguồn khi xử lý Bộ lọc động đa tiêu chí (Dynamic SQL)
*   **Thách thức:** Hệ thống hỗ trợ lọc sản phẩm theo tổ hợp nhiều điều kiện không cố định (Lọc theo danh mục, lọc theo khoảng giá, lọc theo thương hiệu, hoặc kết hợp cả ba)[cite: 6]. Nếu viết từng hàm DAO riêng lẻ cho từng tổ hợp sẽ dẫn đến hiện tượng phình to code (Code Bloat) và cực kỳ khó bảo trì[cite: 6].
*   **Giải pháp:** Ứng dụng kỹ thuật nội suy câu lệnh chứa biến **Dynamic SQL**. Xây dựng một hàm filter duy nhất ở tầng DAO, sử dụng `StringBuilder` và `List<Object>` để tự động kiểm tra điều kiện dữ liệu đầu vào (loại bỏ null/rỗng) và ghép nối linh hoạt các mệnh đề `WHERE ... AND ...` vào câu lệnh SQL gốc[cite: 6]. Việc truyền tham số qua `PreparedStatement` giúp ngăn chặn hoàn toàn lỗ hổng bảo mật SQL Injection[cite: 6].

### 3. Tối ưu hóa trải nghiệm người dùng với Giỏ hàng Real-time (AJAX)
*   **Thách thức:** Trải nghiệm người dùng (UX) bị gián đoạn, màn hình bị giật do trình duyệt phải tải lại toàn bộ trang (Reload page) mỗi khi khách hàng nhấn "Thêm vào giỏ hàng" hoặc điều chỉnh số lượng[cite: 6].
*   **Giải pháp:** Tích hợp công nghệ **jQuery AJAX** giao tiếp bất đồng bộ với Servlet Backend[cite: 6]. Servlet xử lý logic giỏ hàng trong Session và trả về dữ liệu định dạng **JSON** gồm trạng thái thành công và số lượng mới, giúp JavaScript cập nhật tức thời icon giỏ hàng và tổng tiền trên giao diện mà không cần reload trang[cite: 6].

---

## Cấu trúc thư mục nguồn tiêu chuẩn (NetBeans Web Architecture)
```text
HealthLife/
├── src/java/com/healthlife/
│   ├── controllers/      # Tầng giao diện điều hướng (Servlet Controller)[cite: 6]
│   ├── dao/              # Tầng tương tác CSDL gồm Interfaces & Implementations (JDBC)[cite: 6]
│   ├── services/         # Tầng xử lý Logic nghiệp vụ cốt lõi (Business Logic)[cite: 6]
│   └── models/           # Các lớp thực thể POJO mapping trực tiếp với MySQL Tables[cite: 6]
├── web/                  # Tài nguyên giao diện người dùng[cite: 6]
│   ├── assets/           # Tài nguyên tĩnh bao gồm css/, js/, images/[cite: 6]
│   ├── views/            # Các trang giao diện động JSP (User site & Admin site)[cite: 6]
│   └── WEB-INF/          # Tệp cấu hình bảo mật hệ thống web.xml[cite: 6]
└── database/             # Tệp tin script cấu trúc db db_healthlife.sql[cite: 6]

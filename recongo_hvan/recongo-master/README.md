# recongo

## Giới thiệu
Recongo là một công cụ giải quyết bài toán Cấu hình lại Tổ hợp (Combinatorial Reconfiguration Problems - CRPs) dựa trên phương pháp cấu hình lại tổ hợp có giới hạn (bounded combinatorial reconfiguration) kết hợp lập trình tập câu trả lời (Answer Set Programming - ASP).
Hệ thống sử dụng clingo - một bộ giải ASP tốc độ cao - làm bộ giải nền tảng (back-end solver).

### Giải thưởng đạt được
- [Kết quả CoRe Challenge 2022](https://core-challenge.github.io/2022result/): Recongo xếp hạng 1 trên chặng tìm lời giải ngắn nhất cho Bộ giải đơn (Single-engine Solvers shortest track), và đứng thứ 2 hoặc thứ 3 trên 5 tiêu chí đánh giá bộ giải khác.
- [Kết quả CoRe Challenge 2023](https://core-challenge.github.io/2023result/): Recongo xuất sắc xếp hạng 1 trên 5 tiêu chí và xếp hạng 2 trên 7 tiêu chí (tổng cộng 12 tiêu chí đánh giá!).

## Yêu cầu hệ thống
- python3 (phiên bản 3.8.3 trở lên)
- [clingo](https://potassco.org/clingo/) (phiên bản 5.6.2 trở lên)

---

## Hướng dẫn thực thi và Các kịch bản chạy mẫu

Cú pháp cơ bản của dự án yêu cầu truyền file logic (encoding) cùng các file dữ liệu (instance/benchmark/file bổ sung) vào script `recongo.py`.

### 1. Lệnh chạy cơ bản nhất (Tìm lời giải ngắn nhất)
Đây là câu lệnh cơ bản của hệ thống. Recongo sẽ xuất ra chuỗi bước cấu hình lại ngắn nhất nếu đích đến có thể tiếp cận được (reachable). Nếu không thể tiếp cận (unreachable), chương trình mặc định sẽ chạy vô hạn mà không dừng lại.

```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_nohints_inc.lp example/isrp/benchmark/original/isrp-ex.lp example/isrp/benchmark/original/isrp-ex_01.lp
```
<details><summary>Ví dụ kết quả đầu ra (Output example)</summary>

```
recongo version 0.3 (compet 2023 version)
Reading from encoding/isrp/isrpTJ_ex1_basic_inc.lp ...
c Step: 0
Solving...
c Result: UNSAT
c Step: 1
Solving...
c Result: UNSAT
c Step: 2
Solving...
c Result: UNSAT
c Step: 3
Solving...
Answer: 1
start(1) start(2) start(4) node(1) node(2) node(3) node(4) node(5) node(6) node(7) node(8) k(3) edge(1,3) edge(2,5) edge(3,4) edge(3,6) edge(4,5) edge(5,8) edge(6,7) edge(7,8) goal(3) goal(5) goal(7) n(8) e(8) in(1,0) in(2,0) in(4,0) in(7,1) token_added(7,1) in(1,1) in(2,1) in(3,2) in(7,2) in(2,2) token_added(3,2) query(3) in(3,3) in(5,3) in(7,3) token_added(5,3)
c Result: SAT
a Answer: start(1) start(2) start(4) in(1,0) in(2,0) in(4,0) in(1,1) in(2,1) in(7,1) in(2,2) in(3,2) in(7,2) in(3,3) in(5,3) in(7,3) node(1) node(2) node(3) node(4) node(5) node(6) node(7) node(8) k(3) edge(1,3) edge(2,5) edge(3,4) edge(3,6) edge(4,5) edge(5,8) edge(6,7) edge(7,8) token_added(7,1) token_added(3,2) token_added(5,3) query(3) goal(3) goal(5) goal(7) n(8) e(8)
s REACHABLE
a Step: 3 

SATISFIABLE

Models       : 1+
Calls        : 4
Time         : 0.006s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.005s

```

</details>

### 2. Kịch bản bổ sung yêu cầu mới (Tùy biến của bạn)

Khi bạn muốn giữ nguyên bộ dữ liệu gốc `isrp-ex_01.lp` nhưng áp dụng thêm các điều kiện hoặc ràng buộc mới, bạn chỉ cần truyền thêm các file `.lp` bổ sung vào cuối câu lệnh:

* **Trường hợp A: Thay đổi số bước đi ($k = 5$) và chặn đỉnh lỗi (đỉnh 6)**
Sử dụng kết hợp file dữ liệu gốc và file bổ sung `custom_steps_and_nodes.lp`:
```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_nohints_inc.lp example/isrp/benchmark/original/isrp-ex.lp example/isrp/benchmark/original/isrp-ex_01.lp custom_steps_and_nodes.lp

```


* **Trường hợp B: Thay đổi luật tính Đích (Goal linh hoạt - Đạt tối thiểu 4 đỉnh bất kỳ)**
Sử dụng kết hợp file dữ liệu gốc và file bổ sung `flexible_goal.lp`:
```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_nohints_inc.lp example/isrp/benchmark/original/isrp-ex.lp example/isrp/benchmark/original/isrp-ex_01.lp flexible_goal.lp

```


* **Trường hợp C: Áp dụng TẤT CẢ các yêu cầu tùy biến cùng lúc**
```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_nohints_inc.lp example/isrp/benchmark/original/isrp-ex.lp example/isrp/benchmark/original/isrp-ex_01.lp custom_steps_and_nodes.lp flexible_goal.lp

```



### 3. Đối với các trường hợp không thể tiếp cận (Unreachable)

Nếu bạn muốn giải các bài toán không có lời giải (unreachable), bạn phải sử dụng tùy chọn `--imax`. Recongo sẽ báo trạng thái `unreachable` nếu không tìm thấy chuỗi cấu hình nào có độ dài từ 0 đến $(\text{giá trị của imax}) - 1$.

Ví dụ dưới đây sử dụng giá trị `imax` bằng 6 (chính là số lượng tập độc lập khả thi của bộ dữ liệu `hc-toyno-01`):

```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_nohints_inc.lp example/isrp/benchmark/core_challenge2022_1st-benchmark/hc-toyno-01.lp example/isrp/benchmark/core_challenge2022_1st-benchmark/hc-toyno-01_01.lp --imax=6

```

<details><summary>Ví dụ kết quả đầu ra (Output Example)</summary>

```
recongo version 0.3 (compet 2023 version)
Reading from encoding/isrp/isrpTJ_ex1_basic_inc.lp ...
c Step: 0
Solving...
c Result: UNSAT
c Step: 1
Solving...
c Result: UNSAT
c Step: 2
Solving...
c Result: UNSAT
c Step: 3
Solving...
c Result: UNSAT
c Step: 4
Solving...
c Result: UNSAT
c Step: 5
Solving...
c Result: UNSAT
s UNREACHABLE
a Step: -1 

UNSATISFIABLE

Models       : 0
Calls        : 6
Time         : 0.008s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.006s

```

</details>

### 4. Đối với bài toán tìm chuỗi dài nhất (Longest CRPs)

Tại cuộc thi quốc tế CoRe Challenge 2022 và 2023 có một hạng mục tìm chuỗi cấu hình lại dài nhất. Bạn có thể giải quyết bài toán này bằng cách thêm tùy chọn `--isearch=longest` đi kèm tham số `--imax` để giới hạn phạm vi tìm kiếm (khuyến khích sử dụng nhằm tránh việc chương trình chạy không dừng).

```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_noloop_d1d2h_inc.lp example/isrp/benchmark/core_challenge2022_1st-benchmark/hc-toyyes-01.lp example/isrp/benchmark/core_challenge2022_1st-benchmark/hc-toyyes-01_01.lp --isearch=longest --imax=8

```

<details><summary>Ví dụ kết quả đầu ra (Output Example)</summary>

```
recongo version 0.3 (compet 2023 version)
Reading from ...g/isrpTJ_ex1_basic_noloop_d1d2h_inc.lp ...
c Step: 0
Solving...
c Result: UNSAT
c Step: 1
Solving...
c Result: UNSAT
c Step: 2
Solving...
c Result: UNSAT
c Step: 3
Solving...
Answer: 1
goal(4) goal(5) goal(7) start(3) start(6) start(7) in(7,0) in(3,0) in(6,0) in(7,1) in(6,1) in(1,1) in(5,2) in(7,2) in(1,2) in(4,3) in(5,3) in(7,3)
c Result: SAT
c Step: 4
Solving...
Answer: 1
goal(4) goal(5) goal(7) start(3) start(6) start(7) in(7,0) in(3,0) in(6,0) in(7,1) in(6,1) in(1,1) in(4,2) in(7,2) in(1,2) in(5,3) in(7,3) in(1,3) in(4,4) in(5,4) in(7,4)
c Result: SAT
c Step: 5
Solving...
Answer: 1
goal(4) goal(5) goal(7) start(3) start(6) start(7) in(7,0) in(3,0) in(6,0) in(7,1) in(6,1) in(1,1) in(5,2) in(7,2) in(1,2) in(4,3) in(7,3) in(1,3) in(4,4) in(5,4) in(1,4) in(4,5) in(5,5) in(7,5)
c Result: SAT
c Step: 6
Solving...
Answer: 1
goal(4) goal(5) goal(7) start(3) start(6) start(7) in(7,0) in(3,0) in(6,0) in(7,1) in(6,1) in(1,1) in(4,2) in(7,2) in(1,2) in(5,3) in(7,3) in(1,3) in(4,4) in(5,4) in(1,4) in(4,5) in(5,5) in(2,5) in(4,6) in(5,6) in(7,6)
c Result: SAT
c Step: 7
Solving...
c Result: UNSAT
a Answer: start(3) start(6) start(7) in(3,0) in(6,0) in(7,0) in(1,1) in(6,1) in(7,1) in(1,2) in(4,2) in(7,2) in(1,3) in(5,3) in(7,3) in(1,4) in(4,4) in(5,4) in(2,5) in(4,5) in(5,5) in(4,6) in(5,6) in(7,6) goal(4) goal(5) goal(7)
s REACHABLE
a Step: 6 

UNSATISFIABLE

Models       : 4
Calls        : 8
Time         : 0.015s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.015s

```

</details>

*Vui lòng sử dụng tùy chọn `-h` hoặc `--help` để xem thêm thông tin chi tiết về các tham số khác.*

# Chạy thử nghiệm hệ thống có giới hạn tài nguyên khắt khe:
```bash
python recongo.py example/isrp/encoding/isrpTJ_ex1_basic_nohints_inc.lp example/isrp/benchmark/original/isrp-ex.lp example/isrp/benchmark/original/isrp-ex_01.lp resource_constraint.lp
```


---

## Cấu trúc thư mục (Directory)

Vui lòng xem file `README` nằm trong từng thư mục cụ thể để biết thêm chi tiết.

### example

* Thư mục này chứa các bộ dữ liệu mẫu (benchmarks), các file thiết lập logic (encodings) và các chương trình tiện ích bổ trợ cho một số bài toán cấu hình lại tổ hợp.

## Các lỗi đã biết (Known issues)

* Recongo đôi khi không xuất ra kết quả hiển thị khi tiến trình bị ngắt đột ngột bằng tín hiệu hệ thống (signal interrupted).

## Liên kết ngoài

* [CoRe Challenge 2022](https://core-challenge.github.io/2022/) - Nơi bạn có thể tải thêm nhiều bộ dữ liệu (instances) cho bài toán ISRP.
* [CoRe Challenge 2023](https://core-challenge.github.io/2023/)
* [Hamiltonian Cycle Reconfiguration](https://github.com/banbaralab/hcr) - Nơi cung cấp bộ dữ liệu kiểm thử và mã hóa ASP cho bài toán chu trình Hamiltonian và bài toán cấu hình lại chu trình Hamiltonian (HCRP). (Lưu ý: Bộ giải tại đây dựa trên phiên bản recongo cũ, nhưng dữ liệu và file encoding cho HCRP vẫn dùng tốt với phiên bản recongo này).

```

```

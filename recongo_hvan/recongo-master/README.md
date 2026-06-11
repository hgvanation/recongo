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

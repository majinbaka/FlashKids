# 08 — Parent Zone & parent gate

> `design.md` §1: "The two zones must be visually distinguishable within one
> second." Mục tiêu của file này là **giữ Parent Zone trông chán** — đó là tính
> năng, không phải thiếu sót. Kết luận: vùng này **không cần file ảnh nào**.

## Dùng ở đâu
Màn hình cài đặt, tiến độ/báo cáo cho phụ huynh, và **parent gate**
(`design.md` §9).

## Ràng buộc cứng
- **Không mascot, không nhân vật, không confetti, không pastel rực.** Bất kỳ ảnh
  nào ở đây mà trông vui như Kid Zone là **lỗi thiết kế** (`design.md` §1).
- Bảng màu thu hẹp: `secondary #635B70`, `secondaryContainer #E9DEF8`,
  `outline #7A757F`, `outlineVariant #CBC4CF`, `surface #FEF7FF`.
- Kích thước nhỏ: spot illustration, không phải hero.
- **Cơ chế thử thách của parent gate chưa được quyết** (`design.md` §9, §12).
  Prompt dưới đây cố tình **không vẽ ra thử thách nào** — chỉ vẽ ẩn dụ "khu vực
  người lớn". Đừng để ảnh quyết định hộ cơ chế.

> ### 🔧 VẼ BẰNG CODE — không xuất file ảnh (5 asset)
>
> Cả năm spot illustration của Parent Zone nên dùng **Material Icons** đã có sẵn
> (`uses-material-design: true` trong `pubspec.yaml`), phóng to và tô bằng
> `ColorScheme` role:
>
> | Asset | Icon Material | Màu |
> |---|---|---|
> | `parent-settings` | `Icons.tune_rounded` | `secondary #635B70` |
> | `parent-progress` | `Icons.bar_chart_rounded` | `secondary #635B70` |
> | `parent-account` | `Icons.account_circle_outlined` | `secondary #635B70` |
> | `parent-gate` | `Icons.lock_outline_rounded` | `secondary #635B70` |
> | `parent-empty-data` | `Icons.insert_chart_outlined_rounded` | `outline #7A757F` |
>
> Đây không phải cắt giảm — nó **củng cố** `design.md` §1: Parent Zone phải
> "compact, text-led, and plainly utilitarian". Icon hệ thống mặc định *chính
> là* diện mạo đúng cho vùng này. Minh hoạ riêng vẽ tay sẽ kéo Parent Zone về
> phía Kid Zone, đúng thứ §1 gọi là lỗi thiết kế.
>
> Prompt bên dưới chỉ dùng nếu bạn quyết định Parent Zone cần bộ minh hoạ riêng
> — đó là một quyết định thiết kế, không phải mặc định.

## Prompt (dự phòng) — spot illustration Parent Zone

```text
A small neutral spot illustration of {{OBJECT}}, minimal and utilitarian,
restrained palette of muted grey-violet #635B70, light lavender #E9DEF8 and
soft grey #CBC4CF only, plain transparent background, compact centered
composition, medium even stroke weight, adult-oriented and plain.

STYLE: flat vector, minimal, geometric, soft rounded corners, matte flat fills,
quiet, informational, no decoration, no personality.
NEGATIVE: text, letters, numbers, watermark, logo, mascot, animal, character,
face, cute, playful, confetti, stars, sparkles, bright or pastel-rich colors,
neon, red alarm colors, warning triangle, photorealism, 3D render, glossy, heavy
drop shadow, gradient mesh.
```

| Asset | `{{OBJECT}}` | Màn hình |
|---|---|---|
| `parent-settings` | a rounded sliders panel with three horizontal tracks and round handles | cài đặt |
| `parent-progress` | a simple rounded bar chart with four bars of different heights | tiến độ |
| `parent-account` | a rounded person silhouette inside a rounded square frame | tài khoản |
| `parent-gate` | a rounded closed door shape with a small round handle, calm and plain | cổng phụ huynh |
| `parent-empty-data` | a rounded chart frame with a flat baseline and no bars | chưa có dữ liệu |

## Ghi chú về ảnh `parent-gate`
Cánh cửa là ẩn dụ, **không phải giao diện thử thách**. Bản thân cổng phải:
- là **hành động có chủ ý của người lớn**, không phải một cú chạm "Bạn chắc chứ?"
- nằm **xa các nút trẻ hay chạm** (`design.md` §9, §5 Reachability)
- **dùng được bằng screen reader** cho người lớn khiếm thị — nghĩa là thử thách
  không được nằm trong ảnh, phải là widget có `Semantics` đầy đủ.

Nếu một ngày ảnh này chứa nội dung thử thách, đó là dấu hiệu cơ chế đã bị quyết
lén — dừng và hỏi (`AGENTS.md` → Conflicts).

## Kiểm tra trước khi nhận
- [ ] Đặt cạnh một ảnh Kid Zone: khác nhau ngay lập tức về độ vui, độ dày nét,
      độ bão hoà, kích thước.
- [ ] Không có gì đáng yêu. Nghiêm túc — đây là tiêu chí đạt/không đạt.
- [ ] Không mã màu nào ngoài bảng thu hẹp ở trên.
- [ ] Tương phản ≥ 3:1 trên `#FEF7FF`.
- [ ] `ExcludeSemantics`; nội dung có nghĩa nằm ở text Parent Zone.

## Export
**Không có file nào** ở cấu hình mặc định — dùng Material Icons, xem callout đầu
file. Nếu bạn duyệt bộ minh hoạ riêng: `parent-{name}.png`, 1:1, 256 px, nền
trong suốt.

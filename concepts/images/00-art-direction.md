# 00 — Art direction (khối style dùng chung)

> **Trạng thái: ĐỀ XUẤT, chưa được duyệt.** `design.md` §12 ghi rõ "Mascot,
> illustration style guide, and where art assets come from" là **deliberately
> undecided**. File này *đề xuất* style guide đó. Nó chỉ trở thành chuẩn khi bạn
> duyệt và ghi quyết định vào `design.md` (§3 Illustration + §12) trong cùng một
> change. Trước khi được duyệt, không dùng nó để biện minh cho việc thêm asset
> vào repo.

Đọc kèm: `design.md` §2 (nguyên tắc), §3 (visual language), §4 (color), §6
(component vocabulary), §11 (UI DoD).

---

## 1. Palette gốc — lấy từ code, không phải phỏng đoán

Đo trực tiếp từ `ColorScheme.fromSeed(seedColor: Colors.deepPurple)` như
`FlashKidsApp.build` trong `lib/main.dart` đang cấu hình (Material 3, light-only).

| Role | Hex | Vai trò trong tranh |
|---|---|---|
| `surface` | `#FEF7FF` | nền trang — nền mặc định của mọi minh hoạ |
| `surfaceContainerLow` | `#F8F1FA` | nền thẻ nhạt |
| `surfaceContainer` | `#F2ECF4` | nền nhóm |
| `surfaceContainerHigh` | `#EDE6EE` | nền thẻ nổi |
| `primary` | `#68548E` | tím chủ đạo — nét chính, khối lớn |
| `onPrimary` | `#FFFFFF` | hình trên nền tím |
| `primaryContainer` | `#EBDDFF` | lavender — mảng nền mềm, bầu trời, bóng nước |
| `onPrimaryContainer` | `#4F3D74` | tím đậm — nét viền, mắt, chi tiết |
| `secondary` | `#635B70` | xám tím — vật thể phụ, nền xa |
| `secondaryContainer` | `#E9DEF8` | mảng phụ nhạt |
| `tertiary` | `#7E525D` | hồng nâu — accent ấm |
| `tertiaryContainer` | `#FFD9E1` | hồng phấn — má, hoa, điểm nhấn vui |
| `error` | `#BA1A1A` | **không dùng cho tranh trẻ em** (xem §4 bên dưới) |
| `errorContainer` | `#FFDAD6` | hồng cam rất nhạt — "thử lại", không báo động |
| `outline` | `#7A757F` | viền phụ |
| `outlineVariant` | `#CBC4CF` | viền rất nhẹ |
| `onSurface` | `#1D1B20` | mực đậm nhất được phép |

**Màu "đúng / positive" chưa được quyết.** `design.md` §4 nói positive feedback
dùng "the theme's success-side accent", nhưng `ColorScheme` của Material 3 không
có role `success` và theme trong `lib/main.dart` chưa map nó. Mọi prompt bên dưới
để placeholder `{{SUCCESS_ACCENT}}`.
**Đề xuất:** xanh lá dịu `#4C6B4F` (chữ/hình trên nền sáng) + container
`#CDE9CE`. **Phải chốt trong theme trước, rồi mới thay vào prompt** — widget và
tranh không được tự quyết "đúng" trông thế nào (`design.md` §4).

Palette mở rộng cho nội dung thẻ (động vật, đồ vật…) được phép đi ra ngoài bảng
trên, nhưng phải **cùng độ bão hoà**: pastel ấm, không neon, không huỳnh quang.

---

## 2. Khối STYLE dùng chung — dán vào mọi prompt

```text
STYLE: flat vector illustration, modern picture-book aesthetic, one clearly
silhouetted subject, bold simple geometric shapes with soft rounded corners
everywhere and no sharp 90-degree corners, thick friendly forms, matte flat
color fills with at most a two-stop soft tint, optional subtle paper grain,
generous negative space around the subject, centered composition, even soft
lighting, at most one very soft ambient shadow, warm calm palette: cream white
#FEF7FF background, soft violet #68548E, lavender #EBDDFF, deep violet detail
#4F3D74, muted rose #FFD9E1, warm plum accent #7E525D, hand-made friendly,
storybook not game-console, bright but never neon, readable as a silhouette at
48x48 px, child-safe, gender-neutral, inclusive.
```

## 3. Khối NEGATIVE dùng chung — dán vào mọi prompt

```text
NEGATIVE: text, letters, numbers, words, captions, watermark, signature, logo,
UI chrome, buttons, frames, busy or detailed background, background clutter,
multiple competing subjects, cropped subject, neon or fluorescent saturation,
dark or moody tone, night scene, photorealism, 3D render, glossy plastic,
metallic shine, heavy drop shadows, gradient mesh, airbrush, hairline thin
strokes, tiny unreadable details, harsh red alarm colors, warning triangles,
crying, scolding, sad or scared expressions, sharp teeth, claws, weapons, fire,
blood, horror, arcade or casino aesthetic, slot-machine confetti, existing brand
mascots or characters, cultural or gender stereotypes, realistic human faces.
```

**Vì sao "no text" là bắt buộc:** `design.md` §8 — không có literal nào hiện ra
màn hình mà không đi qua lớp localization. Chữ nướng chết vào file ảnh là chữ
không dịch được.

---

## 4. Bảy ràng buộc mà mọi ảnh phải qua

1. **Nhận ra trong một cái liếc, ở kích thước nhỏ** (`design.md` §3). Test:
   thu về 48×48 px, vẫn phải đoán được đó là con gì / cái gì.
2. **Nền phẳng, không rối** — không bao giờ có hoạ tiết dày dưới chỗ sẽ đặt chữ.
3. **Không bao giờ chỉ dùng màu để mang nghĩa** (`design.md` §4). "Đúng",
   "sai", "đã khoá", "đã xong" phải có thêm hình dạng/biểu tượng/tư thế riêng —
   giả định đứa trẻ không phân biệt được hai màu của bạn.
4. **Tương phản AA đo trên nền thật** `#FEF7FF`: 3:1 cho hình đồ hoạ mang nghĩa,
   4.5:1 cho bất kỳ nét mảnh nào. Pastel quá nhạt là chỗ hay vỡ nhất.
5. **Không có gì giống nút bấm** trong ảnh. Nút là widget, không phải tranh —
   nếu tranh vẽ ra một vật trông bấm được, trẻ sẽ bấm vào chỗ chết.
6. **Sai không bị mắng** (`design.md` §2.4). Không mặt buồn, không nước mắt,
   không dấu X đỏ, không tông báo động.
7. **Light-only.** App chưa có dark mode và `design.md` §4 cấm làm nửa vời. Xuất
   PNG nền trong suốt để sau này không bị chặn, nhưng **không** làm biến thể tối.

---

## 5. Kỹ thuật xuất file (đề xuất — pipeline chưa tồn tại)

`pubspec.yaml` hiện **không có mục `assets:`** và không có `flutter_svg`. Cả
đường đi của asset lẫn định dạng đều thuộc §12 "undecided". Đề xuất:

- PNG nền trong suốt, sRGB, xuất `@1x / @2x / @3x` theo quy ước Flutter.
- Vuông 1:1 cho subject; 4:3 cho scene; 16:9 cho hero.
- Đặt tên `kebab-case`, tiền tố theo nhóm: `mascot-cheer.png`,
  `card-animal-cat.png`, `state-empty.png`.
- Ảnh trang trí luôn được bọc `ExcludeSemantics`; ảnh mang thông tin phải có
  `Semantics.label` từ lớp localization (`design.md` §3, §8).

---

## 6. Cách dùng các file prompt còn lại

Mỗi file trong thư mục này tự đứng độc lập: prompt đã nhúng sẵn khối STYLE và
NEGATIVE, dán thẳng vào công cụ sinh ảnh là chạy. Chỗ nào có `{{...}}` là chỗ bạn
thay giá trị trước khi chạy.

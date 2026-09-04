# 03 — Bìa bộ thẻ (Deck tile)

## Dùng ở đâu
Thành phần **Deck tile** (`design.md` §6) — điểm vào một bộ thẻ. Bốn trạng thái
bắt buộc: `available`, `in-progress`, `completed`, `locked`.

## Ràng buộc quyết định hình
- Deck tile là **ô bấm được**, nên tranh phải chừa chỗ cho chữ tên bộ thẻ do
  widget vẽ. Tranh **không được rối ở nửa dưới** (`design.md` §3).
- `locked` phải có **cả icon khoá lẫn styling mờ** — không chỉ mờ đi
  (`design.md` §6, §4 "color is never the only channel").
- Trạng thái là **việc của widget**, không nướng vào ảnh: xuất **một** ảnh nền
  cho mỗi bộ, còn overlay khoá / tick hoàn thành / vòng tiến độ do Flutter vẽ.
  Như vậy 4 trạng thái luôn khớp nhau và đổi theme không phải vẽ lại.

## Prompt — bìa bộ thẻ

```text
A simple decorative cover illustration for a children's flashcard deck about
{{TOPIC}}, a small friendly cluster of three to four {{TOPIC_OBJECTS}} arranged
in the upper two thirds of a 4:3 frame, lower third left visually calm and
almost empty for a label, soft lavender #EBDDFF rounded backdrop shape behind
the cluster, cream white #FEF7FF outer background.

STYLE: flat vector illustration, modern picture-book aesthetic, bold simple
geometric shapes with soft rounded corners and no sharp 90-degree corners, matte
flat color fills, subtle paper grain, generous negative space, even soft
lighting, warm pastel palette built on soft violet #68548E, lavender #EBDDFF,
deep violet detail #4F3D74, muted rose #FFD9E1, warm plum #7E525D, bright but
never neon, calm and inviting, child-safe.

NEGATIVE: text, letters, numbers, labels, watermark, logo, UI chrome, buttons,
badges, frames, borders, busy background, clutter, crowded composition, neon
saturation, dark tone, photorealism, 3D render, glossy plastic, heavy drop
shadow, gradient mesh, hairline strokes, tiny details, arcade aesthetic, lock
icons, checkmarks, stars, progress bars.
```

> `NEGATIVE` cố tình cấm khoá / tick / sao: những thứ đó là **trạng thái**, do
> widget vẽ chồng lên, không thuộc về ảnh.

## Bảng sinh

| Deck | `{{TOPIC}}` | `{{TOPIC_OBJECTS}}` |
|---|---|---|
| Động vật quen | farm and home animals | a cat, a duck and a cow |
| Động vật hoang dã | wild animals | a lion, a giraffe and a turtle |
| Trái cây | fruits | an apple, a banana and grapes |
| Đồ ăn | everyday food | a bread loaf, an egg and a milk glass |
| Phương tiện | vehicles | a car, a boat and an airplane |
| Đồ trong nhà | household objects | a cup, a book and a lamp |
| Thiên nhiên | nature and weather | a sun, a cloud and a tree |
| Hình khối | shapes | a circle, a triangle and a star shape |

## Lớp trạng thái (widget vẽ, không phải ảnh)

| Trạng thái | Kênh 1 (màu) | Kênh 2 (bắt buộc) |
|---|---|---|
| available | nền `surfaceContainerLow` | ảnh bìa đủ độ đậm |
| in-progress | viền `primary` | vòng/thanh tiến độ + số đếm |
| completed | nền container `#CDE9CE` | dấu tick + ảnh bìa giữ nguyên độ đậm |
| locked | giảm opacity lớp ảnh | **icon khoá đặc, nằm giữa** |

Accent hoàn thành là `#4C6B4F`; widget feedback đầu tiên sẽ ánh xạ nó trong theme.

## Kiểm tra trước khi nhận
- [ ] Nửa dưới khung đủ trống để đặt 2 dòng chữ dài (thử với chuỗi dịch dài nhất).
- [ ] Tương phản chữ trên vùng đặt chữ ≥ 4.5:1.
- [ ] Ở opacity của trạng thái `locked`, ảnh **không** còn trông bấm được, nhưng
      icon khoá vẫn ≥ 3:1 tương phản.
- [ ] 8 bìa xếp thành lưới trông như **một bộ**, không phải 8 phong cách.
- [ ] Ảnh bìa là trang trí ⇒ `ExcludeSemantics`; tên bộ thẻ mới là node ngữ nghĩa.

## Export
`deck-cover-{topic}.png`, 4:3, 1200×900 px, nền trong suốt.

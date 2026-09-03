# 02 — Minh hoạ nội dung thẻ (asset lớn nhất)

> **Đề xuất.** `design.md` §12 để ngỏ cả "card content domains (letters,
> numbers, vocabulary, language pairs)" lẫn nguồn asset. Danh sách chủ đề dưới
> đây là **gợi ý để bắt đầu**, không phải quyết định nội dung sản phẩm.

## Dùng ở đâu
Thành phần **Flashcard** (`design.md` §6) — mặt tranh chính, vật thể tiêu điểm
duy nhất giữa màn hình, xung quanh là khoảng trống (`design.md` §3 Composition).

## Nguyên tắc riêng của nhóm này
- **Một vật thể, một nghĩa.** Trẻ phải gọi tên được ngay. Con mèo là con mèo,
  không phải "con mèo đang ngồi trên hàng rào cạnh cái cây".
- **Không bối cảnh.** Nền phẳng để chữ (nếu có) đặt lên vẫn đủ tương phản.
- **Nhìn chính diện hoặc nghiêng 3/4**, tư thế trung tính, không cắt xén.
- **Cùng một tỉ lệ thị giác** giữa các thẻ: con voi và con kiến chiếm gần bằng
  nhau trong khung, nếu không bộ thẻ sẽ nhảy loạn khi lật.

## Prompt mẫu (template)

Thay `{{SUBJECT}}`, giữ nguyên phần còn lại — đó là thứ giữ cả bộ thẻ đồng bộ.

```text
A single {{SUBJECT}}, centered, front or three-quarter view, neutral friendly
pose, filling about 70 percent of a square frame, plain solid cream white
#FEF7FF background, no scenery, no props, no ground line.

STYLE: flat vector illustration, modern picture-book aesthetic, one clearly
silhouetted subject, bold simple geometric shapes with soft rounded corners and
no sharp 90-degree corners, matte flat color fills, subtle paper grain, generous
negative space, even soft lighting, one very soft ambient shadow, warm pastel
palette in the same saturation family as soft violet #68548E, lavender #EBDDFF,
muted rose #FFD9E1 and warm plum #7E525D, bright but never neon, recognizable as
a silhouette at 48x48 px, child-safe.

NEGATIVE: text, letters, numbers, labels, watermark, logo, UI chrome, busy or
detailed background, scenery, clutter, multiple subjects, cropped subject, neon
saturation, dark tone, photorealism, 3D render, glossy plastic, heavy drop
shadow, gradient mesh, hairline strokes, tiny details, scary expression, sharp
teeth, weapons, realistic human face.
```

## Danh sách chủ đề gợi ý (mỗi bộ 12–16 thẻ)

| Bộ | `{{SUBJECT}}` ví dụ |
|---|---|
| Động vật quen | cat, dog, cow, duck, fish, rabbit, bird, horse, sheep, pig, frog, bee |
| Động vật hoang dã | lion, elephant, giraffe, monkey, bear, zebra, penguin, turtle, whale, owl |
| Trái cây & rau | apple, banana, orange, grapes, watermelon, carrot, tomato, corn, strawberry |
| Đồ ăn hằng ngày | bread, egg, rice bowl, milk glass, noodle bowl, cake slice, cheese wedge |
| Phương tiện | car, bus, bicycle, train, airplane, boat, truck, helicopter, scooter |
| Đồ vật trong nhà | chair, cup, spoon, book, clock, lamp, key, umbrella, toothbrush, ball |
| Thiên nhiên & thời tiết | sun, cloud, rain drop, rainbow, tree, flower, leaf, moon, star, snowflake |
| Hình khối | circle, square, triangle, star shape, heart, oval — **mỗi hình khác nhau cả về hình lẫn màu** (`design.md` §4) |
| Hành động (khó nhất) | a child sleeping, a child running, a child eating, a child washing hands — dáng người tối giản, không mặt chi tiết |
| Bộ phận cơ thể | hand, foot, eye, ear, nose, mouth — tối giản, không giải phẫu |

**Chữ cái và chữ số: không sinh bằng AI.** Ký tự phải là text thật do lớp
localization và theme typography vẽ ra (`design.md` §8, `flutter-l10n`) — ảnh
chữ sẽ vỡ khi đổi ngôn ngữ và khi người dùng tăng cỡ chữ 200% (`design.md` §5).

## Bẫy hay gặp
- Model hay thêm bóng đổ dài và đường chân trời → luôn giữ `no ground line`.
- Model hay vẽ hai con vật → `NEGATIVE: multiple subjects` là bắt buộc.
- Chủ đề "hành động" hay ra mặt người thật → thêm
  `simple faceless or minimal-dot-eyes child figure`.
- Với chủ đề dễ nhầm (rabbit vs. hare, ship vs. boat) sinh 4 biến thể rồi để
  **một người lớn không đọc chú thích** đoán — đoán sai là thẻ hỏng.

## Kiểm tra trước khi nhận
- [ ] Thu 48×48 px vẫn gọi tên được.
- [ ] Đặt 12 thẻ cùng bộ cạnh nhau: cùng tỉ lệ chiếm khung, cùng độ bão hoà.
- [ ] Không thẻ nào có chữ, số, hay watermark.
- [ ] Tương phản chủ thể ≥ 3:1 trên `#FEF7FF`.
- [ ] Không chi tiết nào mỏng dưới 2 px ở kích thước hiển thị nhỏ nhất.
- [ ] Ảnh mang thông tin ⇒ **bắt buộc** `Semantics.label` từ localization,
      không dùng `ExcludeSemantics` (`design.md` §11).

## Export
`card-{bộ}-{subject}.png`, 1:1, 1024 px gốc, nền trong suốt — nền do widget vẽ
bằng `surfaceContainer*` để thẻ đổi được nền theo trạng thái.

# 07 — Onboarding, màn hình chào, avatar hồ sơ

> **Đề xuất có điều kiện.** `design.md` §12: "Onboarding, profiles/multiple
> children… deliberately undecided". Nhóm ảnh này **chỉ sinh khi bạn đã quyết có
> onboarding và có hồ sơ nhiều trẻ**. Đừng vẽ trước một luồng chưa tồn tại.

## Dùng ở đâu
Màn hình chào lần đầu, chọn hồ sơ trẻ.

## Prompt A — hero màn hình chào

```text
A warm welcoming scene for a children's learning app: the baby sloth mascot
standing at the center-left waving one paw, three large rounded flashcard shapes
floating in a gentle arc to its right at slightly different angles, each card a
plain solid lavender #EBDDFF rectangle with very rounded corners and no content
on it, cream white #FEF7FF background, wide airy composition, lots of empty space
in the lower third.

STYLE: flat vector illustration, modern picture-book aesthetic, bold simple
geometric shapes with soft rounded corners and no sharp 90-degree corners, matte
flat color fills, subtle paper grain, generous negative space, even soft
lighting, warm palette of soft violet #68548E, lavender #EBDDFF, deep violet
#4F3D74, muted rose #FFD9E1, calm and inviting, child-safe.

NEGATIVE: text, letters, numbers, alphabet, watermark, logo, UI chrome, real
buttons, app store frames, phone mockup, busy background, clutter, neon
saturation, dark tone, photorealism, 3D render, glossy plastic, heavy drop
shadow, gradient mesh, realistic human face.
```

> Thẻ trong hero **để trống** là cố ý: chữ và tranh thật sẽ do app vẽ, và một
> hero có chữ nướng sẵn là hero không dịch được (`design.md` §8).

## Prompt B — avatar hồ sơ trẻ (bộ 8–12)

Avatar phải để **trẻ chưa biết đọc tự nhận ra hồ sơ của mình** → mỗi cái phải
khác nhau về **hình dáng**, không chỉ khác màu (`design.md` §4).

```text
A simple round avatar icon of {{CREATURE}}, head only, front-facing, friendly
neutral smile, two simple dot eyes, filling most of a circular frame, solid
{{BG_COLOR}} circular background, thick chunky shapes.

STYLE: flat vector, minimal, geometric, soft rounded, matte flat fills, no
outline or one thick even outline, readable at 40x40 px, distinct silhouette,
child-safe, gender-neutral.
NEGATIVE: text, letters, numbers, watermark, UI chrome, busy background,
accessories, hats, glasses, tiny details, hairline strokes, neon saturation,
photorealism, 3D render, glossy, heavy shadow, gradient, scary, sharp teeth,
realistic human face.
```

| `{{CREATURE}}` | `{{BG_COLOR}}` |
|---|---|
| a cat | `#EBDDFF` |
| a bear | `#FFD9E1` |
| a frog | `#E9DEF8` |
| a bird | `#F2ECF4` |
| a rabbit | `#EBDDFF` |
| an owl | `#FFD9E1` |
| a fish | `#E9DEF8` |
| a turtle | `#F2ECF4` |
| a bee | `#EBDDFF` |
| a panda | `#FFD9E1` |
| a dinosaur | `#E9DEF8` |
| a whale | `#F2ECF4` |

Màu nền lặp lại là **có chủ ý**: nếu màu là kênh duy nhất thì 12 màu pastel gần
nhau sẽ không phân biệt nổi. Silhouette mới là kênh chính.

## Prompt C — minh hoạ từng bước onboarding (3 bước)

```text
{{STEP_SCENE}}, cream white #FEF7FF background, one idea only, composition in
the upper two thirds of a 4:3 frame.

STYLE: (như Prompt A)
NEGATIVE: (như Prompt A)
```

| Bước | `{{STEP_SCENE}}` |
|---|---|
| 1 — chọn bộ thẻ | The baby sloth mascot pointing at three large rounded blank cards laid side by side |
| 2 — chạm để trả lời | The baby sloth mascot touching one large rounded blank card with a paw, a soft lavender ripple ring around the touch point |
| 3 — nghe âm thanh | The baby sloth mascot with one paw cupped near its ear, three soft rounded sound-wave arcs beside it |

## Kiểm tra trước khi nhận
- [ ] 12 avatar ở 40×40 px: **phân biệt được khi in đen trắng**.
- [ ] Hero và 3 bước onboarding không chứa chữ, số, hay chữ cái.
- [ ] Nửa dưới hero trống đủ cho tiêu đề + nút ở 200% text scale.
- [ ] Hero/onboarding là trang trí ⇒ `ExcludeSemantics`; avatar mang danh tính
      hồ sơ ⇒ cần `Semantics.label` từ localization ("hồ sơ con mèo"), không
      phải "ảnh avatar 3".

## Export
`onboarding-hero.png` (16:9, 1920×1080) · `onboarding-step-{n}.png` (4:3,
1200×900) · `avatar-{creature}.png` (1:1, 256 px). Nền trong suốt trừ avatar
(giữ đĩa nền tròn).

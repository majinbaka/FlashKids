# 05 — Tiến độ, huy hiệu, sticker thưởng

## Dùng ở đâu
Thành phần **Progress indicator** và **Session summary** (`design.md` §6).

## Ràng buộc quyết định hình
- `design.md` §2.5: **thưởng cho nỗ lực, không chỉ cho đúng.** Huy hiệu phải nói
  "con đã làm xong", không phải "con được 8/10". Không có hạng, không có điểm số
  làm trẻ xấu hổ.
- `design.md` §6: tiến độ phải **đọc được mà không cần số** → hình dạng, không
  chỉ con số.
- Không dùng cơ chế mạng/tim (`design.md` §2.4) → **cấm sinh icon trái tim làm
  mạng sống**. Tim chỉ được dùng như sticker vui.

## Prompt A — chuỗi bước tiến độ

> ### 🔧 VẼ BẰNG CODE — không xuất file ảnh (3 asset)
>
> Ba marker là vòng tròn rỗng, vòng tròn có lõi, và vòng tròn có khấc tick.
> Dựng bằng `Container` + `BoxDecoration(shape: BoxShape.circle)` và một `Icon`
> cho khấc tick. Lý do không dùng PNG:
> - marker phải **đổi trạng thái liên tục trong lúc học** — chuyển đổi mượt là
>   việc của code, không phải của việc tráo ảnh;
> - màu lấy từ `ColorScheme` role (`outlineVariant`, `primary`,
>   `{{SUCCESS_ACCENT}}`), nên khi accent được chốt trong theme thì marker tự
>   đúng, không phải xuất lại 3 file;
> - ở 24×24 px, PNG bo tròn bị mờ viền, `BoxDecoration` thì không.
>
> Bảng bên dưới vẫn là **đặc tả bắt buộc**: ba trạng thái phải khác nhau về
> **hình dạng**, không chỉ màu (`design.md` §4). Prompt giữ lại làm tham chiếu.

```text
A single small flat progress step marker shaped as {{STEP_SHAPE}}, thick and
chunky with fully rounded corners, solid fill {{STEP_COLOR}}, centered on a
transparent background, no outline, no shadow.

STYLE: flat vector, minimal, geometric, soft rounded, child-safe, readable at
24x24 px.
NEGATIVE: text, numbers, watermark, outline, stroke, shadow, gradient, glow,
sparkle, 3D, glossy, multiple shapes, tiny details.
```

| Bước | `{{STEP_SHAPE}}` | `{{STEP_COLOR}}` | Kênh thứ hai |
|---|---|---|---|
| chưa làm | a hollow rounded circle ring | `#CBC4CF` | rỗng ruột |
| đang làm | a rounded circle with a smaller circle inside | `#68548E` | có lõi đặc |
| đã xong | a rounded circle with a thick check-like notch cut out | `{{SUCCESS_ACCENT}}` | có khấc hình tick |

Ba bước **khác nhau về hình**, nên vẫn đọc được khi trẻ không phân biệt màu
(`design.md` §4).

## Prompt B — sticker thưởng (bộ 8–12 cái)

```text
A cute flat sticker of {{STICKER}}, thick rounded shapes, cheerful but calm
expression if it has a face, a soft off-white rounded sticker border around the
silhouette, colors from a warm pastel palette of soft violet #68548E, lavender
#EBDDFF, muted rose #FFD9E1, warm plum #7E525D, transparent background.

STYLE: flat vector illustration, modern picture-book aesthetic, one subject,
bold simple geometric shapes with soft rounded corners, matte flat color fills,
subtle paper grain, even soft lighting, readable at 48x48 px, child-safe.

NEGATIVE: text, letters, numbers, watermark, logo, UI chrome, ranking, medals
with numbers, trophies, coins, money, gems, leaderboard, busy background, neon
saturation, dark tone, photorealism, 3D render, glossy plastic, heavy drop
shadow, gradient mesh, hairline strokes, scary, sad face.
```

`{{STICKER}}`: a smiling star · a rainbow arc · a small potted sprout · a paper
boat · a balloon · a soft cloud with a smile · a musical note with rounded head ·
a friendly ladybug · a slice of watermelon · a paper airplane · a tiny crown
made of rounded shapes · a hand giving a thumbs up (stylised, faceless).

> Cấm huy chương có số và cúp: đó là ngôn ngữ xếp hạng, trái `design.md` §2.5.

## Prompt C — huy hiệu hoàn thành bộ thẻ

```text
A soft rounded badge shape, a chunky flower-like rosette with eight rounded
petals, lavender #EBDDFF petals and a soft violet #68548E center disc, with a
small empty circular area in the middle reserved for an icon, transparent
background, calm and gentle, not shiny.

STYLE: flat vector illustration, geometric, soft rounded corners, matte flat
fills, subtle paper grain, even lighting, readable at 48x48 px, child-safe.
NEGATIVE: text, numbers, watermark, ribbon banner, metallic gold or silver,
shine, sparkle, glow, gemstone, trophy, coin, 3D render, glossy, heavy shadow,
ranking, tier, star rating.
```

Phần giữa để trống là cố ý: icon chủ đề của deck sẽ được widget đặt vào, nên một
huy hiệu dùng lại được cho mọi bộ thẻ.

## Prompt D — nền màn hình tổng kết phiên học

```text
A calm celebratory backdrop for a children's session summary screen: a wide soft
lavender #EBDDFF rounded hill shape along the bottom, a few sparse rounded
confetti shapes floating in the upper area with lots of empty space between
them, cream white #FEF7FF sky, the entire center of the frame left empty and
uncluttered.

STYLE: flat vector illustration, picture-book aesthetic, minimal, airy, matte
flat fills, subtle paper grain, warm and calm, bright but never neon.
NEGATIVE: text, letters, numbers, watermark, UI chrome, dense confetti, clutter,
busy background, fireworks, glow, sparkle, neon, dark tone, photorealism, 3D,
heavy shadow, gradient mesh.
```

## Kiểm tra trước khi nhận
- [ ] Ba bước tiến độ phân biệt được **trong ảnh xám**.
- [ ] Không sticker/huy hiệu nào chứa số, hạng, cúp, tiền, hay đá quý.
- [ ] Sticker đọc được ở 48×48 px.
- [ ] Nền tổng kết: vùng giữa đủ trống cho mascot + 1 dòng chữ + 1 nút, và chữ
      trên nền đó đạt 4.5:1.
- [ ] Nền tổng kết là trang trí ⇒ `ExcludeSemantics`; sticker mang nghĩa "đã đạt"
      thì cần `Semantics.label` từ localization.

## Export
`sticker-{name}.png` (1:1, 512 px) · `badge-rosette.png` (1:1, 512 px) ·
`summary-backdrop.png` (16:9, 1920×1080). Tất cả nền trong suốt.
**Marker tiến độ không xuất file** — xem callout ở Prompt A.

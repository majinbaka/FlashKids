# 04 — Feedback overlay (đúng / thử lại)

> Nhóm ảnh **nhạy cảm nhất** trong app. `design.md` §2.4: "Failure is cheap and
> never scolding. No red-alarm styling."

## Dùng ở đâu
Thành phần **Feedback overlay** (`design.md` §6) — phản ứng tức thì sau khi trẻ
trả lời, xuất hiện ngắn (100–200 ms micro-feedback, `design.md` §7) rồi biến đi,
**không bao giờ chặn lượt thử lại**.

## Hai ràng buộc cứng
1. **Đúng và Sai phải phân biệt được khi tắt màu** (`design.md` §4). Cách phân
   biệt ở đây là **hình dạng và hướng chuyển động**: đúng = toả ra ngoài; thử
   lại = một vòng khép nhẹ nhàng quay lại.
2. **Không có gì đỏ, không có gì báo động.** `error #BA1A1A` không được dùng cho
   trẻ. Tối đa là `errorContainer #FFDAD6` — hồng cam rất nhạt.

## Prompt A — phản hồi đúng (burst)

```text
A joyful celebration burst radiating outward from the center, made of simple
rounded confetti shapes: soft rounded stars, circles, teardrops and short
rounded ribbons, scattered evenly in a radial pattern with an empty calm center,
colors soft violet #68548E, lavender #EBDDFF, muted rose #FFD9E1, warm plum
#7E525D and gentle green {{SUCCESS_ACCENT}}, transparent background.

STYLE: flat vector illustration, modern picture-book aesthetic, bold simple
geometric shapes with soft rounded corners and no sharp 90-degree corners, matte
flat color fills, generous spacing between elements, light and airy, warm and
calm, bright but never neon, child-safe.

NEGATIVE: text, letters, numbers, watermark, logo, UI chrome, dense confetti,
clutter, sparkle glare, lens flare, glow, neon saturation, slot machine or
casino aesthetic, coins, trophies, fireworks, explosion, motion blur, speed
lines, photorealism, 3D render, glossy plastic, heavy drop shadow, gradient
mesh, hairline strokes.
```

## Prompt B — phản hồi "thử lại" (loop nhẹ)

```text
A gentle encouraging motif: one soft rounded arrow curving in a calm circular
loop back to its own start, thick rounded stroke, warm plum #7E525D on
transparent background, with two or three small rounded dots following the
curve, calm and reassuring, no urgency.

STYLE: flat vector illustration, modern picture-book aesthetic, bold simple
geometric shapes with soft rounded corners and no sharp 90-degree corners, matte
flat color fill, thick even stroke weight, generous negative space, warm and
soft, child-safe.

NEGATIVE: text, letters, numbers, watermark, logo, UI chrome, red, crimson,
alarm colors, warning triangle, exclamation mark, cross mark, X symbol, stop
sign, sad face, crying, frown, tears, sharp arrowhead, aggressive angle, motion
blur, neon saturation, dark tone, photorealism, 3D render, heavy drop shadow.
```

## Prompt C — hạt confetti rời

> ### 🔧 VẼ BẰNG CODE — không xuất file ảnh (5 asset)
>
> Năm hạt dưới đây là hình học thuần: sao bo tròn, hình tròn, giọt nước, dải
> ngắn, trái tim bo tròn. Vẽ bằng `CustomPainter` (hoặc `Container` +
> `BoxDecoration` cho hình tròn) rẻ hơn và tốt hơn PNG ở đây, vì:
> - hạt phải **animate vị trí, xoay, mờ dần** — đằng nào cũng là code;
> - màu lấy thẳng từ `ColorScheme` role, đổi theme không phải xuất lại
>   (`design.md` §4 cấm `Colors.*` literal, nhưng role thì luôn sẵn);
> - sắc nét ở mọi mật độ pixel, không cần `@2x`/`@3x`;
> - tôn trọng reduced motion bằng cách **không chạy**, thay vì phải đổi asset
>   (`design.md` §7).
>
> Prompt bên dưới giữ lại làm **tham chiếu hình dạng** cho người viết
> `CustomPainter` — hoặc dùng nếu bạn quyết định xuất PNG thật.

```text
A single flat {{PARTICLE}} shape, thick and chunky with fully rounded corners,
solid color {{PARTICLE_COLOR}}, centered, transparent background, no outline, no
shadow, no gradient.

STYLE: flat vector, minimal, geometric, soft rounded, child-safe.
NEGATIVE: text, watermark, outline, stroke, shadow, gradient, glow, sparkle,
3D, glossy, multiple shapes.
```

| `{{PARTICLE}}` | `{{PARTICLE_COLOR}}` |
|---|---|
| rounded five-pointed star | `#68548E` |
| circle | `#EBDDFF` |
| teardrop | `#FFD9E1` |
| short rounded ribbon | `#7E525D` |
| rounded heart | `{{SUCCESS_ACCENT}}` |

## Kiểm tra trước khi nhận
- [ ] In đen trắng: A và B vẫn khác nhau rõ ràng **chỉ nhờ hình dạng**.
- [ ] B không chứa bất kỳ tín hiệu tiêu cực nào: không X, không đỏ, không mặt buồn.
- [ ] Tâm của A trống — mascot hoặc thẻ nằm ở đó, không bị che.
- [ ] Overlay không che nút trả lời: trẻ phải thử lại được ngay (`design.md` §6).
- [ ] Không có gì nhấp nháy > 3 Hz khi animate (`design.md` §7) — quy tắc của
      code, nhưng đừng sinh ảnh gợi ý nhấp nháy.
- [ ] Dưới reduced motion, overlay phải suy biến thành cross-fade và vẫn đọc được
      (`design.md` §7) → ảnh phải **đứng yên cũng có nghĩa**.
- [ ] `ExcludeSemantics` — nghĩa "đúng/thử lại" đi qua text localization và
      `Semantics` flag, không qua ảnh.

## Export
`feedback-correct-burst.png` (1:1, 1024 px) và `feedback-retry-loop.png` (1:1,
512 px), nền trong suốt. **Hai file — hạt confetti không xuất file**, xem callout
ở Prompt C.

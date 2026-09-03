# 11 — Ảnh cho cửa hàng ứng dụng (marketing)

> Nhóm này **nằm ngoài app**, nên nó không chịu ràng buộc `ColorScheme` của
> widget — nhưng vẫn phải cùng một art direction, nếu không người dùng tải về sẽ
> thấy một app khác với ảnh họ đã xem.

## Ràng buộc riêng
- Ảnh cửa hàng **được phép có chữ**, nhưng chữ do bạn đặt trong công cụ dàn
  trang, **không sinh bằng AI** — model viết sai chính tả và không dịch được.
- Cửa hàng cho trẻ em có chính sách riêng: không hứa hẹn phóng đại, không CTA
  hướng vào trẻ ("Mua ngay!"), không so sánh xếp hạng.
- Ảnh chụp màn hình phải là **màn hình thật**, không phải tranh vẽ giả lập màn
  hình — dựng mockup từ screenshot chạy thật.

## Prompt A — nền cho ảnh chụp màn hình

```text
A clean marketing backdrop for an app screenshot: a soft lavender #EBDDFF wide
rounded shape in the lower two thirds, cream white #FEF7FF above it, a few very
sparse rounded confetti shapes near the top corners with large empty gaps, the
entire center of the frame left completely empty for a phone mockup, 9:16
portrait frame.

STYLE: flat vector, minimal, airy, matte flat fills, subtle paper grain, warm,
calm, bright but never neon.
NEGATIVE: text, letters, numbers, watermark, logo, phone, device, screen,
mockup, UI, hands, people, clutter, dense confetti, neon, dark tone,
photorealism, 3D, glossy, heavy shadow, gradient mesh.
```

Khung giữa để trống là chỗ bạn ghép screenshot thật vào.

## Prompt B — feature graphic (Google Play, 1024×500)

```text
A wide banner illustration for a children's learning app: the baby fox mascot
standing at the right third waving, three large rounded blank flashcard shapes
floating at the left third in a gentle arc, cream white #FEF7FF background with
a soft lavender #EBDDFF rounded shape behind the cards, the horizontal center
kept calm and open, wide 2:1 composition.

STYLE: flat vector illustration, picture-book aesthetic, bold simple geometric
shapes with soft rounded corners, matte flat fills, subtle paper grain, generous
negative space, warm palette of soft violet #68548E, lavender #EBDDFF, muted
rose #FFD9E1, calm and inviting, child-safe.
NEGATIVE: text, letters, numbers, watermark, logo type, app store badges, UI
chrome, device mockup, hands, realistic children, photorealism, 3D render,
glossy, neon, dark tone, clutter, heavy shadow, gradient mesh.
```

> `realistic children` nằm trong NEGATIVE: ảnh trẻ em thật trong marketing app
> cho trẻ em kéo theo cả vấn đề pháp lý lẫn cảm nhận. Dùng mascot.

## Prompt C — ảnh minh hoạ "dành cho phụ huynh"

Cửa hàng thường yêu cầu một ảnh nói app an toàn/có kiểm soát.

```text
A calm reassuring illustration: a large rounded shield-like shape with soft
corners in muted grey-violet #635B70 and light lavender #E9DEF8, with one simple
rounded checkmark-like notch inside it, plain cream white #FEF7FF background,
minimal and trustworthy, adult-oriented.

STYLE: flat vector, minimal, geometric, soft rounded, matte flat fills, quiet,
restrained.
NEGATIVE: text, numbers, watermark, mascot, animal, cute, playful, confetti,
lock and chain, prison bars, red alarm colors, warning triangle, neon, 3D,
glossy, heavy shadow.
```

## Danh sách cần có
| Asset | Kích thước | Ghi chú |
|---|---|---|
| `store-screenshot-bg.png` | 9:16, 1242×2208 | nền, ghép screenshot thật |
| `store-feature-graphic.png` | 1024×500 | Google Play |
| `store-parents.png` | 1:1, 1024 px | mục an toàn/phụ huynh |
| Ảnh chụp màn hình | theo yêu cầu từng store | **màn hình chạy thật** |

## Kiểm tra trước khi nhận
- [ ] Không chữ nào do AI sinh còn sót lại trong ảnh.
- [ ] Màu và phong cách khớp với `00-art-direction.md` — đặt cạnh
      `onboarding-hero.png` phải cùng một app.
- [ ] Screenshot là màn hình thật, không phải tranh vẽ mô phỏng.
- [ ] Không có trẻ em thật trong bất kỳ ảnh nào.
- [ ] Chữ marketing được kiểm tra tương phản như chữ trong app.

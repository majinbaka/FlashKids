# 01 — Mascot & expression sheet

> **Đã chốt — 2026-09-03.** Mascot là **con lười tím**. Các hướng A/B/C bên
> dưới được giữ lại như lịch sử ý tưởng, không phải lựa chọn đang mở.

## Dùng ở đâu
Splash, onboarding, feedback overlay (`design.md` §6), session summary, state
placeholders, empty deck. **Không** xuất hiện trong Parent Zone — Parent Zone là
"compact, text-led, plainly utilitarian" (`design.md` §1).

## Vì sao cần
Mascot là kênh mang nghĩa **không cần đọc chữ** (`design.md` §2.1): tư thế của
nó nói "đúng rồi", "thử lại", "hết bài" cho một đứa trẻ chưa biết đọc.

## Ba hướng ban đầu (lưu lịch sử)

| # | Hướng | Lý do chọn | Rủi ro |
|---|---|---|---|
| A | **Cáo con tím** — tai tròn, đuôi to | hợp seed `deepPurple`, dễ nhớ | phổ biến, dễ đụng hàng |
| B | **Chim cú nhỏ mập** | gắn với "học", silhouette rất mạnh ở 48px | dễ thành cliché giáo dục |
| C | **Đốm sáng có mặt (blob/spark)** | trung tính loài/giới, rẻ để animate | ít cảm xúc, khó thương |

**Quyết định:** con lười tím — dáng tròn, mặt nạ nhạt, móng cong được cách điệu
thành các hình bo tròn an toàn.

## Prompt — nhân vật chính (chạy trước, khoá được thiết kế)

```text
A single friendly baby sloth mascot for a children's learning app, front-facing,
standing, one paw raised in a small wave, warm confident smile, big round dark
violet #4F3D74 eyes, soft violet #68548E fur with a lavender #EBDDFF face mask
and belly, muted rose #FFD9E1 cheeks, oversized round head, short rounded limbs,
small rounded ears and gentle rounded claws, no clothes, no accessories.

STYLE: flat vector illustration, modern picture-book aesthetic, one clearly
silhouetted subject, bold simple geometric shapes with soft rounded corners
everywhere and no sharp 90-degree corners, matte flat color fills, subtle paper
grain, generous negative space, centered composition, even soft lighting, one
very soft ambient shadow, transparent background, readable as a silhouette at
48x48 px, child-safe, gender-neutral.

NEGATIVE: text, letters, numbers, watermark, logo, UI chrome, busy background,
multiple subjects, cropped subject, neon saturation, dark tone, photorealism, 3D
render, glossy plastic, heavy drop shadow, gradient mesh, hairline strokes, tiny
details, sharp teeth, sharp or realistic claws, weapons, scary, sad or crying face, arcade
aesthetic, existing brand mascots, realistic human face.
```

## Prompt — expression sheet (chạy sau, giữ nguyên nhân vật)

Thay `{{POSE}}` bằng từng dòng trong bảng, **giữ nguyên phần còn lại của prompt**
để nhân vật không đổi giữa các trạng thái.

```text
The same baby sloth mascot, {{POSE}}, exact same character design, same colors,
same proportions, same style, full body, transparent background.

STYLE: (như trên)
NEGATIVE: (như trên)
```

| Asset | `{{POSE}}` | Dùng cho |
|---|---|---|
| `mascot-idle` | standing calmly, small friendly smile, arms relaxed | splash, home |
| `mascot-wave` | waving one paw, happy open smile | onboarding, welcome |
| `mascot-cheer` | jumping with both paws up, eyes closed in joy | feedback đúng (§6 Feedback overlay) |
| `mascot-encourage` | gently pointing forward with an open paw, warm reassuring smile, calm posture | feedback "thử lại" — **cấm buồn/xấu hổ** (`design.md` §2.4) |
| `mascot-listen` | one paw cupped near ear, head slightly tilted, curious | nút phát âm thanh (§6 Play-audio control) |
| `mascot-think` | one paw on chin, eyes looking up, small curious smile | loading |
| `mascot-sleep` | curled up with arms close to face, eyes closed as two soft arcs, tiny calm expression | offline / empty |
| `mascot-proud` | holding a big soft rounded star, chest out, wide smile | session summary |
| `mascot-peek` | peeking from behind a large rounded shape, only head and one paw visible | error state, empty deck |

## Kiểm tra trước khi nhận
- [ ] 9 tư thế đặt cạnh nhau vẫn nhận ra **cùng một nhân vật** (màu, tỉ lệ đầu/thân, mặt nạ nhạt và dáng tay).
- [ ] Thu về 48×48 px: `cheer` và `encourage` vẫn **phân biệt được bằng tư thế**, không cần màu (`design.md` §4).
- [ ] `encourage` không có bất kỳ tín hiệu tiêu cực nào — không cau mày, không mắt cụp, không đỏ.
- [ ] Silhouette đen tuyền của mỗi tư thế vẫn đọc được.
- [ ] Tương phản thân mascot ≥ 3:1 với nền `#FEF7FF`.

## Export
`mascot-{pose}.png`, nền trong suốt, 1:1, cạnh 512 px gốc, kèm `@2x`/`@3x`.
Luôn bọc `ExcludeSemantics` khi mascot chỉ trang trí; khi mascot *là* phản hồi
đúng/sai thì nghĩa phải nằm ở text localization đi kèm, không nằm ở ảnh.

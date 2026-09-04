# 06 — State placeholders: empty · loading · error · offline

> `design.md` §0.3: "Every screen owes: empty, loading, populated, error,
> offline… A screen with only a populated state is unfinished." Đây là nhóm ảnh
> hay bị bỏ quên nhất và là nhóm khiến app **trông chưa xong**.

## Dùng ở đâu
Thành phần **State placeholders** (`design.md` §6): mỗi trạng thái = 1 minh hoạ +
1 dòng chữ + tối đa 1 nút.

## Ràng buộc
- Mỗi trạng thái phải phân biệt được **bằng hình**, không phải bằng màu.
- Kid Zone: mascot dẫn dắt, ấm, không lỗi lầm. Parent Zone: **không mascot**,
  hình khối trung tính, nhỏ hơn (`design.md` §1 — hai vùng phải phân biệt được
  trong một giây).
- Lỗi **không** được trông như lỗi hệ thống: không tam giác cảnh báo, không đỏ.

## Prompt — bản Kid Zone (dùng mascot từ `01-mascot.md`)

```text
{{SCENE}}, cream white #FEF7FF background, lots of empty space, the composition
sitting in the upper half of a 4:3 frame so a line of text and one button fit
below it.

STYLE: flat vector illustration, modern picture-book aesthetic, bold simple
geometric shapes with soft rounded corners and no sharp 90-degree corners, matte
flat color fills, subtle paper grain, generous negative space, even soft
lighting, warm pastel palette of soft violet #68548E, lavender #EBDDFF, deep
violet #4F3D74, muted rose #FFD9E1, calm and reassuring, child-safe.

NEGATIVE: text, letters, numbers, watermark, logo, UI chrome, buttons, warning
triangle, exclamation mark, error symbol, red, crimson, alarm colors, broken
robot, bug, skull, sad crying face, clutter, busy background, neon saturation,
dark tone, photorealism, 3D render, glossy plastic, heavy drop shadow.
```

| Asset | `{{SCENE}}` | Nghĩa mà hình phải tự nói |
|---|---|---|
| `state-empty` | The baby sloth mascot sitting beside one large empty rounded open box, looking into it with mild curiosity, calm expression | "chưa có gì ở đây" |
| `state-loading` | The baby sloth mascot with a paw on its chin looking up at three evenly spaced rounded dots floating in an arc above its head | "đang chờ" |
| `state-error` | The baby sloth mascot peeking out from behind a large soft lavender rounded shape, one paw visible, mildly surprised but calm and friendly | "có gì đó lỡ rồi, không sao" |
| `state-offline` | The baby sloth mascot curled up asleep inside a large rounded cloud shape, tail over nose, eyes as two soft closed arcs | "đang ngoại tuyến / nghỉ" |
| `state-deck-done` | The baby sloth mascot standing proudly holding a large soft rounded star, warm smile | "hết bài rồi" |

`state-offline` chỉ cần khi có mạng — `design.md` §12 ghi offline behavior chưa
quyết vì chưa có data layer. Sinh sau, đừng dựng trước.

## Prompt — bản Parent Zone (không mascot)

```text
A small neutral spot illustration of {{OBJECT}}, minimal and utilitarian, muted
grey-violet #635B70 and light lavender #E9DEF8 only, plain transparent
background, compact composition, no character, no mascot.

STYLE: flat vector, minimal, geometric, soft rounded corners, thin-to-medium
even stroke, matte flat fills, restrained and plain, adult-oriented, quiet.
NEGATIVE: text, numbers, watermark, mascot, animal, character, face, playful
decoration, confetti, bright colors, neon, red alarm colors, warning triangle,
3D render, glossy, heavy shadow, gradient mesh.
```

`{{OBJECT}}`: an empty rounded list · a rounded document with a folded corner ·
a rounded cloud with a small gap in its outline · a simple rounded bar chart with
no data.

## Kiểm tra trước khi nhận
- [ ] Đặt 4 ảnh Kid Zone cạnh nhau: phân biệt được **mà không đọc chữ**.
- [ ] Không ảnh nào có tam giác cảnh báo, dấu chấm than, hay màu đỏ.
- [ ] Bản Parent Zone đặt cạnh bản Kid Zone: **rõ ràng là hai vùng khác nhau**
      trong một giây (`design.md` §1).
- [ ] Nửa dưới khung trống — thử với chuỗi dịch dài nhất ở 200% text scale
      (`design.md` §5); không được đè lên hình.
- [ ] `state-loading` **đứng yên vẫn có nghĩa** (reduced motion, `design.md` §7).
- [ ] `ExcludeSemantics` cho ảnh; nghĩa của trạng thái nằm ở dòng chữ localization.

## Export
`state-{name}.png` (4:3, 1200×900) · `parent-state-{name}.png` (1:1, 256 px).
Nền trong suốt.

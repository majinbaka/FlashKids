# 10 — App icon, adaptive icon, splash

> `android/` và `web/` đã được sinh trong repo, nên nhóm này có chỗ để đặt file
> ngay. Nhưng **thương hiệu và mascot chưa chốt** (`design.md` §12) — icon là thứ
> khó đổi nhất sau khi phát hành, nên chốt `01-mascot.md` trước.

## Ràng buộc riêng của icon
- Phải đọc được ở **48×48 px** trên màn hình điện thoại và **16×16 px** ở tab
  trình duyệt (`web/`).
- **Không chữ trong icon.** Tên app do OS vẽ bên dưới.
- Android adaptive icon: mọi thứ quan trọng phải nằm trong **vòng tròn an toàn
  đường kính 66/108** của khung 108×108 dp — launcher có thể cắt thành tròn,
  squircle, hay bo góc.
- Icon phải **khác biệt khi thu nhỏ**, không phải khi phóng to.

## Prompt A — foreground icon (lớp trước của adaptive icon)

```text
An app icon subject: the head of a friendly baby fox mascot, front-facing,
centered, soft violet #68548E fur with lavender #EBDDFF inner ears and muzzle,
two round dark violet #4F3D74 eyes, muted rose #FFD9E1 cheeks, warm gentle
smile, extremely simplified into a few bold rounded shapes, the head occupying
about 60 percent of a square frame with wide even margins on all sides,
transparent background, no scene, no props.

STYLE: flat vector app icon, bold simple geometric shapes, soft rounded corners,
matte flat color fills, no outline or one thick even outline, strong distinct
silhouette, perfectly readable at 48x48 px and at 16x16 px, symmetric, child-safe.

NEGATIVE: text, letters, numbers, watermark, logo type, UI chrome, frame,
border, badge, ribbon, background scene, clutter, tiny details, hairline
strokes, thin whiskers, gradient mesh, glow, sparkle, metallic, 3D render,
glossy plastic, skeuomorphic, heavy drop shadow, photorealism, off-center
composition, subject touching the frame edge.
```

> `thin whiskers` nằm trong NEGATIVE có lý do: râu mèo/cáo là thứ đầu tiên biến
> mất ở 16 px và biến icon thành một vệt mờ.

## Prompt B — background icon (lớp sau của adaptive icon)

> ### 🔧 KHAI BÁO BẰNG MÀU — không xuất file ảnh (1 asset)
>
> Lớp nền của adaptive icon là **một màu đặc**, nên khai báo nó là color
> resource chứ không phải PNG 1024 px:
> `android/app/src/main/res/values/colors.xml` →
> `<color name="ic_launcher_background">#EBDDFF</color>`, rồi trỏ
> `ic_launcher.xml` vào đó. Nhẹ hơn, không bao giờ lệch màu do nén PNG, và sửa
> một dòng là đổi được.
>
> Prompt bên dưới chỉ cần nếu công cụ của bạn bắt buộc nhận file ảnh.

```text
A flat solid lavender #EBDDFF square with no content, completely uniform color,
no pattern, no gradient, no vignette.

STYLE: flat, solid, uniform.
NEGATIVE: text, pattern, texture, gradient, vignette, shadow, noise, shapes,
logo, watermark.
```

Nền phẳng tuyệt đối là cố ý: launcher sẽ animate hai lớp lệch nhau (parallax),
nền có hoạ tiết sẽ lộ mép khi trượt.

## Prompt C — hình splash

```text
The baby fox mascot head icon, same design as the app icon, centered on a fully
transparent background, with generous empty margin on all sides, no background
shape, no text.

STYLE: (như Prompt A)
NEGATIVE: (như Prompt A) + background color, circle backdrop, loading spinner.
```

Splash chỉ là **một hình đứng yên trên nền `surface #FEF7FF`**. Không animation,
không spinner — `design.md` §7 giới hạn chuyển động và cấm mọi thứ nhấp nháy;
một splash chớp nháy là thứ trẻ nhìn thấy đầu tiên mỗi lần mở app.

## Prompt D — notification icon (Android, đơn sắc)

```text
A pure white silhouette of a simplified baby fox head, solid fill, no interior
details except two small negative-space cut-outs for ears, completely flat, on a
transparent background, readable at 24x24 px.

STYLE: monochrome silhouette icon, solid fill, bold, minimal, no outline.
NEGATIVE: color, gradient, shading, outline, text, detail, thin lines, eyes,
whiskers, background.
```

Android tô lại notification icon thành đơn sắc — mọi màu bạn vẽ sẽ bị bỏ, chỉ
alpha còn lại. Vẽ màu ở đây là vẽ ra một ô vuông trắng.

## Kiểm tra trước khi nhận
- [ ] Thu về 48×48 và 16×16: vẫn nhận ra, không thành vệt.
- [ ] Cắt tròn, cắt squircle, cắt bo góc: không mất phần nào của mặt.
- [ ] Đặt cạnh 20 icon khác trên màn hình chủ giả lập: có nổi lên không?
- [ ] Không chữ, không viền, không huy hiệu.
- [ ] Notification icon: chỉ trắng + trong suốt, không màu.
- [ ] Splash không có spinner, không nhấp nháy.

## Export
- `icon-foreground.png` — 1:1, 1024 px, nền trong suốt, chủ thể trong vòng an toàn.
- ~~`icon-background.png`~~ — thay bằng color resource `#EBDDFF`, xem Prompt B.
- `icon-legacy.png` — 1:1, 1024 px, đã ghép sẵn hai lớp, bo góc mềm.
- `splash-logo.png` — 1:1, 1024 px, nền trong suốt.
- `notification-icon.png` — 1:1, 96 px, trắng trên trong suốt.
- Favicon cho `web/`: 512 / 192 / 32 / 16 px.

> `pubspec.yaml` chưa có mục `assets:` và chưa có package sinh icon
> (`flutter_launcher_icons`). Thêm dependency là quyết định của bạn, không phải
> việc làm kèm (`AGENTS.md` → Workflow, `CLAUDE.md` rule 2).

# concepts/ — chỉ mục tra cứu nhanh

Thư mục này chứa **prompt sinh ảnh** cho FlashKids, viết bám theo `design.md`
(hợp đồng UI/UX chuẩn của repo) và palette thật lấy từ
`ColorScheme.fromSeed(seedColor: Colors.deepPurple)` trong `FlashKidsApp.build`
(`lib/main.dart`).

> ## ⚠ Trạng thái: ĐỀ XUẤT, chưa được duyệt
>
> `design.md` §12 liệt kê **"Mascot, illustration style guide, and where art
> assets come from"** là *deliberately undecided* — và ghi rõ: không tự quyết,
> phải hỏi. Toàn bộ thư mục này là **đề xuất để bạn duyệt**, không phải chuẩn đã
> chốt. Nó không cho phép ai thêm asset vào `lib/` hay `pubspec.yaml`.
>
> Khi bạn duyệt, hãy ghi quyết định vào `design.md` (§3 Illustration + §12) trong
> **cùng một change** — `CLAUDE.md` rule 4.

---

## 1. Chỉ mục file

| # | File | Nội dung | Số asset | Ưu tiên |
|---|---|---|---|---|
| 00 | [`images/00-art-direction.md`](images/00-art-direction.md) | Palette đo từ code, khối STYLE + NEGATIVE dùng chung, 7 ràng buộc bắt buộc, quy ước xuất file | — | **Đọc trước tiên** |
| 01 | [`images/01-mascot.md`](images/01-mascot.md) | Mascot: 3 hướng để chọn + expression sheet 9 tư thế | 9 | P0 |
| 02 | [`images/02-flashcard-subjects.md`](images/02-flashcard-subjects.md) | Tranh nội dung thẻ — template + 10 bộ chủ đề | 120–160 | P0 |
| 03 | [`images/03-deck-covers.md`](images/03-deck-covers.md) | Bìa bộ thẻ + 4 trạng thái (do widget vẽ chồng) | 8 | P1 |
| 04 | [`images/04-feedback-overlay.md`](images/04-feedback-overlay.md) | Phản hồi đúng / thử lại + hạt confetti rời | 2 (+5 🔧) | P0 |
| 05 | [`images/05-progress-and-rewards.md`](images/05-progress-and-rewards.md) | Bước tiến độ, sticker, huy hiệu, nền tổng kết | 14 (+3 🔧) | P1 |
| 06 | [`images/06-state-placeholders.md`](images/06-state-placeholders.md) | empty · loading · error · offline (bản Kid & bản Parent) | 9 | P0 |
| 07 | [`images/07-onboarding-and-avatars.md`](images/07-onboarding-and-avatars.md) | Hero chào, 3 bước onboarding, 12 avatar hồ sơ | 16 | P2 (chờ quyết định) |
| 08 | [`images/08-parent-zone.md`](images/08-parent-zone.md) | Spot illustration Parent Zone + parent gate | 0 (5 🔧) | P1 |
| 09 | [`images/09-backgrounds-and-textures.md`](images/09-backgrounds-and-textures.md) | Hoạ tiết nền, dải chân màn hình, mặt sau thẻ, ripple | 2 (+2 🔧) | P2 |
| 10 | [`images/10-app-icon-and-splash.md`](images/10-app-icon-and-splash.md) | App icon, adaptive icon, splash, notification icon, favicon | 4 + favicon (+1 🔧) | P1 |
| 11 | [`images/11-store-listing.md`](images/11-store-listing.md) | Nền screenshot, feature graphic, ảnh "dành cho phụ huynh" | 3 + screenshot | P3 |

🔧 = **vẽ bằng code, không xuất file ảnh** — xem §3.


---

## 2. Bản tối thiểu — ~30 ảnh, không phải 150

Tổng ở bảng trên là **trần trên của một sản phẩm đã trưởng thành**, không phải
thứ cần có để chạy bản đầu tiên. Hai điều cần tách bạch:

- **Nội dung ≠ giao diện.** File 02 chiếm 120–160 trong tổng số, và nó là *nội
  dung dạy học* — co giãn theo số bộ thẻ bạn quyết định ship, không theo độ phức
  tạp của app. Một bộ thẻ = 12–16 ảnh.
- **16 asset không phải file ảnh** (§3 bên dưới) — Flutter vẽ trực tiếp.

Còn lại, để chạy được bản đầu tiên:

| Cần | Số | Lấy từ |
|---|---|---|
| Mascot — 4 tư thế: `idle`, `cheer`, `encourage`, `think` | 4 | 01 |
| Feedback — burst đúng + loop thử lại | 2 | 04 |
| State — `empty`, `loading`, `error` | 3 | 06 |
| App icon — foreground, notification, favicon | 3 | 10 |
| Bìa deck — đúng số bộ thực sự ship | 2 | 03 |
| Nội dung — bộ thẻ đầu tiên | 12–16 | 02 |
| **Tổng** | **26–30** | |

Những gì **chưa cần** ở bản tối thiểu, và lý do:

| Bỏ qua | Vì |
|---|---|
| `state-offline` (06) | chưa có data layer; `design.md` §12 để ngỏ offline behavior |
| Sticker + huy hiệu (05) | mô hình thưởng chưa chốt (`design.md` §12) |
| Onboarding + avatar (07) | onboarding và hồ sơ nhiều trẻ chưa được quyết (`design.md` §12) |
| Hoạ tiết nền, mặt sau thẻ (09) | `design.md` §3 coi khoảng trống là tính năng — nền phẳng đã đúng |
| Splash riêng (10) | dùng lại foreground icon |
| Ảnh cửa hàng (11) | ngoài app, làm khi chuẩn bị phát hành |
| 5 tư thế mascot còn lại (01) | thêm khi màn hình tương ứng thực sự tồn tại |

**Ba cách ghìm con số khi mở rộng về sau:**
1. **Dùng chung ảnh giữa các bộ** — một con mèo phục vụ cả bộ "động vật" lẫn bộ
   từ vựng. Đặt tên theo chủ thể (`card-cat.png`), không theo bộ.
2. **8–12 thẻ mỗi bộ thay vì 16** — phiên học ngắn vốn là chủ ý của sản phẩm
   (`design.md` §1: "Sessions are short, repeated often").
3. **Mua pack minh hoạ có sẵn cho phần nội dung**, chỉ tự sinh phần chrome — chrome
   là thứ định danh app, nội dung thì không.

Chi phí thật không nằm ở số lượng mà ở **tính đồng bộ**: 16 ảnh cùng bộ phải cùng
tỉ lệ chiếm khung và cùng độ bão hoà, nếu không bộ thẻ sẽ nhảy loạn khi trẻ lật.
Đó là lý do file 02 khoá cứng phần prompt và chỉ cho thay `{{SUBJECT}}`.

---

## 3. 🔧 16 asset vẽ bằng code — không xuất file ảnh

| Asset | Số | Thay bằng | File |
|---|---|---|---|
| Hạt confetti | 5 | `CustomPainter` — đằng nào cũng phải animate | [04](images/04-feedback-overlay.md) |
| Marker bước tiến độ | 3 | `BoxDecoration(shape: circle)` + `Icon` | [05](images/05-progress-and-rewards.md) |
| Spot illustration Parent Zone | 5 | Material Icons (`uses-material-design: true`) | [08](images/08-parent-zone.md) |
| Dải nền chân màn hình | 1 | `ClipPath` — raster sẽ méo khi đổi bề ngang | [09](images/09-backgrounds-and-textures.md) |
| Vòng gợn khi chạm | 1 | ripple sẵn có của `InkWell` | [09](images/09-backgrounds-and-textures.md) |
| Nền adaptive icon | 1 | color resource `#EBDDFF` trong `colors.xml` | [10](images/10-app-icon-and-splash.md) |

Ba lý do chung, tất cả đều bắt nguồn từ `design.md`:

- **Màu lấy từ `ColorScheme` role** (§4) — chốt `{{SUCCESS_ACCENT}}` trong theme
  một lần là mọi thứ tự đúng, không phải xuất lại file nào.
- **Sắc nét ở mọi mật độ pixel** — không cần `@2x`/`@3x`, và không mờ viền ở
  24×24 px.
- **Chuyển động phải phản ứng với cú chạm** (§7: "Motion always starts from the
  thing the child touched") và **suy biến được dưới reduced motion**. Code làm
  được; tráo PNG thì không.

Riêng Parent Zone, dùng Material Icons không phải cắt giảm mà là **củng cố**
`design.md` §1: vùng này phải "compact, text-led, and plainly utilitarian". Minh
hoạ vẽ tay sẽ kéo nó về phía Kid Zone — đúng thứ §1 gọi là lỗi thiết kế.

Prompt của các asset này **vẫn được giữ lại** trong file tương ứng, làm tham
chiếu hình dạng cho người viết `CustomPainter`, và làm phương án dự phòng nếu
bạn quyết định xuất file thật.

---

## 4. Tra theo thành phần UI (`design.md` §6)

| Thành phần trong `design.md` | Ảnh cần | File |
|---|---|---|
| Flashcard | tranh chủ thể, mặt sau thẻ | 02, 09 |
| Answer control | *không cần ảnh* — hình dạng và màu do theme | — |
| Play-audio control | mascot `listen` (tuỳ chọn) | 01 |
| Deck tile | bìa deck + lớp trạng thái | 03 |
| Progress indicator | 🔧 3 marker bước — vẽ bằng code | 05 |
| Session summary | mascot `proud`, sticker, huy hiệu, nền | 01, 05 |
| Feedback overlay | burst đúng, loop thử lại (+🔧 hạt) | 04 |
| Parent gate | 🔧 `Icons.lock_outline_rounded` — không cần ảnh | 08 |
| State placeholders | empty · loading · error · offline | 06 |
| *(ngoài §6)* App shell | icon, splash, favicon, hoạ tiết nền | 09, 10 |

🔧 = vẽ bằng code, xem §3.

---

## 5. Tra theo màu (palette đo từ code)

| Role | Hex | Xuất hiện trong |
|---|---|---|
| `surface` | `#FEF7FF` | nền mọi ảnh |
| `primary` | `#68548E` | mascot, mặt sau thẻ, marker đang làm, icon |
| `primaryContainer` | `#EBDDFF` | mảng nền mềm, bìa deck, nền icon, avatar |
| `onPrimaryContainer` | `#4F3D74` | mắt, nét chi tiết |
| `secondary` / `secondaryContainer` | `#635B70` / `#E9DEF8` | **chỉ** Parent Zone |
| `tertiary` / `tertiaryContainer` | `#7E525D` / `#FFD9E1` | má mascot, accent ấm, loop "thử lại" |
| `errorContainer` | `#FFDAD6` | mức tối đa cho tín hiệu tiêu cực ở Kid Zone |
| `error` | `#BA1A1A` | **không dùng trong ảnh trẻ em** |
| `{{SUCCESS_ACCENT}}` | *chưa quyết* | marker đã xong, hạt confetti, huy hiệu |

Chi tiết đầy đủ: [`images/00-art-direction.md`](images/00-art-direction.md) §1.

---

## 6. Bốn quyết định đang chặn — cần bạn chốt

| # | Câu hỏi | Chặn cái gì | Khuyến nghị |
|---|---|---|---|
| 1 | **Duyệt style guide này?** `design.md:§12` ghi illustration style guide là undecided | toàn bộ thư mục | duyệt, rồi ghi vào `design.md` §3 + §12 |
| 2 | **Mascot: hướng A / B / C?** | file 01, và 04, 06, 07, 10 phụ thuộc nó | **A — cáo con tím**, hợp seed `deepPurple` |
| 3 | **Màu "đúng" là gì?** `design.md:§4` bảo dùng "the theme's success-side accent", nhưng `ColorScheme` M3 không có role `success` và `lib/main.dart` chưa map | mọi chỗ có `{{SUCCESS_ACCENT}}` | thêm vào theme: `#4C6B4F` + container `#CDE9CE`, **chốt trong theme trước** |
| 4 | **Nội dung thẻ là gì?** `design.md:§12` để ngỏ letters/numbers/vocabulary | file 02 — asset nhiều nhất | chốt 2–3 bộ đầu trước khi sinh 150 ảnh |

Quyết định #3 là một **mâu thuẫn tài liệu ↔ code** theo nghĩa của
`AGENTS.md` → Conflicts: `design.md` giả định một accent tồn tại, theme thì
không có. Đừng để widget hay file ảnh tự chọn — sửa ở theme.

---

## 7. Thứ tự làm (đề xuất)

1. **Chốt 4 quyết định ở §4.** Không sinh hàng loạt trước khi chốt mascot.
2. **Sinh 01 (mascot)** — nhân vật chính trước, expression sheet sau, giữ nguyên
   phần prompt để nhân vật không trôi giữa các tư thế.
3. **Sinh 06 + 04** — state placeholder và feedback là thứ khiến app *trông đã
   xong*; thiếu chúng thì `design.md` §0.3 coi màn hình là chưa hoàn thiện.
4. **Sinh 02 cho 1 bộ thẻ** (12 ảnh), test trên thiết bị thật, rồi mới nhân rộng.
   Đến đây bạn đã có đủ **bản tối thiểu ở §2**.
5. **Sinh 03, 05, 10.** (08 không cần ảnh — xem §3.)
6. **09, 07, 11** khi các quyết định tương ứng đã có.

---

## 8. Checklist chung — mọi ảnh đều phải qua

Rút từ `design.md` §3, §4, §5, §7, §8, §11:

- [ ] Nhận ra được ở **48×48 px**.
- [ ] **Không có chữ, số, watermark** trong ảnh (chữ thuộc lớp localization, §8).
- [ ] Nghĩa **không phụ thuộc riêng vào màu** — luôn có kênh thứ hai: hình dạng,
      tư thế, biểu tượng, vị trí (§4).
- [ ] Tương phản đo **trên nền thật** `#FEF7FF`: ≥ 3:1 cho hình mang nghĩa,
      ≥ 4.5:1 cho chữ đặt lên trên (§4).
- [ ] Nền phẳng, không rối ở chỗ sẽ có chữ (§3).
- [ ] Không đỏ báo động, không mặt buồn, không mắng mỏ (§2.4).
- [ ] Không vật nào trong tranh trông **bấm được** mà thật ra không bấm được (§5).
- [ ] Chừa chỗ cho chuỗi dịch dài nhất ở **200% text scale** (§5).
- [ ] Light-only, PNG nền trong suốt — **không** làm biến thể dark mode (§4).
- [ ] Ảnh trang trí ⇒ `ExcludeSemantics`; ảnh mang thông tin ⇒ `Semantics.label`
      từ localization (§3, §11).
- [ ] Kid Zone và Parent Zone đặt cạnh nhau vẫn phân biệt được **trong 1 giây** (§1).

---

## 9. Liên quan

| File | Vai trò |
|---|---|
| `design.md` | hợp đồng UI/UX chuẩn — **outrank thư mục này** |
| `AGENTS.md` | guardrail toàn repo; mục Conflicts áp dụng cho §6 ở trên |
| `CLAUDE.md` | rule 2 (đổi tối thiểu), rule 4 (đổi code ⇒ đổi doc), rule 5 (mâu thuẫn ⇒ hỏi) |
| `docs/adr/0001-…` | kiến trúc; asset sẽ thuộc feature slice sở hữu nó |
| `.claude/skills/flutter-a11y-kids-ui` | tương phản, semantics, text scale, motion |
| `.claude/skills/flutter-l10n` | vì sao chữ không được nướng vào ảnh |

**Chưa tồn tại trong repo:** mục `assets:` trong `pubspec.yaml`, thư mục asset,
`flutter_svg`, `flutter_launcher_icons`. Thêm chúng là một task riêng cần bạn
duyệt, không phải việc làm kèm.

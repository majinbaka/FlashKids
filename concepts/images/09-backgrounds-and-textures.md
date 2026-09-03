# 09 — Nền, hoạ tiết, mặt sau thẻ

> Nhóm ảnh dễ phá hỏng app nhất. `design.md` §3: "No busy backgrounds behind
> text" và "Empty space is a feature, not waste". Mọi thứ ở đây phải **gần như
> vô hình**.

## Dùng ở đâu
Nền màn hình Kid Zone, mặt sau thẻ khi chưa lật, dải trang trí ở mép màn hình.

## Ngân sách thị giác
Hoạ tiết nền **không được vượt quá 6% độ tương phản** so với nền `#FEF7FF`. Nếu
bạn nhìn thấy nó khi đang đọc chữ, nó đã quá đậm. Cách kiểm tra nhanh: chụp màn
hình, làm mờ 8 px — hoạ tiết phải biến mất, chủ thể thì không.

## Prompt A — hoạ tiết nền lặp (tile)

```text
A seamless tileable subtle background pattern of very sparse small rounded
shapes: soft dots, tiny rounded four-point sparkles and short rounded arcs,
scattered irregularly with very large empty gaps, all in lavender #F3EEFA on a
cream white #FEF7FF background, extremely low contrast, barely visible, calm.

STYLE: flat vector, minimal, geometric, soft rounded, matte flat fills, seamless
repeat, uniform density, no focal point.
NEGATIVE: text, letters, numbers, watermark, logo, high contrast, bold colors,
dense pattern, busy, crowded, gradient, glow, shadow, 3D, texture noise,
photographic grain, visible seams, directional flow, focal point.
```

## Prompt B — dải nền mềm ở chân màn hình

> ### 🔧 VẼ BẰNG CODE — không xuất file ảnh (1 asset)
>
> Hai quả đồi bo tròn chồng nhau là hai `ClipPath`/`CustomPaint` tô đặc. PNG ở
> đây tệ hơn vì dải chạy **hết chiều ngang màn hình**: một ảnh raster sẽ bị kéo
> giãn méo giữa điện thoại portrait, landscape và tablet — chính tình huống
> `design.md` §5 (Orientation and size) bắt phải sống sót. Đường cong vẽ bằng
> code thì co giãn đúng ở mọi bề ngang.
>
> Prompt giữ lại làm tham chiếu hình dạng.

```text
A wide soft horizontal band for the bottom of a screen: two overlapping very
gentle rounded hill shapes, back hill lavender #EBDDFF, front hill light violet
#E9DEF8, flat and simple, no texture, no detail, transparent above the hills,
16:9 frame with the hills occupying only the lower 25 percent.

STYLE: flat vector, minimal, geometric, soft rounded, matte flat fills, calm.
NEGATIVE: text, watermark, trees, houses, characters, clouds, sun, detail,
clutter, gradient mesh, glow, shadow, 3D, photorealism, high contrast.
```

## Prompt C — mặt sau thẻ (card back)

Mặt sau thẻ là nơi duy nhất hoạ tiết được phép đậm hơn — vì **không có chữ nào
đặt lên nó**.

```text
A card back design for a children's flashcard: a large rounded rectangle filled
with soft violet #68548E, a centered simple rounded emblem made of three
concentric rounded shapes in lavender #EBDDFF, a generous plain inner margin
around the emblem, very rounded corners, flat and clean.

STYLE: flat vector, geometric, symmetric, soft rounded corners, matte flat
fills, subtle paper grain, calm, child-safe.
NEGATIVE: text, letters, numbers, watermark, logo, playing card suits, casino
pattern, ornate filigree, dense pattern, clutter, gradient mesh, glow, metallic,
3D, glossy, heavy shadow, high contrast noise.
```

## Prompt D — vòng gợn khi chạm (touch ripple)

> ### 🔧 VẼ BẰNG CODE — không xuất file ảnh (1 asset)
>
> Dùng ripple sẵn có của Material (`InkWell` / `InkResponse`), tô bằng
> `splashColor` từ `ColorScheme`. Ripple **phải bắt đầu từ đúng điểm ngón tay
> chạm** — `design.md` §7: "Motion always starts from the thing the child
> touched". Một PNG vòng tròn không biết ngón tay ở đâu; `InkWell` thì biết.
>
> Prompt giữ lại chỉ cho trường hợp bạn cần một vòng gợn *tĩnh* làm trang trí.

```text
A single soft concentric ripple ring, three thin evenly spaced rounded rings
expanding from a common center, lavender #EBDDFF, transparent background, very
light, no fill inside.

STYLE: flat vector, minimal, geometric, soft, calm.
NEGATIVE: text, watermark, glow, sparkle, lens flare, motion blur, speed lines,
high contrast, neon, 3D, shadow, gradient mesh.
```

## Kiểm tra trước khi nhận
- [ ] Đặt chữ body của theme lên hoạ tiết A: vẫn đạt **4.5:1** (`design.md` §4).
- [ ] Làm mờ 8 px: hoạ tiết A biến mất.
- [ ] Tile A lặp không thấy đường nối.
- [ ] Mặt sau thẻ không chứa chữ, số, biểu tượng bài tây.
- [ ] Không hoạ tiết nào tạo hiệu ứng nhấp nháy/moiré khi cuộn — liên quan trực
      tiếp tới quy tắc "no flashing above three times per second" (`design.md` §7).
- [ ] Tất cả đều `ExcludeSemantics`.

## Export
`bg-pattern-tile.png` (1:1, 512 px, seamless) · `card-back.png` (3:4, 900×1200).
**Hai file.** Dải chân màn hình và ripple không xuất file — xem callout ở Prompt
B và Prompt D.

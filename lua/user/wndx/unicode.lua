-- AUTHOR: 'WANDEX/nvim-conf'
--
-- official unicode.org source - Blocks and Ranges
-- https://corp.unicode.org/~asmus/proposed_faq/blocks_ranges.html
--
-- direct links from the page:
-- [Blocks.txt](https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt)
-- [Unicode names list file](https://www.unicode.org/Public/UCD/latest/ucd/NamesList.txt)
--
-- fetch fresh ucd_blocks.txt:
-- $ curl -o ucd_blocks.txt https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt && \
-- $ echo "# vim:set noma:" >> ucd_blocks.txt
--
-- extra lookup ref: https://symbl.cc/en/unicode/blocks/

--- For the CJK & Nerd Fonts (2 term cells width)
--- :h setcellwidths | :h ambiwidth | test/adjust with:
--- $ nvim -c ':e $VIMRUNTIME/scripts/emoji_list.lua | :source %'
vim.fn.setcellwidths({

  -- FIXME: these symbols must be 1 term cell width
  -- |⌚| 2
  -- |⌛| 2
  -- |⏩| 2
  -- |⏪| 2
  -- |⏫| 2
  -- |⏬| 2
  -- |⏰| 2
  -- |⏳| 2
  -- |◽| 2
  -- |◾| 2

  -- Nerd Fonts add several glyphs to this area (e.g., pokeball, weather icons).
  -- Dingbats block is heavily used for various icon glyphs in Nerd Fonts.
  { 0x2600, 0x26FF, 1 }, -- Miscellaneous Symbols (includes some icons)
  { 0x2700, 0x27BF, 1 }, -- Dingbats

  -- CJK combined into one huge block
  { 0x2E00, 0xA4CF, 2 }, -- range: [Supplemental Punctuation..Yi Radicals]
  { 0xA4D0, 0xA4FF, 2 }, -- Lisu
  { 0xA500, 0xA63F, 2 }, -- Vai

  { 0x2A00, 0x2AFF, 1 }, -- Supplemental Mathematical Operators
  { 0x2B00, 0x2BFF, 1 }, -- Miscellaneous Symbols and Arrows

  { 0xF900, 0xFAFF, 2 }, -- CJK Compatibility Ideographs
  { 0xFE30, 0xFE4F, 2 }, -- CJK Compatibility Forms
  { 0xFE50, 0xFE6F, 2 }, -- Small Form Variants
  { 0xFF00, 0xFFEF, 2 }, -- Halfwidth and Fullwidth Forms

  -- Emojis typically have width 2 in terminals. Many Nerd Fonts icons reuse these emoji blocks.
  -- combined range: [Mahjong Tiles..Supplemental Symbols and Pictographs]
  { 0x1F000, 0x1F9FF, 2 }, -- Huge Chunk of Emojis and Symbols

  -- More recent emoji/pictograph additions.
  -- Includes many emojis, common in terminals and Nerd Fonts.
  { 0x1FA70, 0x1FAFF, 2 }, -- Symbols and Pictographs Extended-A
  { 0x1FB00, 0x1FBFF, 2 }, -- Symbols for Legacy Computing

  -- Huge blocks for Chinese, Japanese, and Korean (CJK) ideographs, normally width 1 or 2.
  -- TODO: lets see how it looks with width of 2 cells.
  { 0x20000,  0x2A6DF, 2 }, -- CJK Unified Ideographs Extension B
  { 0x2A700,  0x2B73F, 2 }, -- CJK Unified Ideographs Extension C
  { 0x2B740,  0x2B81F, 2 }, -- CJK Unified Ideographs Extension D
  { 0x2B820,  0x2CEAF, 2 }, -- CJK Unified Ideographs Extension E
  { 0x2CEB0,  0x2EBEF, 2 }, -- CJK Unified Ideographs Extension F
  { 0x2EBF0,  0x2EE5F, 2 }, -- CJK Unified Ideographs Extension I
  { 0x2F800,  0x2FA1F, 2 }, -- CJK Compatibility Ideographs Supplement
  { 0x30000,  0x3134F, 2 }, -- CJK Unified Ideographs Extension G
  { 0x31350,  0x323AF, 2 }, -- CJK Unified Ideographs Extension H
  { 0x323B0,  0x3347F, 2 }, -- CJK Unified Ideographs Extension J

  { 0xE0000,  0xE007F, 2 }, -- Tags
  { 0xE0100,  0xE01EF, 2 }, -- Variation Selectors Supplement

  { 0x0F0000, 0x0FFFFF, 2 }, -- Supplementary Private Use Area-A
  { 0x100000, 0x10FFFF, 2 }, -- Supplementary Private Use Area-B

})


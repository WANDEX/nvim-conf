-- configuration for the plugin "rmagatti/alternate-toggler"

local ok, altt = pcall(require, 'alternate-toggler')
if not ok then
  return
end

altt.setup {
  alternates = {

    ["ON"] = "OFF",
    ["On"] = "Off",
    ["on"] = "off",

  },
}

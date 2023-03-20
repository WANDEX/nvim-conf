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
    -- XXX: stupidity (not flips otherwise)
    ["OFF"] = "ON",
    ["Off"] = "On",
    ["off"] = "on",

  },
}

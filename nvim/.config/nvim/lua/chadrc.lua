-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
    theme = "dark_horizon",
    transparency = true,

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
    nvdash = {
        load_on_startup = true,
    },

    telescope = {
        style = "bordered",
    },

    statusline = {
        theme = "minimal",
        separator_style = "block",
        order = nil,
        modules = nil,
    },
}
-- M.mappings = require("lua.mappings")

return M

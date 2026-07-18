-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste",
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

-- CP template
local cp_group = vim.api.nvim_create_augroup("CP_Boilerplate", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cpp",
    group = cp_group,
    callback = function()
        -- Only trigger if the file is completely empty
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        if #lines == 1 and lines[1] == "" then
            -- Automatically trigger the 'cp' snippet we built earlier
            vim.cmd("normal! icp")
            -- Simulates pressing the expand key if using Luasnip natively,
            -- or you can just use feedkeys to expand it.
            -- Alternatively, use vim.api.nvim_buf_set_lines to hardcode text here.
        end
    end,
})

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end, { desc = "Append to harpoon list" })
vim.keymap.set("n", "<C-q>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste without changing buffer" })

-- Initialize a global variable to track Copilot's state. Assuming it starts as enabled.
vim.g.copilot_enabled = true

-- Map the toggle function to <leader>cC in normal mode.
vim.keymap.set("n", "<leader>cC", function()
  if vim.g.copilot_enabled then
    -- If Copilot is enabled, disable it.
    vim.cmd("Copilot disable")
    vim.g.copilot_enabled = false
    print("Copilot disabled")
  else
    -- If Copilot is disabled, enable it.
    vim.cmd("Copilot enable")
    vim.g.copilot_enabled = true
    print("Copilot enabled")
  end
end, { noremap = true, silent = true, desc = "Toggle Copilot" })

--
-- vim.keymap.set("n", "<C-h>", function()
--   harpoon:list():select(1)
-- end)
-- vim.keymap.set("n", "<C-t>", function()
--   harpoon:list():select(2)
-- end)
-- vim.keymap.set("n", "<C-n>", function()
--   harpoon:list():select(3)
-- end)
--
-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function()
--   harpoon:list():prev()
-- end)
-- vim.keymap.set("n", "<C-S-N>", function()
--   harpoon:list():next()
-- end)

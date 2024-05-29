require "nvchad.mappings"

local del_mappings = {
  i = {},
  n = {"<leader>h", "<leader>v", "<leader>wk", "<leader>x", "<leader>wK", "<leader>n", "<leader>rn", "<leader>/" },
  v = {},
}

local mappings = {
  n = {
    -- avoid saving to register
    { "x", '"_x' },
    { "X", '"_D' },
    { "dx", '"_dd' },
    { "s", "\"_s" },
    -- set mapping
    { "<leader><leader>m", ":e ~/.config/nvim/lua/mappings.lua <cr>" },
    -- vscode like line shift
    { "<c-j>", ':m .+1<cr>=='},
    { "<c-k>", ':m .-2<cr>=='},
    -- close
    { "<c-d-q>", ':q <cr>'},
    -- tab control
    {
      "<c-l>",
      function()
        require("nvchad.tabufline").next()
      end,
      { desc = "Buffer Goto next" },
    },
    {
      "<c-h>",
      function()
        require("nvchad.tabufline").prev()
      end,
      { desc = "Buffer Goto prev" },
    },
    {
      "<c-/>",
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      { desc = "Buffer Close" },
    },
    -- comment
    {
      "gc",
       function()
         require("Comment.api").toggle.linewise()
       end, { desc = "Comment Toggle" }
    },
    -- subversive
    { "<leader>r", "<Plug>(SubversiveSubstitute)", { noremap = true } },
    -- nvimtree
    {
      "<c-n>",
      function()
        require("nvim-tree.api").tree.toggle({
          find_file = true,
          update_root = true
        })
      end,
    },
    -- terminal
    {
      "<c-s><c-j>",
      function()
        require("nvchad.term").toggle { pos = "sp", id = "bottom1" }
        require("nvchad.term").toggle { pos = "vsp", id = "bottom2", size = 0.5 }
      end;
    },
    {
      "<c-s><c-l>",
      function()
        require("nvchad.term").toggle { pos = "vsp", id = "right1" }
      end
    },
    -- tab
    { "<c-s><c-n>", "<cmd>tabnew<cr>" },
    { "<c-s><c-c>", "<cmd>tabclose<cr>" },
    { "<c-s><c-l>", "<cmd>+tabnext<cr>" },
    { "<c-s><c-h>", "<cmd>-tabnext<cr>" },
    -- etc
    { "<", "<<" },
    { ">", ">>" },
    { "L", "$" },
    { "H", "^" },
    { "<c-s><c-s>", ":w<cr>"},
  },
  v = {
    -- avoid saving to register
    { "x", '"_x' },
    { "s", '"_s' },
    -- vscode like line shift
    {"<c-n>", ":m '>+1<cr>gv=gv"},
    {"<c-e>", ":m '<-2<cr>gv=gv"},
    -- return to the original position
    {"y", "ygv<esc>"},
    -- comment
    {
      "gc", "<Plug>(comment_toggle_linewise_visual)"
    },
  },
  t = {
    -- { "<c-s><c-k>",
    --   function()
    --     require("nvchad.term").toggle { pos = "sp", id = "bottom1" }
    --   end
    -- },
    {
      "<c-s><c-k>",
      function()
        require("nvchad.term").toggle { pos = "sp", id = "bottom1" }
        require("nvchad.term").toggle { pos = "vsp", id = "bottom2" }
      end
    },
    { "<c-s><c-h>", "<cmd>winc h<cr>" },
    { "<c-s><c-l>", "<cmd>winc l<cr>" },
    -- { "<c-s><c-n>", "<cmd>tabnew<cr>" },
    -- { "<c-s><c-q>", "<cmd>tabclose<cr>" },
    -- { "<c-s><c-l>", "<cmd>+tabnext<cr>" },
    -- { "<c-s><c-h>", "<cmd>-tabnext<cr>" },
    {
      "<esc>", "<C-\\><C-n>:"
    }
  }
}

for mode, mode_mappings in pairs(mappings) do
  for _, map in ipairs(mode_mappings) do
    local lhs, rhs, opts = map[1], map[2], map[3]
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

for mode, command in pairs(del_mappings) do
  for i = 1, #command do
    vim.keymap.del(mode, command[i])
  end
end

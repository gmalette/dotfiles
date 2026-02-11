{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Syntax highlighting via treesitter
      (nvim-treesitter.withPlugins (p: [
        p.ruby
        p.nix
        p.lua
        p.bash
        p.json
        p.yaml
        p.toml
        p.markdown
        p.markdown_inline
        p.python
        p.rust
        p.go
        p.javascript
        p.typescript
        p.html
        p.css
        p.diff
        p.gitcommit
        p.regex
      ]))

      # Quality of life
      vim-surround
      vim-commentary
      vim-sleuth        # auto-detect indent
      vim-fugitive      # git integration
    ];

    initLua = ''
      -- Sensible defaults
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.swapfile = false
      vim.opt.backup = false
      vim.opt.hidden = true
      vim.opt.splitbelow = true
      vim.opt.splitright = true
      vim.opt.cursorline = true
      vim.opt.signcolumn = "yes"
      vim.opt.termguicolors = true
      vim.opt.clipboard = "unnamedplus"
      vim.opt.scrolloff = 8
      vim.opt.list = true
      vim.opt.listchars = { tab = "→ ", trail = "×" }
      vim.opt.visualbell = true

      -- Clear search on Enter
      vim.keymap.set("n", "<CR>", ":nohlsearch<CR>", { silent = true })

      -- Reselect visual block after indent
      vim.keymap.set("v", "<", "<gv")
      vim.keymap.set("v", ">", ">gv")

      -- Beginning and end of line
      vim.keymap.set("n", "H", "^")
      vim.keymap.set("n", "L", "$")

      -- Make . work in visual mode
      vim.keymap.set("x", ".", ":norm.<CR>")

      -- Strip trailing whitespace on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          local pos = vim.api.nvim_win_get_cursor(0)
          vim.cmd([[%s/\s\+$//e]])
          vim.api.nvim_win_set_cursor(0, pos)
        end,
      })

      -- Resize splits on window resize
      vim.api.nvim_create_autocmd("VimResized", {
        callback = function()
          vim.cmd("wincmd =")
        end,
      })

      -- Treesitter (parsers are on runtimepath via Nix, just enable features)
      vim.treesitter.start()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = false
    '';
  };
}

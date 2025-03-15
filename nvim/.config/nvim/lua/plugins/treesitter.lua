return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "bash", "json", "php", "html", "css", "javascript" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}


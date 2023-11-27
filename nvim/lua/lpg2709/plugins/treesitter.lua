return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = { "bash", "c", "cmake", "cpp", "glsl", "lua", "rust", "vim" },
    },
}

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('ibl').setup {
    indent = { char = "┊" },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}

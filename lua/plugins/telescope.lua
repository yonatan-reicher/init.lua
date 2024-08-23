t = require('telescope')

t.setup {
    defaults = {
        layout_strategy = 'horizontal',
        scroll_strategy = 'limit',
        layout_config = {
            preview_cutoff = 0,
            center = {
            },
        },
    },
}

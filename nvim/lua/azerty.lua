-- Handle Azerty layout

local map = vim.keymap.set

map({ "n", "v" }, "à", "0", { silent = true })
map({ "n", "v" }, "&", "1", { silent = true })
map({ "n", "v" }, "é", "2", { silent = true })
map({ "n", "v" }, '"', "3", { silent = true })
map({ "n", "v" }, "'", "4", { silent = true })
map({ "n", "v" }, "(", "5", { silent = true })
map({ "n", "v" }, "-", "6", { silent = true })
map({ "n", "v" }, "è", "7", { silent = true })
map({ "n", "v" }, "_", "8", { silent = true })
map({ "n", "v" }, "ç", "9", { silent = true })

map({ "n", "v" }, "0", "à", { silent = true })
map({ "n", "v" }, "1", "&", { silent = true })
map({ "n", "v" }, "2", "é", { silent = true })
map({ "n", "v" }, "3", '"', { silent = true })
map({ "n", "v" }, "4", "'", { silent = true })
map({ "n", "v" }, "5", "(", { silent = true })
map({ "n", "v" }, "6", "-", { silent = true })
map({ "n", "v" }, "7", "è", { silent = true })
map({ "n", "v" }, "8", "_", { silent = true })
map({ "n", "v" }, "9", "ç", { silent = true })

map({ "n" }, "ù", "`", { silent = true })

map({ "n", "i" }, "§", "\\", { silent = true })

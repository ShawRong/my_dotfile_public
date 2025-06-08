-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 禁用动画和优化性能
vim.opt.winblend = 0 -- 禁用窗口透明混合
vim.opt.pumblend = 0 -- 禁用补全菜单透明
vim.opt.cursorline = false -- 禁用光标行高亮（显著提升流畅度）
vim.opt.lazyredraw = true -- 延迟重绘（减少宏/操作时的卡顿）
vim.opt.updatetime = 300 -- 更快的响应时间（默认4000ms）
vim.opt.timeoutlen = 300 -- 快捷键超时时间（降低延迟）
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

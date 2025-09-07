return {
    'vimwiki/vimwiki',
    init = function()
        vim.g.vimwiki_list = {
            {
                path = '/home/yaja/Documents/vimwiki',
                syntax = 'markdown',
                ext = '.md',
            }
        }
    end
}

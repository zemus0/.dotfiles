local css_file = vim.fn.stdpath 'data' .. '/github-markdown-dark.css'
return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
    os.execute('wget -O ' .. css_file .. ' https://raw.githubusercontent.com/sindresorhus/github-markdown-css/main/github-markdown-dark.css')
    local file = io.open(css_file, 'a')
    if file ~= nil then
      file:write '\n.markdown-body { box-sizing: border-box; min-width: 200px; max-width: 980px; margin: 0 auto; padding: 45px; }'
      file:close()
    end
  end,
  config = function()
    vim.g.mkdp_markdown_css = css_file
    vim.g.mkdp_theme = 'dark'
    vim.g.mkdp_browser = 'firefox'
  end,
}

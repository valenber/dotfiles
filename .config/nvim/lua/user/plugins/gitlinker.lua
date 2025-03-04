return {
  "ruifm/gitlinker.nvim",
  config = function()
    require("gitlinker").setup({
      callbacks = {
        ["github.com-qonto"] = function(url_data)
          url_data.host = "github.com"
          return require("gitlinker.hosts").get_github_type_url(url_data)
        end,
      },
    })
  end,
}

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  -- snippet = {
    -- expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
  -- end,
  -- },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local updated_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local setup_server = function(server, config)
  if not config then
  return
  end

  if type(config) ~= "table" then
  config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = 50,
    },
  }, config)

  lspconfig[server].setup(config)
end

local servers = {
  graphql = true,
  html = true,
  pyright = true,
  vimls = true,
  yamlls = true,
  jsonls = true,

  -- rust_analyzer = true,
  --   settings = {
  --     ["rust-analyzer"] = {
  --     },
  -- },

  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    settings = {
    scss = {
        lint = {
          idSelector = "warning",
          zeroUnits = "warning",
          duplicateProperties = "warning",
        },
        completion = {
          completePropertyWithSemicolon = true,
          triggerPropertyValueCompletion = true,
        },
      },
    },
  },

  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  jsonls = {
    cmd = {"vscode-json-language-server", "--stdio"},
    filetypes = {"json", "jsonc"},
    settings = {
  	json = {
  	  -- Schemas https://www.schemastore.org
  	  schemas = {
  		{
  		  fileMatch = {"package.json"},
  		  url = "https://json.schemastore.org/package.json"
  		},
  		{
  		  fileMatch = {"tsconfig*.json"},
  		  url = "https://json.schemastore.org/tsconfig.json"
  		},
  		{
  		  fileMatch = {
  			".prettierrc",
  			".prettierrc.json",
  			"prettier.config.json"
  		  },
  		  url = "https://json.schemastore.org/prettierrc.json"
  		},
  		{
  		  fileMatch = {".eslintrc", ".eslintrc.json"},
  		  url = "https://json.schemastore.org/eslintrc.json"
  		},
  		{
  		  fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
  		  url = "https://json.schemastore.org/babelrc.json"
  		},
  		{
  		  fileMatch = {"lerna.json"},
  		  url = "https://json.schemastore.org/lerna.json"
  		},
  		{
  		  fileMatch = {"now.json", "vercel.json"},
  		  url = "https://json.schemastore.org/now.json"
  		},
  		{
  		  fileMatch = {
  			".stylelintrc",
  			".stylelintrc.json",
  			"stylelint.config.json"
  		  },
  		  url = "http://json.schemastore.org/stylelintrc.json"
  		}
  	  }
  	}
    }
  }
}

for server, config in pairs(servers) do
  setup_server(server, config)
end

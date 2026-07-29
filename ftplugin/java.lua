local jdtls = require("jdtls")

local root_markers = { "gradlew", "mvnw", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.expand("~/.local/share/jdtls-workspace/") .. project_name

local mason_registry = require("mason-registry")
local jdtls_pkg = mason_registry.get_package("jdtls")
local jdtls_path = jdtls_pkg:get_install_path()

local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
local java_test_path = mason_registry.get_package("java-test"):get_install_path()

local lombok_path = vim.fn.expand("~/.local/share/lombok/lombok.jar")

local os_config = "linux"
local equinox_launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 👇 FIX: arma los bundles con vim.list_extend en vez de table.unpack
local bundles = {
	vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n", { trimempty = true })
)

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_path,
		"-jar",
		equinox_launcher,
		"-configuration",
		jdtls_path .. "/config_" .. os_config,
		"-data",
		workspace_dir,
	},

	root_dir = root_dir,
	capabilities = capabilities,

	settings = {
		java = {
			configuration = { updateBuildConfiguration = "automatic" },
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			inlayHints = { parameterNames = { enabled = "all" } },
			format = { enabled = true },
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
			},
		},
	},

	init_options = {
		bundles = bundles,
	},

	on_attach = function(client, bufnr)
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()

		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, opts)
		vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, opts)
		vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, opts)
		vim.keymap.set("v", "<leader>jm", function()
			jdtls.extract_method(true)
		end, opts)
		vim.keymap.set("n", "<leader>jt", jdtls.test_class, opts)
		vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, opts)
	end,
}

jdtls.start_or_attach(config)

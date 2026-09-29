-- =============================================================================
-- REFACTORIZACIONES Y ACCIONES EXCLUSIVAS PARA JAVA (ftplugin/java.lua)
-- =============================================================================
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Mapeamos el atajo maestro: Espacio + j + a (Solo disponible en buffers de Java)
vim.keymap.set("n", "<leader>ja", function()
	-- Lista de opciones garantizadas en el modal
	local options = {
		{ display = "   Generate constructor empty", value = "empty" },
		{ display = "   Generate constructor all attributes", value = "all" },
		{ display = "   Generate Getters and Setters", value = "getters_setters" },
		{ display = "   Organize Imports", value = "imports" },
	}

	pickers
		.new(
			{},
			require("telescope.themes").get_dropdown({
				prompt_title = "    Java Refactor Menu ",
				finder = finders.new_table({
					results = options,
					entry_maker = function(entry)
						return {
							value = entry.value,
							display = entry.display,
							ordinal = entry.display,
						}
					end,
				}),
				sorter = conf.generic_sorter({}),
				attach_mappings = function(prompt_bufnr, map)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)

						if not selection then
							return
						end

						-- 1. ANALIZADOR ROBUSTO: Leer archivo palabra por palabra
						local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
						local class_name = "Main"
						local fields = {}

						for _, line in ipairs(lines) do
							-- Limpiamos espacios y tabuladores
							local clean_line = line:gsub("^%s+", ""):gsub("%s+$", "")

							-- Extraer nombre de la clase
							if clean_line:find("class ") then
								local match = clean_line:match("class%s+(%w+)")
								if match then
									class_name = match
								end
							end

							-- Procesar atributos ignorando comentarios y anotaciones
							if
								not clean_line:find("^//")
								and not clean_line:find("^@")
								and not clean_line:find("%(")
								and clean_line:find(";")
							then
								local words = vim.split(clean_line, "%s+")
								if #words >= 3 then
									local modifier = words[1]
									if modifier == "private" or modifier == "public" or modifier == "protected" then
										local f_type = words[#words - 1]
										local f_name = words[#words]:gsub(";", "")

										if f_type and f_name and f_name ~= "" then
											table.insert(fields, { type = f_type, name = f_name })
										end
									end
								end
							end
						end

						-- Buscar la última llave '}' para inyectar los datos justo arriba
						local insert_line = vim.api.nvim_buf_line_count(0)
						for i = #lines, 1, -1 do
							if lines[i]:find("}") then
								insert_line = i - 1
								break
							end
						end

						-- 2. EJECUCIÓN DE ACCIONES
						local output = {}

						if selection.value == "empty" then
							table.insert(output, "")
							table.insert(output, "    public " .. class_name .. "() {")
							table.insert(output, "    }")
						elseif selection.value == "all" then
							local params = {}
							for _, f in ipairs(fields) do
								table.insert(params, f.type .. " " .. f.name)
							end
							table.insert(output, "")
							table.insert(
								output,
								"    public " .. class_name .. "(" .. table.concat(params, ", ") .. ") {"
							)
							for _, f in ipairs(fields) do
								table.insert(output, "        this." .. f.name .. " = " .. f.name .. ";")
							end
							table.insert(output, "    }")
						elseif selection.value == "getters_setters" then
							for _, f in ipairs(fields) do
								local cap_name = f.name:sub(1, 1):upper() .. f.name:sub(2)
								-- Getter
								table.insert(output, "")
								table.insert(output, "    public " .. f.type .. " get" .. cap_name .. "() {")
								table.insert(output, "        return this." .. f.name .. ";")
								table.insert(output, "    }")
								-- Setter
								table.insert(output, "")
								table.insert(
									output,
									"    public void set" .. cap_name .. "(" .. f.type .. " " .. f.name .. ") {"
								)
								table.insert(output, "        this." .. f.name .. " = " .. f.name .. ";")
								table.insert(output, "    }")
							end
						-- Buscas esta sección dentro de tu ftplugin/java.lua y la dejas así:
						elseif selection.value == "imports" then
							-- Eliminamos el comando de VS Code que causaba el error rojo.
							-- Usamos únicamente la acción de código estándar y nativa del protocolo LSP.
							vim.lsp.buf.code_action({
								context = { only = { "source.organizeImports" } },
								apply = true,
							})
							return
						end

						-- 3. INSERCIÓN E IDENTACIÓN DE TEXTO
						if #output > 0 then
							vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, output)
							vim.defer_fn(function()
								vim.lsp.buf.format({ async = true })
							end, 100)
						end
					end)
					return true
				end,
			})
		)
		:find()
end, { buffer = true, silent = true, desc = "Java: Ultimate Custom Actions" })

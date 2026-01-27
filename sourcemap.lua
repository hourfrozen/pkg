-- dont use this config for reference. it's made for pkg forks.
-- USE WITH: github.com/hourfrozen/pkg

local src = {}

local root, res, modules

-- build what's needed.
function src.init()
	local helper = require(script.Parent.Modules.helper)
	root = helper.generateInstance("Folder")
	root.Name = "pkg"
	root.Parent = workspace
	res = helper.generateInstance("Folder")
	res.Name = "res"
	res.Parent = root
	modules = helper.generateInstance("Folder")
	modules.Name = "Modules"
	modules.Parent = root
end

src.mapped = {
	{
		path = "src/Core/INTERNAL.lua",
		type = "ModuleScript",
		destination = root,
		name = "internal",
	},
	{
		path = "src/Core/Plugin.lua",
		type = "Script",
		destination = root,
		name = "Plugin",
	},
	{
		path = "src/Core/PluginModule.lua",
		type = "ModuleScript",
		destination = root,
		name = "PluginModule",
	},
	{
		path = "src/Modules/pkg.lua",
		type = "ModuleScript",
		destination = modules,
		name = "pkg",
	},
	{
		path = "src/Modules/github.lua",
		type = "ModuleScript",
		destination = modules,
		name = "github",
	},
	{
		path = "src/Modules/helper.lua",
		type = "ModuleScript",
		destination = modules,
		name = "helper",
	},
	{
		path = "src/Modules/RepositoryCoreModules/tools.lua",
		type = "ModuleScript",
		destination = modules,
		name = "tools",
	},
}

return src

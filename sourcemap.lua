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
	-- breaking my own rules..
	-- only acceptable instances of instance.new being used in a sourcemap, crucify me if you will idc.
	local contained = Instance.new("Frame", res)
	contained.Name = "contained"
	local warnbox = Instance.new("TextLabel", contained)
	warnbox.Name = "warning"
	local textbox = Instance.new("TextBox", contained)
	textbox.Name = "INPUT"
	contained.Size = UDim2.new(1, 0, 1, 0)
	warnbox.Text = "To use pkg, you must first enter your github token:"
	warnbox.TextScaled = true
	warnbox.Size = UDim2.new(1, 0, 0.1, 0)
	warnbox.Position = UDim2.new(0, 0, 1, 0)
	warnbox.AnchorPoint = Vector2.new(0, 1)
	warnbox.TextColor3 = Color3.new(1, 1, 1)
	warnbox.BackgroundColor3 = Color3.new(0, 0, 0)
	warnbox.BackgroundTransparency = 0.7
	contained.BackgroundColor3 = Color3.new(0, 0, 0)
	contained.BackgroundTransparency = 0.8
	textbox.PlaceholderText = "Type Here.."
	textbox.Size = UDim2.new(0.4, 0, 0.1, 0)
	textbox.Position = UDim2.new(0.5, 0, 0.5, 0)
	textbox.AnchorPoint = Vector2.new(0.5, 0.5)
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
	{
		path = "src/Modules/RepositoryCoreModules/static/sourcemapref.lua",
		type = "ModuleScript",
		destination = res,
		name = "sourcemapref",
	},
}

return src

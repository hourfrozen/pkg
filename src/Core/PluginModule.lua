local pluginModule = {}
local plugin -- Local plugin reference
local pkg = require(script.Parent.Modules.pkg)
local github = require(script.Parent.Modules.github)

-- hello
-- Initialize the plugin reference if not already set
function pluginModule:Initialize(pluginReference: Plugin)
	if plugin ~= pluginReference then
		plugin = pluginReference
		pkg.init()
		local toolbar = plugin:CreateToolbar("PKG")
		local gui2 = plugin:CreateDockWidgetPluginGuiAsync(
			"viewport",
			DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 200, 200, 200, 20)
		) -- viewport container
		local gui3 = script.Parent.res.contained:Clone()
		local input: TextButton = gui3.INPUT
		gui3.Parent = gui2

		local rSync = toolbar:CreateButton("Sync.", "Sync the game to the repository.", "rbxassetid://4998267428")
		rSync.Click:Connect(function()
			pkg.sync()
		end)
		local gui = toolbar:CreateButton("Open panel.", "Settings.", "rbxassetid://4998267428")
		gui.Click:Connect(function()
			if gui2.Enabled == false then
				gui2.Enabled = true
			else
				gui2.Enabled = false
			end -- simple
		end)
		task.spawn(function()
			local focus = false
			gui2.WindowFocused:Connect(function()
				focus = true
			end)
			gui2.WindowFocusReleased:Connect(function()
				focus = false
			end)
			input.InputEnded:Connect(function(io)
				if io.KeyCode == Enum.KeyCode.Return then
					if focus == true then
						local t = input.Text -- important
						local nonviable = false
						if t == nil or t == "" or t == " " then
							nonviable = true
						end
						if nonviable == false then
							print("ASSUMING ENTERED TEXT IS A GITHUB TOKEN")
							github.auth(t) -- TODO: this is also hacky, gotta fix
						end
					end
				end
			end)
		end)
	else
		error("Plugin is already initialized")
	end
end

-- Check if the plugin reference is set and print out appropriate info
function pluginModule:CheckForPluginGlobal()
	if plugin ~= nil then
		print("Plugin reference is set!")
	else
		warn("Plugin reference is missing!")
	end
end

return pluginModule

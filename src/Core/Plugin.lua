assert(plugin, "This script must be run as a plugin!")

function createVital() end

local pluginModule = require(script.Parent.PluginModule)
pluginModule:Initialize(plugin)

pluginModule:CheckForPluginGlobal()

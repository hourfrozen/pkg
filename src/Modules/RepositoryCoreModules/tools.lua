local tools = {}

function tools.extends(this: ModuleScript, module: ModuleScript): boolean
	local this = require(this)
	local module = require(module)
	local pointer = this.main
	local pointermodule = module.main

	if this.main then
		if typeof(pointer) == "table" then
			for i, v in pairs(pointermodule) do
				print(i)
				local key = tostring(i)
				pointer[key] = v
			end
			return true
		else
			return false
		end
	end
	return false
end

return tools

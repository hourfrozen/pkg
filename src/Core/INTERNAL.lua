local internalScript = {}

function internalScript.cleanSourcemap(input: string)
	input = input:gsub("Instance%.new", "require(script.Parent.Modules.helper).generateInstance")
	input = input:gsub("local%s+helper%s*=%s*[%w%p]+", "local helper = require(script.Parent.Modules.helper)")
	return input
end

return internalScript

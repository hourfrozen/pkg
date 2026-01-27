local helper = {}
helper.supportedInstances = {
	"Folder",
	"Script",
	"LocalScript",
	"ModuleScript",
}

-- Generate an IdKey parented to "parent". Helps to tell if an instance was forged by pkg or a pkg module init.
function helper.generateIdKey(parent: Instance)
	local ikey = Instance.new("StringValue")
	ikey.Parent = parent
	ikey.Name = "pkg"
	ikey.Value = "pkg"
end

-- Helps with generating instances, always warns if an instance is unsupported. NOTE: Designed to break a script if the script uses unsupported classes.
function helper.generateInstance(classname: string)
	if not helper.supportedInstances[classname] then
		warn("You cant create an instance of class name", classname)
		return false
	end
	local instance = Instance.new(classname)
	helper.generateIdKey(instance)
	return instance
end

return helper

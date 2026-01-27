local src = {}
src.safe = 1 -- we recommend not touching this
local helper = require(script.Parent.Parent.Parent.helper)

function src.init()
	-- this code runs first. edit this as you please.
	-- used for building your project, initializing it.
	-- useful function: helper.generateInstance(CLASSNAME: STRING)
	-- i advise against using instance.new here.
	helper.generateInstance("Folder", workspace).Name = "_pkg" -- you may remove this line.
end

-- your sourcemap.
src.mapped = {
	-- an example. this will take the file sourcemap.lua at your git's root and transform it into a modulescript, put it in _pkg and name it "srcmap".
	-- take your time to study this. no rush, rush may result in a broken build.
	{
		path = "sourcemap.lua",
		type = "ModuleScript",
		destination = workspace:WaitForChild("_pkg"),
		name = "srcmap",
	},
}

return src -- you need this, and the local src = {} variable. read up on lua modules if you do not understand.

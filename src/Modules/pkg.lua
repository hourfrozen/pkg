local pkg = {}
local github = require(script.Parent.github)
local helper = require(script.Parent.helper)
local INTERNAL = require(script.Parent.Parent.INTERNAL)
pkg.ver = 2
-- config
pkg.logPathing = false
pkg.verbose = false
-- config end

-- Initialize PKG
function pkg.init() -- removed v config
	local confl = script.Parent.Parent.res.conf
	local directory = game.ReplicatedFirst
	local confr = game.ReplicatedFirst:FindFirstChild("pkgconf")
	local function createconf()
		local newconf = confl:Clone()
		newconf.Name = "pkgconf"
		newconf.Parent = directory
		newconf.Value = pkg.ver
	end
	if not confr then
		createconf()
	elseif not confr:IsA("Folder") then
		confr:Destroy()
		createconf()
	end
	local confr = game.ReplicatedFirst:FindFirstChild("pkgconf")

	if confr.Value ~= confl.Value and confr.neverupgrade.Value == false then
		confr:Destroy()
		createconf()
	elseif confr.neverupgrade.Value == true then
		print("Configuration file is set to not upgrade.")
	end

	if confr.Value == confl.Value then
		print("Config is up to date.")
		warn("There is nothing to do!")
	end

	return confr
end

-- this is where the magic at
--
function pkg.sync()
	local confr = game.ReplicatedFirst:FindFirstChild("pkgconf")
	local sourcemapraw = github.repo_get(confr.user.Value, confr.repo.Value, "sourcemap.luau")
	local res1, srcmapdatraw = pcall(function()
		local it = Instance.new("ModuleScript")
		it.Parent = script.cache
		return require(sourcemapraw)
	end)
	local sourcemap = ""
	if res1 and srcmapdatraw.safe == 1 then
		sourcemap = INTERNAL.cleanSourcemap(sourcemapraw)
	elseif res1 and srcmapdatraw.safe == 0 then
		sourcemap = sourcemapraw
	end
	local srcinst = Instance.new("ModuleScript")
	srcinst.Parent = script.cache
	srcinst.Source = sourcemap
	local errors = 0

	local res, srcmapdat = pcall(function()
		return require(srcinst)
	end)
	if not res then
		errors += 1
		error("[1 - invalid sourcemap module] Invalid sourcemap, fix it to continue syncing your game.")
		return sourcemap
	end
	if not srcmapdat.mapped then
		errors += 1
		error("[2 - invalid properties] Invalid sourcemap, fix it to continue syncing your game.")
		return sourcemap
	end
	if pkg.verbose == true then
		print("data recieved")
	end

	for i, v in pairs(game:GetDescendants()) do
		if v:IsA("Script") or v:IsA("ModuleScript") or v:IsA("LocalScript") or v:IsA("Folder") then -- include support for folders.
			if v:FindFirstChild("pkg") and v:FindFirstChild("pkg"):IsA("StringValue") then
				if v:FindFirstChild("pkg").Value == "pkg" then
					v:Destroy()
				end
			end
		end
	end

	srcmapdat.init() -- build the project's requirements
	for i, v in pairs(srcmapdat.mapped) do
		local src = github.repo_get(confr.user.Value, confr.repo.Value, v.path)
		if src == "err1" then
			errors += 1
			warn("Hey, idiot. You didn't authenticate with github!")
			break
		end
		if pkg.logPathing == true then
			print(v.path, tostring(v.destination), v.type)
		end
		if v:IsA("Script") or v:IsA("ModuleScript") or v:IsA("LocalScript") then
			helper.generateInstance(v.type, v.destination).Source = src -- simple
		else
			helper.generateInstance(v.type, v.destination)
		end
	end

	if pkg.verbose == true then
		print("sync finished with ", errors, "errors")
	else
		print("Sync finished.")
	end

	return sourcemap
end

return pkg

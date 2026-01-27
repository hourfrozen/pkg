-- github api
local github = {}

local upgradelocations = { "hourfrozen", "pkg" } -- for pkg.fullupgrade
local http = game:GetService("HttpService")

local token = "none"

local githuburl = "https://api.github.com/repos/"

function github.auth(e_token: string)
	warn("[WARN] github: If the entered token is not a valid token, nothing will work.")
	token = e_token -- TODO: hacky, fix
end

function github.repo_get(username: string, repo: string, path: string)
	if token == "none" then
		error("[ERROR-1] github: You need a token to use this module.")
		return "err1"
	end
	local requrl = githuburl .. username .. "/" .. repo .. "/contents/" .. path

	local response = http:RequestAsync({
		Url = requrl,
		Method = "GET",
		Headers = {
			["Accept"] = "application/json",
			["Authorization"] = "Bearer " .. token,
			["X-GitHub-Api-Version"] = "2022-11-28",
		},
	})

	local seconds = 0
	while response.Success == false do
		task.wait()
		seconds += 0.1
		if seconds >= 5 then
			return 404
		end
	end

	local response = http:JSONDecode(response.Body)

	local content = http:RequestAsync({
		Url = response.download_url,
		Method = "GET",
		Headers = {
			["Accept"] = "application/json",
			["X-GitHub-Api-Version"] = "2022-11-28",
		},
	})

	seconds = 0
	while content.Success == false do
		task.wait(0.1)
		seconds += 0.1
		if seconds >= 5 then
			return 404
		end
	end

	return content.Body
end

return github

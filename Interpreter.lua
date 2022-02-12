local compile_source = game:GetObjects("rbxassetid://8798368363")[1].Source
local createExecutable_Source = game:GetObjects("rbxassetid://8798372776")[1].Source
local compile, createExecutable
local ok, dat = pcall(function()
	return {
		["comp"] = loadstring(compile_source)(),
		["crea"] = loadstring(createExecutable_Source)()
	}
end)

if ok == true and type(dat) == "table" then
	compile = dat.comp
	createExecutable = dat.crea
else
	return
end

getfenv().script = nil

return function(source, env)
	local executable
	local env = env or getfenv(2)
	local name = (env.script and env.script:GetFullName())
	local ran, failureReason = pcall(function()
		local compiledBytecode = compile(source, name)
		executable = createExecutable(compiledBytecode, env)
	end)
	
	if ran then
		return setfenv(executable, env)
	end
	return nil, failureReason
end

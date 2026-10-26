module(..., package.seeall)

function IsSkyValid(p)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for _, v in ipairs(all) do
		if v:__wf_atom_db682341() == p then
			return v
		end
	end

	return nil
end

function IsSkyMain(p)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for _, v in ipairs(all) do
		if v:__wf_atom_db682341() == p and v:__wf_atom_1d13ef4d() then
			return true
		end
	end

	return false
end

function GetActiveSky()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for _, v in ipairs(all) do
		if v:__wf_atom_1d13ef4d() then
			return v
		end
	end

	return nil
end

function GetSkyOrActiveSky(p)
	return IsSkyValid(p) or GetActiveSky()
end

function SwapSkyTo(p)
	if not IsSkyValid(p) then
		return
	end

	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for _, v in ipairs(all) do
		if v:__wf_atom_db682341() == p then
			v:Enable(true)
			v:__wf_atom_e2779837(true)
		else
			v:Enable(false)
			v:__wf_atom_e2779837(false)
		end
	end
end

function SetTimeOfDay(p, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:SetTimeOfDay(p)
end

function PauseTimeOfDay(p)
	local v = GetSkyOrActiveSky(p)

	if not v then
		return
	end

	v:SetTimeOfDayPaused(true)
end

function UnpauseTimeOfDay(p)
	local v = GetSkyOrActiveSky(p)

	if not v then
		return
	end

	v:SetTimeOfDayPaused(false)
end

local function fn(__wf_atom_cb3427c9, total, p, object)
	if total < __wf_atom_cb3427c9 then
		total += 24
	end

	object:SetTimeOfDay(__wf_atom_cb3427c9)
	local v = 1

	while v > 0 do
		v = math.max(0, v - __wf_atom_084b3e93() / p)
		local v2 = __wf_atom_24a82b69(v)
		object:SetTimeOfDay((__wf_atom_104bfe98(__wf_atom_cb3427c9, total, 1 - v2)))
		Sleep(0)
	end
end

function FadeTimeOfDay(p, p2, p3)
	local v = GetSkyOrActiveSky(p3)

	if not v then
		return
	end

	fn(gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9(), p, p2, v)
end

function SetTimeOfDayRate(p, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return nil
	end

	local __wf_atom_3e305fe5 = v:__wf_atom_3e305fe5()
	v:SetTimeOfDayRate(p)
	return __wf_atom_3e305fe5
end

function SetOvercast(p, value, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:SetOvercast(p, value or 0)
end

function SetWindy(p, value, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:SetWindy(p, value or 0)
end

function SetRaining(p, value, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:SetRaining(p, value or 0)
end

function SetLightning(p, value, p2, p3)
	local v = GetSkyOrActiveSky(p3)

	if not v then
		return
	end

	v:SetLightning(p, value or 1, p2 or false)
end

function SetStorming(p, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:SetOvercast(1, p)
	v:SetWindy(1, p)
	v:SetRaining(true, p)
	v:SetLightning(true, 0, true)
end

function SetRainbow(p, p2, value, value2, p3)
	local v = GetSkyOrActiveSky(p3)

	if not v then
		return
	end

	v:SetRainbow(p, p2 or false, value or 1, value2 or 0)
end

function ClearWeather(value, p)
	local v = GetSkyOrActiveSky(p)

	if not v then
		return
	end

	local v2 = value or 0
	v:SetOvercast(0, v2)
	v:SetWindy(0, v2)
	v:SetRaining(false, v2)
	v:SetLightning(false, 0, true)
	v:SetRainbow(false, false, 0, 0)
end

function ClearWeatherAndDisableCycle(value, p)
	local v = GetSkyOrActiveSky(p)

	if not v then
		return
	end

	local v2 = value or 0
	v:SetWeatherCycleEnabled(false)
	v:SetOvercast(0, v2)
	v:SetWindy(0, v2)
	v:SetRaining(false, v2)
	v:SetLightning(false, 0, true)
	v:SetRainbow(false, false, 0, 0)
end

function IsWindy(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsWindy()
	end

	return false
end

function IsOvercast(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsOvercast()
	end

	return false
end

function IsRaining(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsRaining()
	end

	return false
end

function WasPreviouslyRaining(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:WasPreviouslyRaining()
	end

	return false
end

function IsLightning(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsLightning()
	end

	return false
end

function IsLightningFlashing(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsLightningFlashing()
	end

	return false
end

function IsRainbow(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsRainbow()
	end

	return false
end

function IsDoubleRainbow(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsDoubleRainbow()
	end

	return false
end

function GetWindAmount(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:GetWindAmount()
	end

	return 0
end

function GetOvercastAmount(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:GetOvercastAmount()
	end

	return 0
end

function GetLightningFrequency(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:GetLightningFrequency()
	end

	return 0
end

function IsWeatherCycleEnabled(p)
	local v = GetSkyOrActiveSky(p)

	if v then
		return v:IsWeatherCycleEnabled()
	end

	return false
end

function SetWeatherCycleEnabled(p, value, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:SetWeatherCycleEnabled(p, value or 0)
end

function AddWeatherCycleChangeCallback(p, p2)
	local v = GetSkyOrActiveSky(p2)

	if not v then
		return
	end

	v:AddWeatherCycleChangeCallback(p)
end
local module = require("SF.Scripts.Libs.ModifySkyLib")

function WatchWeather(object)
	Sleep(0)

	if __wf_atom_7e8ad928(module) then
		return
	end

	local activeSky = module.GetActiveSky()
	local v = -1
	local v2 = -1

	while not (__wf_atom_7e8ad928(object) or object:IsKilled()) do
		if __wf_atom_7e8ad928(activeSky) or not activeSky:__wf_atom_1d13ef4d() then
			activeSky = module.GetActiveSky()

			if __wf_atom_7e8ad928(activeSky) then
				break
			end
		end

		local v3 = 1

		if activeSky:IsRaining() and activeSky:IsWindy() then
			v3 *= stormingVisionRangeMultiplier
		end

		if activeSky:GetOvercastAmount() >= 1 then
			v3 *= fogVisionRangeMultiplier
		end

		local v4 = math.max(v3, lowestVisionRangePercentage)

		if v4 ~= v then
			if v >= 0 and v < 1 then
				object:__wf_atom_d2b2176d():RemoveUpgrade(108, 2, v)
			end

			if v4 < 1 then
				object:__wf_atom_d2b2176d():AddUpgrade(108, 2, v4)
			end
		end

		local v5 = 1

		if activeSky:IsRaining() then
			v5 *= rainingHearingRangeMultiplier
		end

		if activeSky:IsWindy() then
			v5 *= windyHearingRangeMultiplier
		end

		local v6 = math.max(v5, lowestHearingRangePercentage)

		if v6 ~= v2 then
			if v2 >= 0 and v2 < 1 then
				object:__wf_atom_d2b2176d():RemoveUpgrade(111, 2, v2)
			end

			if v6 < 1 then
				object:__wf_atom_d2b2176d():AddUpgrade(111, 2, v6)
			end
		end

		Sleep(updateInterval)
		v2 = v6
		v = v4
	end
end
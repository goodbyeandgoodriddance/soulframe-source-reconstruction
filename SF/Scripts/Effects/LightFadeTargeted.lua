function BrightnessFadeTargetted()
	Sleep(Delay)
	local total = 0

	while total < TimeLength and not (InterruptOnCheckpoint and _T.RespawnInProgress) do
		local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)

		if not __wf_atom_7e8ad928(TargetLights) then
			for i = 1, #TargetLights do
				local targetLight = TargetLights[i]

				if not __wf_atom_7e8ad928(targetLight) then
					targetLight:__wf_atom_f5c11ad2(v)
				end
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function BrightnessFadeTargettedTurnOff()
	Sleep(Delay)
	local total = 0

	while total < TimeLength do
		local v = __wf_atom_104bfe98(OriginalValue, NewValue, total / TimeLength)

		if not __wf_atom_7e8ad928(TargetLights) then
			for i = 1, #TargetLights do
				TargetLights[i]:__wf_atom_f5c11ad2(v)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(TargetLights) then
		for i = 1, #TargetLights do
			local targetLight = TargetLights[i]

			if TurnOff then
				targetLight:TurnOff()
			end
		end
	end
end

function ChangeColour()
	Sleep(Delay)

	for _, v in ipairs(TargetLights) do
		v:SetColor(colour)
	end
end

function ChangeColorFade()
	Sleep(Delay)
	local total = 0
	local startColor = startColor
	local endColor = endColor

	if colorOverrideName ~= "" then
		if _T[colorOverrideName .. "StartColor"] then
			startColor = _T[colorOverrideName .. "StartColor"]
		end

		if _T[colorOverrideName .. "EndColor"] then
			endColor = _T[colorOverrideName .. "EndColor"]
		end
	end

	while total < TimeLength and not (InterruptOnCheckpoint and _T.RespawnInProgress) do
		startColor.red = __wf_atom_104bfe98(startColor.red, endColor.red, total / TimeLength)
		startColor.green = __wf_atom_104bfe98(startColor.green, endColor.green, total / TimeLength)
		startColor.blue = __wf_atom_104bfe98(startColor.blue, endColor.blue, total / TimeLength)

		for i = 1, #TargetLights do
			TargetLights[i]:SetColor(startColor)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function RadiusLerp()
	Sleep(Delay)
	local _startRadius = StartRadius
	local total = 0

	while total < TimeLength and not (InterruptOnCheckpoint and _T.RespawnInProgress) do
		local v = __wf_atom_104bfe98(StartRadius, NewRadius, total / TimeLength)

		if __wf_atom_7e8ad928(TargetLights) then
			continue
		end

		for i = 1, #TargetLights do
			TargetLights[i]:__wf_atom_400189c4(v)
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

function BrightnessFadePeakTargetted()
	Sleep(Delay)
	local total = 0

	while total < TimeLength do
		local v

		if total < Peak then
			v = total / Peak
		else
			v = 1 - (total - Peak) / (TimeLength - Peak)
		end

		local v2 = v < 0 and 0 or v
		local v3 = __wf_atom_104bfe98(ValleyValue, PeakValue, v2)

		if not __wf_atom_7e8ad928(TargetLights) then
			for i = 1, #TargetLights do
				TargetLights[i]:__wf_atom_f5c11ad2(v3)
			end
		end

		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end
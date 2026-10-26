module(..., package.seeall)
local v = { _ja = true, _zh = true, _tc = true }
local v2 = {
	Localize("/Lotus/Language/Sentiment/Neutrall", {}),
	Localize("/Lotus/Language/Sentiment/Happy", {}),
	Localize("/Lotus/Language/Sentiment/Angry", {}),
	Localize("/Lotus/Language/Sentiment/Sad", {}),
	Localize("/Lotus/Language/Sentiment/Contempt", {}),
	Localize("/Lotus/Language/Sentiment/Disgust", {}),
	Localize("/Lotus/Language/Sentiment/Afraid", {}),
	Localize("/Lotus/Language/Sentiment/Surprise", {})
}

function CalcMood(p)
	if _T.TransmissionMoodOverride == nil then
		_T.TransmissionMoodOverride = {}
	end

	if _T.TransmissionMoodOverride[p] ~= nil then
		return _T.TransmissionMoodOverride[p]
	end

	local v3 = { 0.75, 0, 0, 0, 0, 0, 0, 0 }
	local v4 = string.lower(Localize(p, {}))

	if v[__wf_atom_b953295d():c_str()] then
		for i = 1, #v2 do
			for _, v5 in ipairs(StringSplit(";", v2[i])) do
				if v5 ~= "" and string.find(v4, v5) then
					v3[i] = v3[i] + 0.5 + math.random()
				end
			end
		end
	else
		for k in string.gmatch(v4, "[^.:;!?\"()[%]%s]+") do
			local v5 = ";" .. k .. ";"

			for i = 1, #v2 do
				if string.find(v2[i], v5) then
					v3[i] = v3[i] + 0.5 + math.random()
				end
			end
		end
	end

	local v5 = 1
	local v6 = v3[v5]

	for i = 1, #v3 do
		if not (v6 < v3[i]) then
			continue
		end

		v6 = v3[i]
		v5 = i
	end

	local v7 = v5 - 1
	_T.TransmissionMoodOverride[p] = v7
	return v7
end
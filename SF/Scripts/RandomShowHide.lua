function RandomizeHide()
	if Random(0, 1) >= randomPercentChance / 100 then
		return
	end

	for _, v in ipairs(objectsList) do
		v:FirePort("Hide")
	end
end

function RandomizeShow()
	if Random(0, 1) >= randomPercentChance / 100 then
		return
	end

	for _, v in ipairs(objectsList) do
		v:FirePort("Show")
	end
end

function RandomSelect()
	objectsList[math.random(#objectsList)]:FirePort("Show")
end
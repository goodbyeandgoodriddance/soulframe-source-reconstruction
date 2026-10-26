local module = require("SF.Scripts.Libs.CommonFunctionsLib")

function ConnectToHub(value, instance)
	while
		gClient:__wf_atom_449cc668()
		or __wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7())
		or __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f())
		or __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f():__wf_atom_a96eb2aa())
	do
		Sleep(0)
	end

	if
		not __wf_atom_7e8ad928(instance)
		and type(value) ~= "string"
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_8efce136()
	then
		return
	end

	if not module.HasFragment(treeFragment) then
		return
	end

	local __wf_atom_22020464 = treeFragment:__wf_atom_22020464()
	local v = false

	for i = 1, #__wf_atom_22020464 do
		if not (module.HasSpecificLoreMemoryUnlocked(instance, treeFragment, __wf_atom_22020464[i]) and __wf_atom_22020464[i] == requiredTreeFragmentMemory) then
			continue
		end

		v = true
		break
	end

	if not v then
		return
	end

	if __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		local hubName = hubName

		if hubName == "" then
			if gGameRules:IsA(__wf_atom_589d05aa) then
				hubName = tostring(gGameRules:__wf_atom_72fc675e().location)
			else
				hubName = tostring(gRegion:__wf_atom_22941262():__wf_atom_5b41f63b())
			end
		end

		if string.find(hubName, "ETHEREAL") == nil then
			hubName ..= "ETHEREAL"
		end

		print("Connecting to ethereal hub " .. hubName .. "...")
		gGameRules:__wf_atom_efb96bf3(Symbol(hubName), "", -1, etherealAvatarType, etherealHubType)
		gMatchingService:__wf_atom_9ad738f8("Hub", "OnRelayP2PData")

		while not gMatchingService:__wf_atom_d309183e() do
			Sleep(0)
		end

		__wf_atom_f2daf912("Connected to ethereal hub " .. gMatchingService:__wf_atom_58c4b875())
	else
		__wf_atom_f2daf912("Already currently connected to hub: " .. gMatchingService:__wf_atom_58c4b875())
	end

	_T.EtherealHubSquadMembersChanged = OnSquadMembersChanged
	_T.EtherealHubActive = true
end

function DisconnectFromHub(value, instance)
	local v = Resource("/Lotus/Animations/Tenno/Emotes/Generic/VendorIdle_anim.fbx")
	local v2 = Resource("/SF/Types/Input/VendorInputFilter")

	if
		not __wf_atom_7e8ad928(instance)
		and type(value) ~= "string"
		and instance:IsA(__wf_atom_4ebf67cb)
		and not instance:__wf_atom_8efce136()
	then
		return
	end

	if gGameRules:__wf_atom_af3bd666() then
		local __wf_atom_c88ae023 = gGameRules:__wf_atom_c88ae023()

		if not __wf_atom_7e8ad928(__wf_atom_c88ae023) then
			__wf_atom_c88ae023:CancelTrade(false)
		end

		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_cf966a74(v2)

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:__wf_atom_1cfa7bd2()) then
				__wf_atom_c4f78a8f:__wf_atom_7ab15c94(nil)
			end

			if __wf_atom_c4f78a8f:__wf_atom_c138b19b(v) then
				__wf_atom_c4f78a8f:__wf_atom_33b8b73f(nil, false)
			end

			if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f:MotionControl()) then
				__wf_atom_c4f78a8f:MotionControl():__wf_atom_99fc7a82(false)
			end

			if __wf_atom_c4f78a8f:__wf_atom_9cc7b1b4() or __wf_atom_c4f78a8f:__wf_atom_7b686578() then
				__wf_atom_c4f78a8f:__wf_atom_014225b8(false)
				__wf_atom_c4f78a8f:__wf_atom_d02c2c68(false)
				gGameRules:OnAvatarTradeStatusChanged(__wf_atom_c4f78a8f)
				local v3 = "{\"status\":" .. gGameRules:__wf_atom_bfc92c34() .. "}"
				gGameRules:SendControlMessage(v3)
			end
		end

		local v3 = WeakResource("/SF/Interface/Trade.swf")
		local movie = __wf_atom_8e4fda44:FindMovie(v3)

		if not __wf_atom_7e8ad928(movie) then
			movie:Close()
		end
	end

	if not __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		__wf_atom_f2daf912("Disconnecting from ethereal hub " .. gMatchingService:__wf_atom_58c4b875())
		gGameRules:__wf_atom_94b3a9e1(false)

		while gMatchingService:__wf_atom_d309183e() do
			Sleep(0)
		end
	end

	if not __wf_atom_7e8ad928(gMatchingService) then
		gMatchingService:__wf_atom_6e77c646("")
	end

	if not __wf_atom_7e8ad928(etherealAvatarType) then
		for _, v3 in gRegion:FindAll(etherealAvatarType) do
			gRegion:__wf_atom_dd1e4d10(v3)
		end
	end

	_T.EtherealHubActive = nil
	_T.EtherealHubSquadMembersChanged = nil
end

function OnSquadMembersChanged(_, _, _)
	if __wf_atom_7e8ad928(gMatchingService:__wf_atom_9c7c90fb()) then
		return
	end

	local __wf_atom_bb46d8b6 = gMatchingService:__wf_atom_bb46d8b6()

	for _, v in __wf_atom_bb46d8b6 do
		local __wf_atom_d68faea4 = gMatchingService:__wf_atom_9c7c90fb():__wf_atom_d68faea4(v.onlineId)

		if __wf_atom_7e8ad928(__wf_atom_d68faea4) or not __wf_atom_d68faea4:IsA(etherealAvatarType) then
			continue
		end

		gRegion:__wf_atom_dd1e4d10(__wf_atom_d68faea4)
	end
end

local function fn(decoded)
	local __wf_atom_d68faea4 = gMatchingService:__wf_atom_9c7c90fb():__wf_atom_d68faea4(decoded.from)

	if not __wf_atom_7e8ad928(__wf_atom_d68faea4) then
		__wf_atom_d68faea4:__wf_atom_8a035cd5(Symbol("AsyncLoadEmote"), false, decoded.from .. "," .. decoded.msg.emote)
	end
end

function AsyncLoadEmote(object, value)
	if _T.hubEmoteQueue == nil then
		_T.hubEmoteQueue = {}
	end

	local v = string.split(value, ",")
	local v2 = v[1]
	local emo = WeakResource(v[2])

	if __wf_atom_7e8ad928(emo) then
		_T.hubEmoteQueue[v2] = nil
		object:__wf_atom_7ab15c94(emo)
	else
		_T.hubEmoteQueue[v2] = { emo = emo, loaded = false }
		gGameRules:RequestResource(v[2], EmoteLoaded, true)

		while _T.hubEmoteQueue[v2] ~= nil and _T.hubEmoteQueue[v2].emo == emo and not _T.hubEmoteQueue[v2].loaded do
			Sleep(0.2)
		end

		if _T.hubEmoteQueue[v2] ~= nil and _T.hubEmoteQueue[v2].emo == emo and _T.hubEmoteQueue[v2].loaded then
			object:__wf_atom_7ab15c94(Resource(emo))
			_T.hubEmoteQueue[v2] = nil
		end
	end
end

function EmoteLoaded(p, p2)
	if p then
		local v = WeakResource(p2)

		for _, v2 in pairs(_T.hubEmoteQueue) do
			if v2.emo == v then
				v2.loaded = true
			end
		end
	end
end

function OnRelayP2PData(_, p)
	local decoded = cjson.decode(p)

	if not decoded.msg then
		print("EtherealHub::OnRelayP2PData: " .. p)
		return
	end

	if decoded.msg.text ~= nil then
		return
	end

	if decoded.msg.emote ~= nil then
		fn(decoded)
	end
end
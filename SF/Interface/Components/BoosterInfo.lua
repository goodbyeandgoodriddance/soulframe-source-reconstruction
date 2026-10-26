module(..., package.seeall)
local module = require("SF.Interface.SFUtilities")
local BoosterInfo = {}
BoosterInfo.mMovie = nil
BoosterInfo.mActiveBoosters = {}
BoosterInfo.mDirty = false
BoosterInfo.mDirtyIndices = {}
BoosterInfo.mOnAddedCallbacks = {}
BoosterInfo.mOnRemovedCallbacks = {}

function BoosterInfo:Initialize(mMovie)
	self.mMovie = mMovie
	self.mActiveBoosters = {}
	self:Populate()
end

function BoosterInfo:Populate()
	self.mRefreshDelay = nil

	if self.mDirtyIndices == nil then
		self.mDirtyIndices = {}
	end

	local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

	if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
		return
	end

	self.mGameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()

	if __wf_atom_7e8ad928(self.mGameData) then
		return
	end

	local envoyInventoryControl = module.GetEnvoyInventoryControl()

	if __wf_atom_7e8ad928(envoyInventoryControl) then
		return
	end

	local __wf_atom_3babde87 = envoyInventoryControl:__wf_atom_3babde87()
	local v = {}

	for i = #self.mActiveBoosters, 1, -1 do
		local v2 = false

		for _, v3 in ipairs(__wf_atom_3babde87) do
			if v3.mItemType ~= self.mActiveBoosters[i].mItemType then
				continue
			end

			if v3.mItemType:__wf_atom_4eb36b35() then
				if Engine.__wf_atom_db2b0cee(v3.mExpiry) > 0 then
					v2 = true
					break
				end
			elseif v3.mUsesRemaining > 0 then
				v2 = true
				break
			end
		end

		if v2 then
			continue
		end

		self:OnRemoved(i)
		table.remove(self.mActiveBoosters, i)
		table.insert(self.mDirtyIndices, i)
	end

	for i = 1, #__wf_atom_3babde87 do
		local v2 = nil
		local v3 = false

		for j = 1, #self.mActiveBoosters do
			if self.mActiveBoosters[j].mItemType ~= __wf_atom_3babde87[i].mItemType then
				continue
			end

			v2 = self.mActiveBoosters[j]
			local v4 = __wf_atom_3babde87[i]

			if v4.mExpiry > v2.mExpiry then
				v2.mDuration = Engine.__wf_atom_db2b0cee(v4.mExpiry)
			end

			v3 = true
			break
		end

		if __wf_atom_7e8ad928(__wf_atom_3babde87[i].mItemType) then
			continue
		end

		if __wf_atom_3babde87[i].mItemType:__wf_atom_4eb36b35() then
			if Engine.__wf_atom_db2b0cee(__wf_atom_3babde87[i].mExpiry) > 0 then
				if v2 == nil then
					v2 = { mExpiry = __wf_atom_3babde87[i].mExpiry, mUsesRemaining = 0 }
				else
					v2.mExpiry = __wf_atom_3babde87[i].mExpiry
				end
			end
		elseif __wf_atom_3babde87[i].mUsesRemaining > 0 then
			if v2 == nil then
				v2 = { mUsesRemaining = __wf_atom_3babde87[i].mUsesRemaining }
			else
				v2.mUsesRemaining = __wf_atom_3babde87[i].mUsesRemaining
			end
		end

		if v3 or v2 == nil then
			continue
		end

		v2.mLocalizeTag = __wf_atom_3babde87[i].mItemType:__wf_atom_014a76a2()
		v2.mLocalizeDescTag = __wf_atom_3babde87[i].mItemType:__wf_atom_3a3d2e39()
		v2.mIconTexture = __wf_atom_3babde87[i].mItemType:GetIconTexture()
		v2.mDuration = __wf_atom_3babde87[i].mItemType:__wf_atom_e184ab04()
		v2.mUiColor = __wf_atom_3babde87[i].mItemType:__wf_atom_891bb0c5()
		v2.mItemType = __wf_atom_3babde87[i].mItemType

		if v2.mItemType:__wf_atom_4eb36b35() then
			table.insert(self.mActiveBoosters, v2)
			table.insert(self.mDirtyIndices, #self.mActiveBoosters)
			self:OnAdded(#self.mActiveBoosters)
		else
			table.insert(v, v2)
		end
	end

	if _T.HubBlessings then
		for _, hubBlessing in pairs(_T.HubBlessings) do
			local v2 = false

			for i = 1, #self.mActiveBoosters do
				local mActiveBooster = self.mActiveBoosters[i]

				if not mActiveBooster.mItemType:IsA(hubBlessing.mItemType) then
					continue
				end

				mActiveBooster.mExpiry = hubBlessing.mExpiry
				v2 = true
				break
			end

			if v2 or not (Engine.__wf_atom_db2b0cee(hubBlessing.mExpiry) > 0) then
				continue
			end

			local v3 = { mExpiry = hubBlessing.mExpiry, mUsesRemaining = 0 }
			v3.mLocalizeTag = hubBlessing.mItemType:__wf_atom_014a76a2()
			v3.mLocalizeDescTag = hubBlessing.mItemType:__wf_atom_3a3d2e39()
			v3.mIconTexture = hubBlessing.mItemType:GetIconTexture()
			v3.mDuration = hubBlessing.mItemType:__wf_atom_e184ab04()
			v3.mUiColor = hubBlessing.mItemType:__wf_atom_891bb0c5()
			v3.mItemType = hubBlessing.mItemType
			table.insert(self.mActiveBoosters, v3)
			table.insert(self.mDirtyIndices, #self.mActiveBoosters)
			self:OnAdded(#self.mActiveBoosters)
		end
	end

	for _, mActiveBooster in ipairs(self.mActiveBoosters) do
		if mActiveBooster.mExpiry == nil then
			continue
		end

		local __wf_atom_db2b0cee = Engine.__wf_atom_db2b0cee(mActiveBooster.mExpiry)

		if __wf_atom_db2b0cee > 0 and (self.mRefreshDelay == nil or __wf_atom_db2b0cee < self.mRefreshDelay) then
			self.mRefreshDelay = __wf_atom_db2b0cee
		end
	end

	self.mDirty = true
end

function BoosterInfo:FastUpdate()
	if self.mRefreshDelay == nil then
		self.mRefreshDelay = 10
		return false
	end

	self.mRefreshDelay -= __wf_atom_fa1258d0()

	if self.mRefreshDelay < 0 then
		self:Populate()
		return true
	else
		return false
	end
end

function BoosterInfo:Update()
	if self:FastUpdate() then
		if not __wf_atom_7e8ad928(self.mGameData) then
			self.mGameData:__wf_atom_3f16791f()
		end
	else
		if __wf_atom_7e8ad928(self.mGameData) then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				return false
			end

			self.mGameData = __wf_atom_18a5d83b:__wf_atom_9be88b01()

			if __wf_atom_7e8ad928(self.mGameData) then
				return false
			end
		end

		if not self.mGameData:__wf_atom_4524349e() then
			return false
		end

		self:Populate()
		self.mGameData:__wf_atom_3f16791f()
	end

	return true
end

function BoosterInfo.AddOnAddedCallback(p, p2, owner, callback)
	p.mOnAddedCallbacks[p2] = { Owner = owner, Callback = callback }
end

function BoosterInfo.AddOnRemovedCallback(p, p2, owner, callback)
	p.mOnRemovedCallbacks[p2] = { Owner = owner, Callback = callback }
end

function BoosterInfo.RemoveCallbacksForTag(p, p2)
	p.mOnAddedCallbacks[p2] = nil
	p.mOnRemovedCallbacks[p2] = nil
end

function BoosterInfo:OnAdded(p)
	for k, mOnAddedCallback in pairs(self.mOnAddedCallbacks) do
		if __wf_atom_7e8ad928(mOnAddedCallback.Owner) then
			self.mOnAddedCallbacks[k] = nil
		else
			mOnAddedCallback.Callback(p)
		end
	end
end

function BoosterInfo:OnRemoved(p)
	for k, mOnRemovedCallback in pairs(self.mOnRemovedCallbacks) do
		if __wf_atom_7e8ad928(mOnRemovedCallback.Owner) then
			self.mOnRemovedCallbacks[k] = nil
		else
			mOnRemovedCallback.Callback(p)
		end
	end
end

return BoosterInfo
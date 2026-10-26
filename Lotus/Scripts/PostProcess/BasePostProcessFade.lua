module(..., package.seeall)
local BasePostProcessFade = {}

function BasePostProcessFade.Fade(p, p2, p3)
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	if p3 == 0 then
		__wf_atom_8ad59546:__wf_atom_47f0b80b(p2)
		return
	end

	local total = 0

	while total < 1 do
		__wf_atom_8ad59546:__wf_atom_47f0b80b((__wf_atom_104bfe98(p, p2, total)))
		total += __wf_atom_084b3e93() / p3
		Sleep(0)

		if __wf_atom_7e8ad928(__wf_atom_8ad59546) then
			return
		end
	end

	__wf_atom_8ad59546:__wf_atom_47f0b80b(p2)
end

function BasePostProcessFade.AvatarFade(object, p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(object) or not object:__wf_atom_8efce136() then
		return
	end

	local total = 0
	local cameraControl = object:CameraControl()

	if
		__wf_atom_7e8ad928(cameraControl)
		and not cameraControl:IsA(WeakResource("/EE/Types/Engine/NullCameraController"))
	then
		return
	end

	local __wf_atom_787c4b2d = object:CameraControl():__wf_atom_787c4b2d()
	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()
	__wf_atom_8ad59546:__wf_atom_47f0b80b(p)

	if p5 ~= nil then
		__wf_atom_787c4b2d:__wf_atom_54a04966(p5)
	end

	Sleep(p4)

	while total < 1 do
		if __wf_atom_7e8ad928(object) or object:IsKilled() and __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) then
			return
		end

		__wf_atom_8ad59546:__wf_atom_47f0b80b((__wf_atom_104bfe98(p, p2, total)))
		total += __wf_atom_084b3e93() / p3
		Sleep(0)
	end

	__wf_atom_8ad59546:__wf_atom_47f0b80b(p2)
	print("PPF: BasePostProcessAvatarFadeEnd: " .. p2)
end

return BasePostProcessFade
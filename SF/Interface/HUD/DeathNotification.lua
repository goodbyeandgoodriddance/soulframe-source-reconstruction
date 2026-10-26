function Initialize()
	mMovie:__wf_atom_e57658c2("Notification", 12, 0)
	__wf_atom_ec43d06e(mMovie, "Notification", 2, { 12 }, { 100 }, 1, 0)
	mMovie:__wf_atom_e57658c2("Notification.ContentHeader", 11, 15385216)
	mMovie:__wf_atom_7d7314f1("Notification.ContentHeader.text", "/SF/Language/SystemMessages/DeathNotification")
	mMovie:__wf_atom_7d7314f1("Notification.Content.text", "/SF/Language/SystemMessages/DeathNotificationDesc")
end

function Update()
	mMovie:__wf_atom_88d9cd84(__wf_atom_fa1258d0())
end

function Shutdown() end
-- ScreenOptionsExportPackageSubPage underlay
-- this was hidden in beta 4...
-- i will leave this for now...

local t = Def.ActorFrame{
	Name="ScreenOptionsExportPackageSubPageUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Exports"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	-- edit: this breaks it... (plays music twice) don't do this...
};

return t;
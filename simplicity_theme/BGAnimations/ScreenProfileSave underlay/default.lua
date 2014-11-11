-- ScreenProfileSave underlay

local t = Def.ActorFrame{
	Name="ScreenProfileSaveUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Save Profile"),
	-- GLOBAL dark quad
	grid_t,
	-- GLOBAL play music
	main_song
};

return t;
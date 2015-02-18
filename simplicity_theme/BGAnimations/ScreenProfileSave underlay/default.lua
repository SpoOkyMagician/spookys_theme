-- ScreenProfileSave underlay

local t = Def.ActorFrame{
	Name="ScreenProfileSaveUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Save Profile"),
	-- Actor (scripts)
	grid_t,
	-- Actor (scripts)
	main_song
};

return t;
-- ScreenProfileLoad underlay

local t = Def.ActorFrame{
	Name="ScreenProfileLoadUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Load Profile"),
	-- Actor (scripts)
	grid_t,
	-- Actor (scripts)
	fast_song
};

return t;
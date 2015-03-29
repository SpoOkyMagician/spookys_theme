-- ScreenSelectGame underlay

local t = Def.ActorFrame{
	Name="ScreenSelectGameUnderlayActorFrame";
	-- Function (scripts)
	common_text("Select Game Mode"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;
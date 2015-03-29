-- ScreenNetworkOptions underlay

local t = Def.ActorFrame{
	Name="ScreenNetworkOptionsUnderlayActorFrame";
	-- Function (scripts)
	common_text("Network Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;
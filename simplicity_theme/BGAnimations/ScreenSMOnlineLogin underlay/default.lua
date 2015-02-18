-- ScreenSMOnlineLogin underlay

local t = Def.ActorFrame{
	Name="ScreenSMOnlineLoginUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("StepMania Online Login"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin"),
	-- Actor (scripts)
	slow_song
};

return t;
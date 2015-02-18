-- ScreenPlayerOptions underlay

local t = Def.ActorFrame{
	Name="ScreenPlayerOptionsUnderlayActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Function (scripts)
	common_text("Select Player Options"),
	-- Actor (scripts)
	grid_t,
	-- Function (scripts)
	theme_skin("options_theme_skin")
};

return t;
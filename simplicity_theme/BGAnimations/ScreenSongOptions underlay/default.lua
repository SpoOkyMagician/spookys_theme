-- ScreenSongOptions underlay

local t = Def.ActorFrame{
	Name="ScreenSongOptionsUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("Select Song Options"),
	-- GLOBAL dark quad
	grid_t,
	-- new theme skin i am experimenting with...
	LoadActor(THEME:GetPathG("","options_theme_skin"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	}
};

return t;
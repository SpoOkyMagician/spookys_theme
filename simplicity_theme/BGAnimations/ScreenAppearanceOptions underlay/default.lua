-- ScreenAppearanceOptions underlay

local t = Def.ActorFrame{
	Name="ScreenAppearanceOptionsUnderlayActorFrame";
	-- GLOBAL screen text
	common_text("Appearance Options"),
	-- GLOBAL dark quad
	grid_t,
	-- new theme skin i am experimenting with...
	Def.Sprite{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;Load,THEME:GetPathG("","options_theme_skin"));
	},
	-- GLOBAL play music
	slow_song
};

return t;
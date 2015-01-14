-- ScreenGameOver underlay

local t = Def.ActorFrame{
	Name="ScreenGameOverUnderlayActorFrame";
	-- GLOBAL Function Theme Color
	refresh_color(),
	-- GLOBAL screen text
	common_text("Game Over"),
	-- GLOBAL dark quad
	grid_t,
	LoadFont("SpoOky")..{
		Text="GAME OVER";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;shadowlength,1);
	},
	-- GLOBAL play music
	slow_song
};

return t;
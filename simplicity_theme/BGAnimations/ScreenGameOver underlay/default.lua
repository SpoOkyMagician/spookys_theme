-- ScreenGameOver underlay

local t = Def.ActorFrame{
	Name="ScreenGameOverUnderlayActorFrame";
	-- Function (scripts)
	common_text("Game Over"),
	-- Actor (scripts)
	grid_t,
	-- Actor (Game Over Text)
	LoadFont("Common", "normal")..{
		Text=ScreenString("Game Over");
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;shadowlength,1);
	},
	-- Actor (scripts)
	slow_song
};

return t;
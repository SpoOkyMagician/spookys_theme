local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen | Select Profile | Select Style | Select Game Mode | Select Music | Select Player Options | Select Song Options | Stage | Evaluation | Game Over |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	LoadFont("SpoOky")..{
		Text="GAME OVER";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5);
	},
	-- GLOBAL play music
	asian_song
};

return t;
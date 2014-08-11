local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="Title Screen | Options |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	-- GLOBAL play music
	asian_song
};

return t;
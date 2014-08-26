-- ScreenSMOnlineLogin underlay

local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="StepMania Online Login";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	},
	-- GLOBAL play music
	sub_song
};

return t;
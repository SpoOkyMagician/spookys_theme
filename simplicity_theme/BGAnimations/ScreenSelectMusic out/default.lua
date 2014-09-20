-- ScreenSelectMusic out

local t = Def.ActorFrame{
	-- GLOBAL quad fades to black
	grid_slow_fade_out,
	-- inform player of options screen...
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+200,SCREEN_RIGHT-2,SCREEN_BOTTOM-200;diffuse,color("0,0,0,1"));
	},
	LoadFont("SpoOky")..{
		Text="Press Enter again to select options!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,0");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OffCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0)
	}
};

return t;
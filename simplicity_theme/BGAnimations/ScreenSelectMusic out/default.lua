-- ScreenSelectMusic out

local t = Def.ActorFrame{
	Name="ScreenSelectMusicOutActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Actor (scripts)
	grid_slow_fade_out,
	-- Actor (Inform Player of Options Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+200,SCREEN_RIGHT-2,SCREEN_BOTTOM-200;diffuse,color("0,0,0,1"));
	},
	-- Actor (Inform Player of Options Text)
	LoadFont("Common","normal")..{
		Text=ScreenString("Press") .. " &START; " .. ScreenString("For Options") .. "!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;diffuse,color("1,0.8,0,0");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OffCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0)
	}
};

return t;
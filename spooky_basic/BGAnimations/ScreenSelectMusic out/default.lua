local t = Def.ActorFrame{
	-- fades to black
	Def.Quad{
		OnCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color("0,0,0,0");sleep,0.5;diffuse,color("0,0,0,0.1");sleep,0.5;diffuse,color("0,0,0,0.2");sleep,0.5;diffuse,color("0,0,0,0.3");sleep,0.5;diffuse,color("0,0,0,0.4");sleep,0.5;diffuse,color("0,0,0,0.5");sleep,0.5;diffuse,color("0,0,0,0.6");sleep,0.5;diffuse,color("0,0,0,0.7");sleep,0.5;diffuse,color("0,0,0,0.8");sleep,0.5;diffuse,color("0,0,0,0.9");sleep,0.5;diffuse,color("0,0,0,1"));
	},
	-- inform player of options screen...
	LoadFont("Common normal")..{
		Text="Press Enter again to select options!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,0");align,0.5,0.5;zoom,2.0);
		OffCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0)
	}
};

return t;
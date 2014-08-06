local t = Def.ActorFrame{
	--[ black quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,Color("Black"));
	},
	--[ dark gold header quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color("0.4,0.3,0,1"));
	},
	--[ dark gold footer quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color("0.4,0.3,0,1"));
	},
	--[ top border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+2;diffuse,color(theme_color));
	},
	--[ bottom border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-2,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color));
	},
	--[ left border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_LEFT+2,SCREEN_BOTTOM;diffuse,color(theme_color));
	},
	--[ right border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-2,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_color));
	},
	--[ profile border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM-28;diffuse,color(theme_color));
	},
	--[ screen border
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP+28,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_color));
	},
	--[ player border
	--[Def.Quad{
	--[	InitCommand=cmd(stretchto,SCREEN_CENTER_X-2,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM;diffuse,color(theme_color));
	--[};
	--[ screen text
	LoadFont("Common normal")..{
		Text="Title Screen | Options | Reload Songs |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	--[ play music
	asian_song
};

return t;
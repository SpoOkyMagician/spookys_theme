local t = Def.ActorFrame{
	--[ black quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color("0,0,0,1"))
	},
	--[ dark gold header quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_TOP+30;diffuse,color(theme_dark_color));
	},
	--[ dark gold footer quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT,SCREEN_BOTTOM-30,SCREEN_RIGHT,SCREEN_BOTTOM;diffuse,color(theme_dark_color));
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
	--[ neat arrows
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32);
	},
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32);
	},
	--[ screen text
	LoadFont("Common normal")..{
		Text="Title Screen |";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5);
	},
	--[ logo extra text
	LoadFont("Common normal")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3.75+4;diffuse,color(theme_color);diffusebottomedge,color("0,0,0,1");zoom,2.0;align,0.5,0.5);
	},
	--[ logo text
	LoadFont("Common normal")..{
		Text="STEPMANIA 5";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/3.75;diffuse,color(theme_color);zoom,2.0;align,0.5,0.5);
	},
	--[ product version text
	LoadFont("Common normal")..{
		Text=ProductVersion();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+32;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	--[ build date text
	LoadFont("Common normal")..{
		Text=VersionDate();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+48;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	--[ build time text
	LoadFont("Common normal")..{
		Text=VersionTime();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+64;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	--[ server text
	LoadFont("Common normal")..{
		Text=GetServerName();
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+80;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	--[ server text
	LoadFont("Common normal")..{
		Text=tostring(IsNetConnected());
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y/0.7+96;diffuse,color(theme_color);zoom,0.5;align,0.5,0.5);
	},
	--[ play music
	main_song
};

return t;
-- ScreenGameplay ready

local t = Def.ActorFrame{
	--[ screen text
	LoadFont("SpoOky")..{
		Text="Are you ready?";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;sleep,0.1;diffuse,color("1,0.8,0,0.9");sleep,0.1;diffuse,color("1,0.8,0,0.8");sleep,0.1;diffuse,color("1,0.8,0,0.7");sleep,0.1;diffuse,color("1,0.8,0,0.6");sleep,0.1;diffuse,color("1,0.8,0,0.6");sleep,0.1;diffuse,color("1,0.8,0,0.5");sleep,0.1;diffuse,color("1,0.8,0,0.4");sleep,0.1;diffuse,color("1,0.8,0,0.3");sleep,0.1;diffuse,color("1,0.8,0,0.2");sleep,0.1;diffuse,color("1,0.8,0,0.1");sleep,0.1;diffuse,color("1,0.8,0,0"))
	};
};

return t;
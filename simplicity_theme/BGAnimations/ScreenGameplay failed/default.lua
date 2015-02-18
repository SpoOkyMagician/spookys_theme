-- ScreenGameplay failed

local t = Def.ActorFrame{
	Name="ScreenGameplayFailedActorFrame";
	-- Function (scripts)
	refresh_color(),
	-- Actor (Failed Text)
	LoadFont("Common", "normal")..{
		Text=ScreenString("Failed");
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;sleep,0.2;diffuse,color("1,0.8,0,0.8");sleep,0.1;diffuse,color("1,0.8,0,0.6");sleep,0.1;diffuse,color("1,0.8,0,0.4");sleep,0.1;diffuse,color("1,0.8,0,0.2");sleep,0.1;diffuse,color("1,0.8,0,0");sleep,0.1;diffuse,color("1,0.8,0,0.2");sleep,0.1;diffuse,color("1,0.8,0,0.4");sleep,0.1;diffuse,color("1,0.8,0,0.6");sleep,0.1;diffuse,color("1,0.8,0,0.8");sleep,0.1;diffuse,color("1,0.8,0,1"))
	}
};

return t;
-- ScreenGameplay ready

local t = Def.ActorFrame{
	Name="ScreenGameplayReadyActorFrame";
	-- Actor (Screen Text)
	LoadFont("Common","normal")..{
		Text=ScreenString("Are you ready") .. "?";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;align,0.5,0.5;diffuse,color("1,0.8,0,1");finishtweening;diffuse,color("1,0.8,0,1");linear,1.1;diffuse,color("1,0.8,0,0"));
	}
};

return t;
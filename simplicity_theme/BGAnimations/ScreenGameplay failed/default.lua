-- ScreenGameplay failed

local t = Def.ActorFrame{
	Name="ScreenGameplayFailedActorFrame";
	-- Actor/Function (Screen Transition Left)
	transition_door_left_close(),
	-- Actor/Function (Screen Transition Right)
	transition_door_right_close(),
	-- Actor (Fake Door Sound)
	LoadActor(THEME:GetPathS("","Player mine"))..{
		OffCommand=function(self)
			self:play();
		end;
	},
	-- Actor (Failed Text)
	LoadFont("Common", "normal")..{
		Text=ScreenString("Failed");
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;align,0.5,0.5;finishtweening;diffuse,color("1,0.8,0,1");spring,1;diffuse,color("1,0.8,0,0.0"));
	}
};

return t;
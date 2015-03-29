-- ScreenGameplay failed

local t = Def.ActorFrame{
	Name="ScreenGameplayFailedActorFrame";
	-- Actor (Screen Transition Left)
	LoadActor(THEME:GetPathG("", "screen_transition_left"))..{
		InitCommand=cmd(x,SCREEN_LEFT-213;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:x(SCREEN_LEFT-200);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-180);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-160);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-140);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-120);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-100);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-80);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-60);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-40);
			self:sleep(0.01);
			self:x(SCREEN_LEFT-20);
			self:sleep(0.01);
			self:x(SCREEN_LEFT);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+20);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+40);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+60);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+80);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+100);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+120);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+140);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+160);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+180);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+200);
			self:sleep(0.01);
			self:x(SCREEN_LEFT+213);
			self:sleep(0.01);
		end;
	},
	-- Actor (Screen Transition Right)
	LoadActor(THEME:GetPathG("", "screen_transition_right"))..{
		InitCommand=cmd(x,SCREEN_RIGHT+213;y,SCREEN_CENTER_Y);
		OnCommand=function(self)
			self:x(SCREEN_RIGHT+200);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+180);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+160);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+140);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+120);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+100);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+80);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+60);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+40);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT+20);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-20);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-40);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-60);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-80);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-100);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-120);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-140);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-160);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-180);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-200);
			self:sleep(0.01);
			self:x(SCREEN_RIGHT-213);
			self:sleep(0.01);
		end;
	},
	-- Actor (Test)
	LoadActor(THEME:GetPathS("","Player mine"))..{
		OffCommand=function(self)
			self:play();
		end;
	},
	-- Actor (Failed Text)
	LoadFont("Common", "normal")..{
		Text=ScreenString("Failed");
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;zoom,2.0;shadowlength,1);
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("1,0.8,0,1");align,0.5,0.5;sleep,0.2;diffuse,color("1,0.8,0,0.8");sleep,0.1;diffuse,color("1,0.8,0,0.6");sleep,0.1;diffuse,color("1,0.8,0,0.4");sleep,0.1;diffuse,color("1,0.8,0,0.2");sleep,0.1;diffuse,color("1,0.8,0,0");sleep,0.1;diffuse,color("1,0.8,0,0.2");sleep,0.1;diffuse,color("1,0.8,0,0.4");sleep,0.1;diffuse,color("1,0.8,0,0.6");sleep,0.1;diffuse,color("1,0.8,0,0.8");sleep,0.1;diffuse,color("1,0.8,0,1"))
	}
};

return t;
-- ScreenSelectMusic out

local t = Def.ActorFrame{
	Name="ScreenSelectMusicOutActorFrame";
	-- Actor/Function (Screen Transition Left)
	transition_door_left_close(),
	-- Actor/Function (Screen Transition Right)
	transition_door_right_close(),
	-- Actor (Inform Player of Options Quad)
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+2,SCREEN_TOP+200,SCREEN_RIGHT-2,SCREEN_BOTTOM-200;diffuse,color("0,0,0,1"));
		OnCommand=function(self)
			self:finishtweening();
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+180,SCREEN_RIGHT-2,SCREEN_BOTTOM-180)
			self:sleep(0.1);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+160,SCREEN_RIGHT-2,SCREEN_BOTTOM-160)
			self:sleep(0.09);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+140,SCREEN_RIGHT-2,SCREEN_BOTTOM-140)
			self:sleep(0.08);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+120,SCREEN_RIGHT-2,SCREEN_BOTTOM-120)
			self:sleep(0.07);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+100,SCREEN_RIGHT-2,SCREEN_BOTTOM-100)
			self:sleep(0.06);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+80,SCREEN_RIGHT-2,SCREEN_BOTTOM-80)
			self:sleep(0.05);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+60,SCREEN_RIGHT-2,SCREEN_BOTTOM-60)
			self:sleep(0.04);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+40,SCREEN_RIGHT-2,SCREEN_BOTTOM-40)
			self:sleep(0.03);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP+20,SCREEN_RIGHT-2,SCREEN_BOTTOM-20)
			self:sleep(0.02);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP,SCREEN_RIGHT-2,SCREEN_BOTTOM)
			self:sleep(0.01);
		end;
	},
	-- Actor (Inform Player of Options Text)
	LoadFont("Common","normal")..{
		Text=ScreenString("Press") .. " &START; " .. ScreenString("For Options") .. "!";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;finishtweening;diffuse,color(theme_color);align,0.5,0.5;zoom,2.0;shadowlength,1);
	},
	-- Actor (Fake Door Sound)
	LoadActor(THEME:GetPathS("","Player mine"))..{
		OffCommand=function(self)
			self:play();
		end;
	}
};

return t;
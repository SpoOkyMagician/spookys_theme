-- ScreenSelectMusic out

local t = Def.ActorFrame{
	Name="ScreenSelectMusicOutActorFrame";
	-- Actor (scripts)
--	grid_slow_fade_out,
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
	-- Actor (Test)
	LoadActor(THEME:GetPathS("","Player mine"))..{
		OffCommand=function(self)
			self:play();
		end;
	}
};

return t;
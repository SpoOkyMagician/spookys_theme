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
			self:accelerate(3);
			self:stretchto(SCREEN_LEFT+2,SCREEN_TOP,SCREEN_RIGHT-2,SCREEN_BOTTOM)
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
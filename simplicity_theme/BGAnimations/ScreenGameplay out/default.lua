-- ScreenGameplay out

local t = Def.ActorFrame{
	Name="ScreenGameplayOutActorFrame";
	-- Actor/Function (Screen Transition Left)
	transition_door_left_close(),
	-- Actor/Function (Screen Transition Right)
	transition_door_right_close(),
	-- Actor (Fake Door Sound)
	LoadActor(THEME:GetPathS("","Player mine"))..{
		OffCommand=function(self)
			self:play();
		end;
	}
};

return t;
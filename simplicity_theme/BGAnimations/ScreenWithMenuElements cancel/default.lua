-- ScreenWithMenuElements out

local t = Def.ActorFrame{
	Name="ScreenWithMenuElementsOutActorFrame";
	-- Actor/Function (Screen Transition Left)
	transition_door_left_close(),
	-- Actor/Function (Screen Transition Right)
	transition_door_right_close(),
	-- Actor (Fake Door Sound)
	LoadActor(THEME:GetPathS("","Player mine"))..{
		CancelCommand=function(self)
			self:play();
		end;
	}
};

return t;
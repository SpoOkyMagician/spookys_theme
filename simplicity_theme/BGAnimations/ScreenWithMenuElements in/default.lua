-- ScreenWithMenuElements in

local t = Def.ActorFrame{
	Name="ScreenWithMenuElementsInActorFrame";
	-- Actor/Function (Screen Transition Left)
	transition_door_left_open(),
	-- Actor/Function (Screen Transition Right)
	transition_door_right_open()
};

return t;
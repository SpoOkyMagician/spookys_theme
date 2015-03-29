-- ScreenGameplaySyncMachine underlay

local t = Def.ActorFrame{
	Name="ScreenGameplaySyncMachineActorFrame";
	-- Actor (Generic BG)
	LoadActor(THEME:GetPathG("","bg_generic"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	},
	-- Actor (scripts)
	grid_u
};

return t;
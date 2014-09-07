-- ScreenNetRoom underlay

local t = Def.ActorFrame{
	-- screen text
	LoadFont("SpoOky")..{
		Text="StepMania Online Lobby";
		InitCommand=cmd(x,SCREEN_LEFT+8;y,SCREEN_TOP+13;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
	}
	-- i clearly have no idea what i am doing but, i am gonna try...
--	LoadFont("SpoOky")..{
--		Text="N/A";
--		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color(theme_color);zoom,0.5;align,0,0.5;shadowlength,1);
--		OnCommand=function(self)
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_SMOnlinePack', 0.1);
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_BackFromRoomName', 0.1);
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_BackFromRoomDesc', 0.1);
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_BackFromRoomPass', 0.1);
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_BackFromReqPass', 0.1);
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_RoomInfoRetract', 0.1);
	--		SCREENMAN:GetTopScreen():PostScreenMessage('SM_RoomInfoDeploy', 0.1);
--			self:queuecommand('Info');
--		end;
--		InfoCommand=function(self)
--			self:settext("Test");
--		end;
	--	RoomInfoRetract=cmd(playcommand,'Info');
	--	RoomInfoDeployMessageCommand=cmd(playcommand,'Info');
	--	BackFromRoomNameMessageCommand=cmd(playcommand,'Info');
	--	RoomInfoRetractMessageCommand=cmd(playcommand,'Info');
	--	RoomInfoDeployMessageCommand=cmd(playcommand,'Info');
--	}
};

return t;
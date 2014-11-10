-- ScreenSelectStyle underlay

local t = Def.ActorFrame{
	-- GLOBAL screen text
	common_text("Select Style"),
	-- menu items quad
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+314,SCREEN_BOTTOM/2-18,SCREEN_RIGHT-314,SCREEN_BOTTOM/2+18;diffuse,color("0,0,0,0.5"));
	},
	-- neat arrows
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-96;y,SCREEN_CENTER_Y;baserotationz,90;SetSize,32,32);
		OnCommand=function(self)
			self:queuecommand("UpLeft");
		end;
		UpLeftCommand=function(self)
			self:x(SCREEN_CENTER_X-96-2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96-1);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96+2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X-96+1);
			self:sleep(0.02);
		end;
		MenuLeft1MessageCommand=cmd(playcommand,"UpLeft");
		MenuUp1MessageCommand=cmd(playcommand,"UpLeft");
		MenuLeft2MessageCommand=cmd(playcommand,"UpLeft");
		MenuUp2MessageCommand=cmd(playcommand,"UpLeft");
		MenuSelectionChangedMessageCommand=cmd(playcommand,"UpLeft");
	},
	LoadActor(THEME:GetPathG("","arrow"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y;baserotationz,-90;SetSize,32,32);
		OnCommand=function(self)
			self:queuecommand("DownRight");
		end;
		DownRightCommand=function(self)
			self:x(SCREEN_CENTER_X+96+2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96+1);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96-2);
			self:sleep(0.02);
			self:x(SCREEN_CENTER_X+96-1);
			self:sleep(0.02);
		end;
		MenuRight1MessageCommand=cmd(playcommand,"DownRight");
		MenuDown1MessageCommand=cmd(playcommand,"DownRight");
		MenuRight2MessageCommand=cmd(playcommand,"DownRight");
		MenuDown2MessageCommand=cmd(playcommand,"DownRight");
		MenuSelectionChangedMessageCommand=cmd(playcommand,"DownRight");
	},
	-- GLOBAL play music
	fast_song
};

return t;
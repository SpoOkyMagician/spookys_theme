local t = Def.ActorFrame{
	-- GLOBAL dark gold header quad
	grid_b,
	-- GLOBAL dark gold footer quad
	grid_c,
	-- GLOBAL top border
	grid_d,
	-- GLOBAL bottom border
	grid_e,
	-- GLOBAL left border
	grid_f,
	-- GLOBAL right border
	grid_g,
	-- GLOBAL profile border
	grid_h,
	-- GLOBAL screen border
	grid_i,
	-- back life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+402,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- back life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_RIGHT-402,SCREEN_TOP+2,SCREEN_RIGHT-102,SCREEN_TOP+28;diffuse,color("0.1,0.1,0.1,1"));
	},
	-- front life meter p1
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+252+151,SCREEN_TOP+28;diffuse,color("1,0.25,0,1"));
		OnCommand=function(self)
			self:queuecommand("PALife");
		end;
		PALifeCommand=function(self)
			if SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1') ~= nil then
				local meter_pa = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P1');
				local life_pa = meter_pa:GetLife();
				self:stretchto(SCREEN_LEFT+102,SCREEN_TOP+2,SCREEN_LEFT+102+(302*life_pa),SCREEN_TOP+28);
				self:diffuse(color("1,0.25,0,1"));
			end;
		end;
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"PALife");
	},
	-- front life meter p2
	Def.Quad{
		InitCommand=cmd(stretchto,SCREEN_LEFT+451,SCREEN_TOP+2,SCREEN_LEFT+602+151,SCREEN_TOP+28;diffuse,color("0,0.5,1,1"));
		OnCommand=function(self)
			self:queuecommand("PBLife");
		end;
		PBLifeCommand=function(self)
			if SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2') ~= nil then
				local meter_pb = SCREENMAN:GetTopScreen():GetLifeMeter('PlayerNumber_P2');
				local life_pb = meter_pb:GetLife();
				self:stretchto(SCREEN_LEFT+451,SCREEN_TOP+2,SCREEN_LEFT+451+(302*life_pb),SCREEN_TOP+28);
				self:diffuse(color("0,0.5,1,1"));
			end;
		end;
		-- BUG: dunno why but, this works... for now...
		-- change it to P2 when fixed...
		LifeMeterChangedP1MessageCommand=cmd(playcommand,"PBLife");
	}
};

return t;
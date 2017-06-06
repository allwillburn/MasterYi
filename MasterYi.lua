local ver = "0.02"




if GetObjectName(GetMyHero()) ~= "MasterYi" then return end


require("DamageLib")

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat('<font color = "#00FFFF">New version found! ' .. data)
        PrintChat('<font color = "#00FFFF">Downloading update, please wait...')
        DownloadFileAsync('https://raw.githubusercontent.com/allwillburn/MasterYi/master/MasterYi.lua', SCRIPT_PATH .. 'MasterYi.lua', function() PrintChat('<font color = "#00FFFF">Update Complete, please 2x F6!') return end)
    else
        PrintChat('<font color = "#00FFFF">No updates found!')
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/allwillburn/MasterYi/master/MasterYi.version", AutoUpdate)


GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local MasterYiMenu = Menu("MasterYi", "MasterYi")

MasterYiMenu:SubMenu("Combo", "Combo")

MasterYiMenu.Combo:Boolean("Q", "Use Q in combo", true)
MasterYiMenu.Combo:Boolean("W", "Use W AA Reset", true)
MasterYiMenu.Combo:Boolean("E", "Use E in combo", true)
MasterYiMenu.Combo:Boolean("R", "Use R in combo", true)
MasterYiMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
MasterYiMenu.Combo:Boolean("Cutlass", "Use Cutlass", true)
MasterYiMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
MasterYiMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)
MasterYiMenu.Combo:Boolean("RHydra", "Use RHydra", true)
MasterYiMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
MasterYiMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)
MasterYiMenu.Combo:Boolean("Randuins", "Use Randuins", true)


MasterYiMenu:SubMenu("AutoMode", "AutoMode")
MasterYiMenu.AutoMode:Boolean("Level", "Auto level spells", false)
MasterYiMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
MasterYiMenu.AutoMode:Boolean("Q", "Auto Q", false)
MasterYiMenu.AutoMode:Boolean("W", "Auto W", false)
MasterYiMenu.AutoMode:Boolean("E", "Auto E", false)
MasterYiMenu.AutoMode:Boolean("R", "Auto R", false)

MasterYiMenu:SubMenu("LaneClear", "LaneClear")
MasterYiMenu.LaneClear:Boolean("Q", "Use Q", true)
MasterYiMenu.LaneClear:Boolean("W", "Use W", true)
MasterYiMenu.LaneClear:Boolean("E", "Use E", true)
MasterYiMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
MasterYiMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)

MasterYiMenu:SubMenu("Harass", "Harass")
MasterYiMenu.Harass:Boolean("Q", "Use Q", true)
MasterYiMenu.Harass:Boolean("W", "Use W", true)

MasterYiMenu:SubMenu("KillSteal", "KillSteal")
MasterYiMenu.KillSteal:Boolean("Q", "KS w Q", true)
MasterYiMenu.KillSteal:Boolean("E", "KS w E", true)

MasterYiMenu:SubMenu("AutoIgnite", "AutoIgnite")
MasterYiMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

MasterYiMenu:SubMenu("Drawings", "Drawings")
MasterYiMenu.Drawings:Boolean("DQ", "Draw Q Range", true)

MasterYiMenu:SubMenu("SkinChanger", "SkinChanger")
MasterYiMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
MasterYiMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)

	--AUTO LEVEL UP
	if MasterYiMenu.AutoMode.Level:Value() then

			spellorder = {_E, _W, _Q, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
          if Mix:Mode() == "Harass" then
            if MasterYiMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
				if target ~= nil then 
                                      CastTargetSpell(target, _Q)
                                end
            end

            if MasterYiMenu.Harass.W:Value() and Ready(_W) and ValidTarget(target, 125) then
				CastSpell(_W)
            end     
          end

	--COMBO
	  if Mix:Mode() == "Combo" then
            if MasterYiMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 600) then
			CastSpell(YGB)
            end

            if MasterYiMenu.Combo.Randuins:Value() and Randuins > 0 and Ready(Randuins) and ValidTarget(target, 500) then
			CastSpell(Randuins)
            end

            if MasterYiMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 550) then
			 CastTargetSpell(target, BOTRK)
            end

            if MasterYiMenu.Combo.Cutlass:Value() and Cutlass > 0 and Ready(Cutlass) and ValidTarget(target, 600) then
			 CastTargetSpell(target, Cutlass)
            end

            if MasterYiMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 125) then
			 CastSpell(_E)
	    end

            if MasterYiMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
		     if target ~= nil then 
                         CastTargetSpell(target, _Q)
                     end
            end

            if MasterYiMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if MasterYiMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 1250) then
			CastTargetSpell(target, Gunblade)
            end

            if MasterYiMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if MasterYiMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 125) then
			CastSpell(_W)
	    end
	    
	    
            if MasterYiMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 600) and (EnemiesAround(myHeroPos(), 600) >= MasterYiMenu.Combo.RX:Value()) then
			CastSpell(_R)
            end

          end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 1250) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 1250) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 600) and MasterYiMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastTargetSpell(target, _Q)
		         end
                end 

                if IsReady(_E) and ValidTarget(enemy, 125) and MasterYiMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSpell(_E)
  
                end
      end

      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if MasterYiMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 600) then
	        	CastTargetSpell(closeminion, _Q)
                end

                if MasterYiMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 125) then
	        	CastSpell(_W)
	        end

                if MasterYiMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 125) then
	        	CastSpell(_E)
	        end

                if MasterYiMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if MasterYiMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          end
      end
        --AutoMode
        if MasterYiMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 600) then
		      CastTargetSpell(target, _Q)
          end
        end 
        if MasterYiMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, 125) then
	  	      CastSpell(_W)
          end
        end
        if MasterYiMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget(target, 125) then
		      CastSpell(_E)
	  end
        end
        if MasterYiMenu.AutoMode.R:Value() then        
	  if Ready(_R) and ValidTarget(target, 600) then
		      CastSpell(_R)
	  end
        end
                
	--AUTO GHOST
	if MasterYiMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnDraw(function (myHero)
        
         if MasterYiMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), 600, 0, 200, GoS.Black)
	end

end)


OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()        
              
        if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		Mix:ResetAA()
	end	
               
        if unit.isMe and spell.name:lower():find("itemravenoushydracrescent") then
		Mix:ResetAA()
	end

end) 


local function SkinChanger()
	if MasterYiMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>MasterYi</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')






local recoilConfig = Config.recoilConfig
local pistols = Config.pistols
local smgs = Config.smgs
local rifles = Config.rifles
local mgs = Config.mgs
local shotguns = Config.shotguns
local snipers = Config.snipers

local function tableHas(tbl, val)
    local h = GetHashKey(val)
    for _, s in ipairs(tbl) do
        if h == GetHashKey(s) then return true end
    end
    return false
end

local function getWeaponClass(weaponHash)
    if not weaponHash or weaponHash == 0 then return "default" end
    if tableHas(pistols, weaponHash) then return "pistol" end
    if tableHas(smgs, weaponHash) then return "smg" end
    if tableHas(rifles, weaponHash) then return "rifle" end
    if tableHas(mgs, weaponHash) then return "mg" end
    if tableHas(shotguns, weaponHash) then return "shotgun" end
    if tableHas(snipers, weaponHash) then return "sniper" end
    return "default"
end

local function applyRecoil(amount)
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) or IsPedInAnyVehicle(ped, true) then return end
    local pitch = GetGameplayCamRelativePitch()
    local yaw = GetGameplayCamRelativeHeading()
    SetGameplayCamRelativePitch(pitch + amount + math.random() * 0.35, 0.15)
    SetGameplayCamRelativeHeading(yaw + (math.random() - 0.5) * 0.5)
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, true) then
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= 0 and IsPedShooting(ped) then
                local wclass = getWeaponClass(weapon)
                local recoil = recoilConfig[wclass] or recoilConfig.default
                applyRecoil(recoil)
            end
        end
        Wait(0)
    end
end)

local gibModels = {
        "models/player/soldier/soldier_leftarm.mdl",
        "models/player/soldier/soldier_rightarm.mdl",
        "models/player/soldier/soldier_head.mdl",
        "models/player/demoman/demoman_head.mdl",
        "models/player/engineer/engineer_head.mdl",
        "models/player/soldier/soldier_leftleg.mdl",
        "models/player/soldier/soldier_rightleg.mdl",
        "models/gibs/gib1.mdl",
        "models/gibs/gib2.mdl",
        "models/gibs/gib3.mdl",
        "models/gibs/gib4.mdl",
        "models/gibs/gib5.mdl",
        "models/gibs/gib6.mdl",
        "models/gibs/gib7.mdl",
        "models/gibs/gib8.mdl"
}

function precache()
    PrecacheSound("Player.Scream")

    for i, gibModel in ipairs(gibModels) do
        PrecacheModel(gibModel)
    end
end

function player_onthrowgren2(playerID, time)
    AddSchedule("screamer2", 0, TransformGrenadeRelay, playerID)

    return true -- Lets keep on spammin'
end

function player_onthrowgren1(playerID, time)
    AddSchedule("screamer", 0, TransformGrenadeRelay, playerID)

    return true
end

-- Relay delay is required.
function TransformGrenadeRelay(player)
    TransformGrenade(player)
end

-- Gib me a random model
function RandomGibModel()
    return gibModels[RandomInt(1, table.getn(gibModels))]
end

function TransformGrenade(player)
    local gren_col = Collection()
    local model = RandomGibModel()
    local playerID = CastToPlayer(player)
        --Gets all grenades in a 64 unit radius of the player and change the model
    gren_col:GetInSphere(playerID, 64, {  CF.kGrenades, CF.kTraceBlockWalls } )
    for temp in gren_col.items do
        --if the model is a head make it scream
        if model:find("head") ~= nil then
            temp:EmitSound("Player.Scream")
        end
        temp:SetModel(model)
    end
end

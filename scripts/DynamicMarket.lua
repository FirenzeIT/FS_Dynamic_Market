DynamicMarket = {}

DynamicMarket.MOD_NAME = g_currentModName or "FS25_DynamicMarket"
DynamicMarket.MOD_DIR = g_currentModDirectory or ""
DynamicMarket.LOG_PREFIX = "[DynamicMarket]"
DynamicMarket.VERSION = "0.7.24.4"

-- Set to false to disable DynamicMarket price adjustments.
DynamicMarket.APPLY_CURVES = true

-- Set to false to keep original GIANTS seasonal curves unchanged.
DynamicMarket.CHANGE_EXISTING_CURVES = true

-- Set to false to disable monthly in-game market messages.
DynamicMarket.PLAYER_MARKET_NOTICES = true

-- Set to false to hide the yearly average orientation value in the market page.
-- Shows the true arithmetic yearly average from the original basegame economic curve in the DynamicMarket page.
-- If enabled, DynamicMarket uses the yearly average as the neutral sale base instead of the current seasonal month price.
DynamicMarket.ENABLE_YEARLY_AVERAGE = true
DynamicMarket.USE_YEARLY_AVERAGE_AS_BASE_PRICE = true
DynamicMarket.YEARLY_AVERAGE_FLAT_BASEGAME_GRAPH = true
DynamicMarket.PRICE_BASE_NORMAL = 1
DynamicMarket.PRICE_BASE_YEAR_AVERAGE = 2
DynamicMarket.priceBaseMode = DynamicMarket.PRICE_BASE_YEAR_AVERAGE

-- Minimum market movement for a message. 0.015 means 1.5%.
DynamicMarket.MARKET_NOTICE_MIN_MOVEMENT = 0.015

-- Add custom fill types here if automatic assignment is wrong.
-- Format: INTERNAL_FILLTYPE_NAME = "groupName"
-- Valid groups: cereal, oilseed, rootcrop, vegetable, forage, fiber, animal, animalMarket, auxiliaryProduct, production, preserved, packaged, construction, woodProduct.
DynamicMarket.FILLTYPE_GROUP_OVERRIDES = {
    -- MY_CUSTOM_FILLTYPE = "production"
}

DynamicMarket.PERIOD_CHECK_INTERVAL_MS = 5000
DynamicMarket.RECHECK_SALES_ON_STATION_COUNT_CHANGE = true
DynamicMarket.APPLY_MONTHLY_MARKET_TO_SALES = true
DynamicMarket.MIN_PRICE_PER_LITER = 0.000001
DynamicMarket.STABLE_DELAY_MS = 500
DynamicMarket.MIN_APPLY_DELAY_MS = 1000
DynamicMarket.EXISTING_CURVE_WEIGHT = 0.25
DynamicMarket.GROUP_CURVE_WEIGHT = 0.75

DynamicMarket.DIAGNOSTICS = {
    debugLog = false,
    everyFillType = false,
    changedNames = false,
    market = false,
    unsafeNames = false,
    skippedDetails = false,
    saleMarket = false,
    finalStatus = false,
    saleMarketNames = false,
    marketModel = false,
    maxSkippedDetailNames = 80,
    maxSaleMarketNames = 0,
    maxChangedNames = 80,
    maxUnsafeNames = 120
}

DynamicMarket.PERIODS = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}

source(DynamicMarket.MOD_DIR .. "scripts/DynamicMarketMenuFrame.lua")
source(DynamicMarket.MOD_DIR .. "scripts/DynamicMarketSettings.lua")

DynamicMarket.CURVES = {
    cereal =      {1.18, 1.13, 1.07, 1.01, 0.95, 0.89, 0.84, 0.87, 0.94, 1.03, 1.11, 1.16},
    oilseed =     {1.15, 1.10, 1.05, 1.00, 0.95, 0.91, 0.88, 0.91, 0.98, 1.05, 1.11, 1.15},
    rootcrop =    {1.10, 1.07, 1.03, 0.99, 0.95, 0.91, 0.88, 0.91, 0.98, 1.04, 1.08, 1.10},
    vegetable =   {1.12, 1.08, 1.04, 1.00, 0.96, 0.92, 0.90, 0.93, 0.99, 1.04, 1.08, 1.11},
    forage =      {1.12, 1.06, 1.00, 0.94, 0.88, 0.82, 0.80, 0.86, 0.96, 1.05, 1.11, 1.13},
    fiber =       {1.10, 1.06, 1.02, 0.98, 0.94, 0.90, 0.88, 0.92, 0.99, 1.05, 1.10, 1.12},
    animal =      {1.08, 1.05, 1.02, 0.99, 0.96, 0.94, 0.94, 0.97, 1.01, 1.04, 1.07, 1.08},
    animalMarket ={1.12, 1.08, 1.04, 1.00, 0.96, 0.93, 0.92, 0.95, 1.00, 1.05, 1.09, 1.12},
    auxiliaryProduct = {1.03, 1.02, 1.01, 1.00, 0.99, 0.98, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03},
    production =  {1.07, 1.04, 1.02, 0.99, 0.96, 0.94, 0.95, 0.98, 1.01, 1.04, 1.06, 1.07},
    preserved =   {1.09, 1.06, 1.03, 1.00, 0.97, 0.94, 0.93, 0.96, 1.00, 1.03, 1.06, 1.09},
    packaged =    {1.06, 1.04, 1.02, 1.00, 0.97, 0.95, 0.95, 0.98, 1.01, 1.03, 1.05, 1.06},
    construction ={1.05, 1.03, 1.01, 1.00, 0.98, 0.96, 0.96, 0.98, 1.01, 1.03, 1.05, 1.06},
    woodProduct = {1.09, 1.06, 1.03, 1.00, 0.96, 0.93, 0.92, 0.95, 1.00, 1.05, 1.08, 1.10}
}

DynamicMarket.MARKET_GROUPS = {
    cereal =       {volatility = 0.10, weather = 0.20, supply = 0.55, demand = 0.25},
    oilseed =      {volatility = 0.10, weather = 0.15, supply = 0.45, demand = 0.40},
    rootcrop =     {volatility = 0.09, weather = 0.25, supply = 0.45, demand = 0.30},
    vegetable =    {volatility = 0.13, weather = 0.30, supply = 0.35, demand = 0.35},
    forage =       {volatility = 0.11, weather = 0.45, supply = 0.35, demand = 0.20},
    fiber =        {volatility = 0.09, weather = 0.15, supply = 0.30, demand = 0.55},
    animal =       {volatility = 0.04, weather = 0.05, supply = 0.20, demand = 0.75},
    animalMarket = {volatility = 0.07, weather = 0.10, supply = 0.35, demand = 0.55},
    auxiliaryProduct = {volatility = 0.025, weather = 0.02, supply = 0.10, demand = 0.88},
    production =   {volatility = 0.05, weather = 0.05, supply = 0.25, demand = 0.70},
    preserved =    {volatility = 0.06, weather = 0.08, supply = 0.25, demand = 0.67},
    packaged =     {volatility = 0.045, weather = 0.03, supply = 0.20, demand = 0.77},
    construction = {volatility = 0.055, weather = 0.02, supply = 0.15, demand = 0.83},
    woodProduct =  {volatility = 0.075, weather = 0.15, supply = 0.25, demand = 0.60}
}

DynamicMarket.__marketFactors = {}
DynamicMarket.__marketKey = nil
DynamicMarket.__lastSalesMarketKey = nil
DynamicMarket.__lastObservedMarketKey = nil
DynamicMarket.__periodCheckMs = 0
DynamicMarket.__lastSaleMarketReport = nil
DynamicMarket.__lastSellingStationCount = 0
DynamicMarket.__uiPriceRefreshToken = 0
DynamicMarket.__marketDriverReport = nil
DynamicMarket.__lastPlayerNoticeKey = nil


DynamicMarket.NOTICE_TEXTS = {
    en = {
        dm_notice_title = "Dynamic Market",
        dm_notice_stable = "Market groups remain stable.",
        dm_group_cereal = "cereals",
        dm_group_oilseed = "oilseeds",
        dm_group_rootcrop = "root crops",
        dm_group_vegetable = "vegetables",
        dm_group_forage = "forage crops",
        dm_group_fiber = "fiber crops",
        dm_group_animal = "animal products",
        dm_group_animalMarket = "animals",
        dm_group_auxiliaryProduct = "auxiliary goods",
        dm_group_production = "processed goods",
        dm_group_preserved = "preserved goods",
        dm_group_packaged = "packaged goods",
        dm_group_construction = "construction materials",
        dm_group_woodProduct = "wood products"
    },
    de = {
        dm_notice_title = "Dynamischer Markt",
        dm_notice_stable = "Warengruppen bleiben stabil.",
        dm_group_cereal = "Getreide",
        dm_group_oilseed = "Ölfrüchte",
        dm_group_rootcrop = "Hackfrüchte",
        dm_group_vegetable = "Gemüse",
        dm_group_forage = "Futterpflanzen",
        dm_group_fiber = "Faserpflanzen",
        dm_group_animal = "Tierprodukte",
        dm_group_animalMarket = "Tiere",
        dm_group_auxiliaryProduct = "Hilfswaren",
        dm_group_production = "verarbeitete Waren",
        dm_group_preserved = "Konserven",
        dm_group_packaged = "verpackte Waren",
        dm_group_construction = "Baustoffe",
        dm_group_woodProduct = "Holzprodukte"
    },
    fr = {
        dm_notice_title = "Marché Dynamique",
        dm_notice_stable = "Les groupes de produits restent stables.",
        dm_group_cereal = "céréales",
        dm_group_oilseed = "oléagineux",
        dm_group_rootcrop = "racines",
        dm_group_vegetable = "légumes",
        dm_group_forage = "fourrages",
        dm_group_fiber = "fibres",
        dm_group_animal = "produits animaux",
        dm_group_animalMarket = "animaux",
        dm_group_auxiliaryProduct = "marchandises auxiliaires",
        dm_group_production = "produits transformés",
        dm_group_preserved = "conserves",
        dm_group_packaged = "marchandises emballées",
        dm_group_construction = "matériaux de construction",
        dm_group_woodProduct = "produits du bois"
    }
}

DynamicMarket.GROUPS = {
    cereal = {
        WHEAT = true, WINTERWHEAT = true, BARLEY = true, WINTERBARLEY = true, OAT = true,
        SORGHUM = true, RYE = true, TRITICALE = true, SPELT = true, RICE = true, RICELONGGRAIN = true,
        MAIZE = true, CORN = true,
        WHEAT_CUT = true, BARLEY_CUT = true, OAT_CUT = true, RYE_CUT = true, TRITICALE_CUT = true,
        SPELT_CUT = true
    },
    oilseed = {
        CANOLA = true, SUNFLOWER = true, SOYBEAN = true, OLIVE = true, LINSEED = true, FLAX = true,
        POPPY = true, SOYBEAN_CUT = true
    },
    rootcrop = {
        POTATO = true, SUGARBEET = true, SUGARBEET_CUT = true, BEETROOT = true, CARROT = true,
        PARSNIP = true, ONION = true, TURNIP = true, SUGARCANE = true
    },
    vegetable = {
        GREENBEAN = true, PEA = true, SPINACH = true, GRAPE = true, LETTUCE = true, TOMATO = true,
        STRAWBERRY = true, APPLE = true, CABBAGE = true, CUCUMBER = true, PUMPKIN = true,
        CHILLI = true, GARLIC = true, ENOKI = true, OYSTER = true, MUSTARD = true, SPRING_ONION = true
    },
    forage = {
        GRASS = true, GRASS_WINDROW = true, DRYGRASS = true, DRYGRASS_WINDROW = true, HAY = true,
        STRAW = true, FORAGE = true, CHAFF = true, SILAGE = true, WOODCHIPS = true, POPLAR = true,
        CLOVER = true, CLOVER_WINDROW = true, DRYCLOVER = true, DRYCLOVER_WINDROW = true,
        ALFALFA = true, ALFALFA_WINDROW = true, DRYALFALFA = true, DRYALFALFA_WINDROW = true,
        LUCERNE = true, FIELDGRASS = true, GREENRYE = true, VETCHRYE = true, SILAGEMAIZE = true,
        FORAGE_MIXING = true, CHICKENFOOD = true, GRAINGRIST = true, PROTEINGRIST = true,
        LUPROSIL = true, CCM = true, CCMRAW = true,
        ROUNDBALE = true, ROUNDBALE_DRYGRASS = true, ROUNDBALE_GRASS = true,
        SQUAREBALE = true, SQUAREBALE_DRYGRASS = true, SQUAREBALE_GRASS = true
    },
    fiber = {
        COTTON = true, ROUNDBALE_COTTON = true, SQUAREBALE_COTTON = true
    },
    animal = {
        MILK = true, GOATMILK = true, BUFFALOMILK = true, EGG = true, WOOL = true, HONEY = true
    },
    animalMarket = {
        COW_ANGUS = true, COW_HIGHLAND_CATTLE = true, COW_HOLSTEIN = true, COW_LIMOUSIN = true,
        COW_SWISS_BROWN = true, PIG_BERKSHIRE = true, PIG_BLACK_PIED = true, PIG_LANDRACE = true,
        SHEEP_BLACK_WELSH = true, SHEEP_LANDRACE = true, SHEEP_STEINSCHAF = true, SHEEP_SWISS_MOUNTAIN = true
    },
    auxiliaryProduct = {
        BARREL = true, BUCKET = true, BATHTUB = true, EMPTYPALLET = true, EMPTYPALLETBOX = true,
        EMPTYBARREL = true, EMPTYBUCKET = true, EMPTYBOX = true, EMPTYPACKAGE = true
    },
    production = {
        FLOUR = true, RICEFLOUR = true, BREAD = true, CAKE = true, BUTTER = true, CHEESE = true, GOATCHEESE = true,
        CHOCOLATE = true, SUGAR = true, CEREAL = true, SUNFLOWER_OIL = true, CANOLA_OIL = true,
        OLIVE_OIL = true, RICE_OIL = true, RAISINS = true, GRAPEJUICE = true, FABRIC = true,
        CLOTHES = true, PAPER = true, PAPERROLL = true, ROPE = true, PELLETS = true, COMPOST = true,
        COMPOSTRAW = true, COMPOST_BOXED = true, QUALITYCOMPOST = true, MOLASSES = true,
        BUFFALOMOZZARELLA = true, BUFFALOMILK_BOTTLED = true, GOATMILK_BOTTLED = true,
        MILK_BOTTLED = true, CARTONROLL = true
    },
    preserved = {
        POTATOCHIPS = true, RICEROLLS = true, FERMENTEDNAPACABBAGE = true, NOODLESOUP = true,
        PRESERVEDCARROTS = true, PRESERVEDPARSNIP = true, PRESERVEDBEETROOT = true,
        SOUPCANSMIXED = true, SOUPCANSCARROTS = true, SOUPCANSPARSNIP = true, SOUPCANSBEETROOT = true,
        SOUPCANSPOTATO = true, CANNED_PEAS = true, JARRED_GREENBEAN = true, SPINACH_BAGS = true
    },
    packaged = {
        RICE_BAGS = true, RICE_BOXES = true, BAGGED = true, BOXED = true, PALLET = true
    },
    construction = {
        CEMENT = true, CEMENTBRICKS = true, CONCRETE = true, STONE = true, GRAVEL = true, SAND = true,
        ROOFPLATES = true, PREFABWALL = true
    },
    woodProduct = {
        WOOD = true, WOODCHIPS = true, PLANKS = true, FURNITURE = true, BOARDS = true, TIMBER = true,
        WOODBEAM = true, TREE = true, ROUNDBALE_WOOD = true, SQUAREBALE_WOOD = true
    }
}

DynamicMarket.GROUP_ORDER = {
    "cereal", "oilseed", "rootcrop", "vegetable", "forage", "fiber", "animal",
    "animalMarket", "auxiliaryProduct", "preserved", "packaged", "construction", "woodProduct", "production"
}

DynamicMarket.PATTERN_GROUP_ORDER = {
    "auxiliaryProduct", "preserved", "packaged", "construction", "woodProduct", "production"
}

DynamicMarket.EXCLUDED_EXACT = {
    UNKNOWN = true,
    DIESEL = true, DEF = true, ELECTRICCHARGE = true, METHANE = true, WATER = true, AIR = true,
    FERTILIZER = true, LIQUIDFERTILIZER = true, HERBICIDE = true, LIME = true, SEEDS = true,
    SILAGE_ADDITIVE = true, MINERAL_FEED = true, PIGFOOD = true, ROAD_SALT = true, SNOW = true,
    LIQUIDMANURE = true, MANURE = true, DIGESTATE = true,
    OILSEEDRADISH = true, FLOWERINGCATCHCROP = true, HUMUSACTIVE = true, MEADOW = true,
    BALE_NET = true, BALE_TWINE = true, BALE_WRAP = true
}

DynamicMarket.EXCLUDED_PATTERNS = {
    "FERTILIZER", "HERBICIDE", "ADDITIVE", "DIESEL", "FUEL", "METHANE", "ELECTRIC", "WATER",
    "MANURE", "DIGESTATE", "SEED", "SAPLING", "CUTTER", "HEADER"
}

DynamicMarket.GROUP_PATTERNS = {
    auxiliaryProduct = {"EMPTY", "AUXILIARY"},
    preserved = {"CANNED", "CAN", "SOUP", "PRESERVED", "JARRED", "FERMENTED", "CHIPS", "ROLLS"},
    packaged = {"BAG", "BOX", "PACKED", "PACKAGE", "PALLET"},
    construction = {"CEMENT", "CONCRETE", "BRICK", "ROOF", "GRAVEL", "SAND", "BATHTUB"},
    woodProduct = {"PLANK", "FURNITURE", "BOARD", "TIMBER"},
    production = {"FLOUR", "BREAD", "CAKE", "BUTTER", "CHEESE", "OIL", "JUICE", "FABRIC", "CLOTHES",
        "PAPER", "PELLET", "COMPOST", "MOLASSES", "ROPE"}
}

DynamicMarket.__lastFillTypeCount = -1
DynamicMarket.__stableMs = 0
DynamicMarket.__finalApplied = false
DynamicMarket.__loadMapSeen = false
DynamicMarket.__applyPass = 0
DynamicMarket.__runtimeMs = 0
DynamicMarket.__armedLogged = false

function DynamicMarket:formatCurve(curve)
    if curve == nil then
        return ""
    end

    local parts = {}
    for _, period in ipairs(self.PERIODS) do
        table.insert(parts, string.format("%.2f", tonumber(curve[period]) or 1))
    end

    return table.concat(parts, ",")
end

function DynamicMarket:getFillTypeName(fillType)
    if fillType == nil or type(fillType) ~= "table" then
        return "UNKNOWN"
    end

    return tostring(fillType.name or "UNKNOWN"):upper()
end

function DynamicMarket:getGroup(fillType)
    local name = self:getFillTypeName(fillType)
    local overrideGroup = self.FILLTYPE_GROUP_OVERRIDES[name]

    if overrideGroup ~= nil and self.GROUPS[overrideGroup] ~= nil then
        return overrideGroup, "override"
    end

    for _, groupName in ipairs(self.GROUP_ORDER) do
        local names = self.GROUPS[groupName]
        if names ~= nil and names[name] == true then
            return groupName, "exact"
        end
    end

    for _, groupName in ipairs(self.PATTERN_GROUP_ORDER) do
        local patterns = self.GROUP_PATTERNS[groupName]
        if patterns ~= nil then
            for _, pattern in ipairs(patterns) do
                if string.find(name, pattern, 1, true) ~= nil then
                    return groupName, "pattern:" .. pattern
                end
            end
        end
    end

    return nil, "unknown"
end

function DynamicMarket:getExistingCurve(fillType)
    if fillType == nil or type(fillType) ~= "table" then
        return nil
    end

    if type(fillType.economicCurve) == "table" then
        return fillType.economicCurve
    end

    if fillType.economy ~= nil and type(fillType.economy.factors) == "table" then
        return fillType.economy.factors
    end

    return nil
end

function DynamicMarket:hasMeaningfulCurve(fillType)
    local curve = self:getExistingCurve(fillType)
    if curve == nil then
        return false
    end

    for _, period in ipairs(self.PERIODS) do
        local value = tonumber(curve[period]) or 1
        if math.abs(value - 1) > 0.0001 then
            return true
        end
    end

    return false
end

function DynamicMarket:getSkipReason(fillType, groupName)
    if fillType == nil then
        return "nilFillType"
    end

    if type(fillType) ~= "table" then
        return "invalidFillTypeEntry"
    end

    local name = self:getFillTypeName(fillType)

    if name == "UNKNOWN" or name == "" then
        return "unknownName"
    end

    if self.EXCLUDED_EXACT[name] == true then
        return "excludedUtilityOrInternal"
    end

    for _, pattern in ipairs(self.EXCLUDED_PATTERNS) do
        if string.find(name, pattern, 1, true) ~= nil then
            return "excludedPattern:" .. pattern
        end
    end

    if fillType.pricePerLiter == nil or tonumber(fillType.pricePerLiter) == nil or tonumber(fillType.pricePerLiter) < self.MIN_PRICE_PER_LITER then
        return "noValidBasePrice"
    end

    if groupName == nil then
        return "noSafeCategory"
    end

    return nil
end

function DynamicMarket:copyCurve(curve)
    local copied = {}
    for _, period in ipairs(self.PERIODS) do
        copied[period] = tonumber(curve ~= nil and curve[period] or nil) or 1
    end
    return copied
end

function DynamicMarket:buildDynamicCurve(fillType, groupName)
    local groupCurve = self.CURVES[groupName]
    if groupCurve == nil then
        return nil
    end

    local existing = self:getExistingCurve(fillType)
    local useExisting = self:hasMeaningfulCurve(fillType)
    local curve = {}

    for _, period in ipairs(self.PERIODS) do
        local groupValue = tonumber(groupCurve[period]) or 1
        local existingValue = tonumber(existing ~= nil and existing[period] or nil) or 1

        if useExisting then
            curve[period] = (groupValue * self.GROUP_CURVE_WEIGHT) + (existingValue * self.EXISTING_CURVE_WEIGHT)
        else
            curve[period] = groupValue
        end
    end

    return curve
end

function DynamicMarket:cacheBaseGameEconomy(fillType)
    if fillType == nil or type(fillType) ~= "table" or fillType.dynamicMarketBaseGameEconomyCached == true then
        return
    end

    fillType.dynamicMarketBaseGameEconomyCached = true
    fillType.dynamicMarketBaseGameEconomicCurve = {}
    fillType.dynamicMarketBaseGameFactors = {}
    fillType.dynamicMarketBaseGameHistory = {}

    if type(fillType.economicCurve) == "table" then
        for _, period in ipairs(self.PERIODS) do
            fillType.dynamicMarketBaseGameEconomicCurve[period] = tonumber(fillType.economicCurve[period])
        end
    end

    if fillType.economy ~= nil then
        if type(fillType.economy.factors) == "table" then
            for _, period in ipairs(self.PERIODS) do
                fillType.dynamicMarketBaseGameFactors[period] = tonumber(fillType.economy.factors[period])
            end
        end
        if type(fillType.economy.history) == "table" then
            for _, period in ipairs(self.PERIODS) do
                fillType.dynamicMarketBaseGameHistory[period] = tonumber(fillType.economy.history[period])
            end
        end
    end
end

function DynamicMarket:applyCurve(fillType, curve)
    if fillType == nil or type(fillType) ~= "table" or curve == nil then
        return false
    end

    self:cacheBaseGameEconomy(fillType)

    fillType.economy = fillType.economy or {}
    fillType.economy.factors = fillType.economy.factors or {}
    fillType.economy.history = fillType.economy.history or {}

    for _, period in ipairs(self.PERIODS) do
        local factor = tonumber(curve[period]) or 1
        fillType.economy.factors[period] = factor
        fillType.economy.history[period] = factor * tonumber(fillType.pricePerLiter or 0)
    end

    fillType.dynamicMarketApplied = true
    fillType.dynamicMarketVersion = self.VERSION

    return true
end

function DynamicMarket:getFillTypes(manager)
    if manager ~= nil and manager.fillTypes ~= nil then
        return manager.fillTypes
    end

    if g_fillTypeManager ~= nil and g_fillTypeManager.fillTypes ~= nil then
        return g_fillTypeManager.fillTypes
    end

    return nil
end

function DynamicMarket:getFillTypeCount(manager)
    local fillTypes = self:getFillTypes(manager)
    if fillTypes == nil then
        return 0
    end

    local count = 0
    for _, _ in ipairs(fillTypes) do
        count = count + 1
    end

    return count
end


function DynamicMarket:getMissionPeriod()
    local mission = g_currentMission
    if mission ~= nil and mission.environment ~= nil then
        local period = mission.environment.currentPeriod or mission.environment.currentSeason or mission.environment.currentMonth
        if period ~= nil then
            period = tonumber(period)
            if period ~= nil then
                return math.max(1, math.min(12, period))
            end
        end
    end
    return 1
end

function DynamicMarket:getMissionYear()
    local mission = g_currentMission
    if mission ~= nil and mission.environment ~= nil then
        local year = mission.environment.currentYear or mission.environment.year or 1
        year = tonumber(year)
        if year ~= nil then
            return math.max(1, math.floor(year))
        end
    end
    return 1
end

function DynamicMarket:stableHash(text)
    local hash = 5381
    text = tostring(text or "")
    for i = 1, string.len(text) do
        hash = ((hash * 33) + string.byte(text, i)) % 1000000007
    end
    return hash
end

function DynamicMarket:noise01(seedText)
    local h = self:stableHash(seedText)
    return (h % 1000000) / 1000000
end

function DynamicMarket:noiseSigned(seedText)
    return (self:noise01(seedText) * 2) - 1
end

function DynamicMarket:getMarketKeyForPeriod(period, year, mapName)
    period = tonumber(period) or 1
    year = tonumber(year) or 1
    mapName = tostring(mapName or "unknownMap")
    return mapName .. ":" .. tostring(year) .. ":" .. tostring(period)
end

function DynamicMarket:getMarketKey()
    local period = self:getMissionPeriod()
    local year = self:getMissionYear()
    local mapName = "unknownMap"
    if g_currentMission ~= nil and g_currentMission.missionInfo ~= nil then
        mapName = g_currentMission.missionInfo.mapId or g_currentMission.missionInfo.mapTitle or g_currentMission.missionInfo.mapName or mapName
    end
    mapName = tostring(mapName)
    return self:getMarketKeyForPeriod(period, year, mapName), period, year, mapName
end

function DynamicMarket:clampMarketFactor(value)
    value = tonumber(value) or 1
    if value < 0.75 then
        return 0.75
    elseif value > 1.25 then
        return 1.25
    end
    return value
end


function DynamicMarket:getSeasonalSupplyPressure(groupName, period)
    period = tonumber(period) or 1
    local profiles = {
        cereal =       {[1]=-0.40, [2]=-0.30, [3]=-0.15, [4]=0.05, [5]=0.35, [6]=0.80, [7]=0.80, [8]=0.45, [9]=0.15, [10]=-0.10, [11]=-0.25, [12]=-0.35},
        oilseed =      {[1]=-0.25, [2]=-0.20, [3]=-0.10, [4]=0.05, [5]=0.20, [6]=0.55, [7]=0.65, [8]=0.35, [9]=0.10, [10]=-0.05, [11]=-0.15, [12]=-0.25},
        rootcrop =     {[1]=-0.20, [2]=-0.20, [3]=-0.10, [4]=0.00, [5]=0.10, [6]=0.20, [7]=0.30, [8]=0.60, [9]=0.75, [10]=0.45, [11]=0.10, [12]=-0.10},
        vegetable =    {[1]=-0.15, [2]=-0.10, [3]=0.00, [4]=0.20, [5]=0.45, [6]=0.55, [7]=0.60, [8]=0.45, [9]=0.20, [10]=0.00, [11]=-0.10, [12]=-0.15},
        forage =       {[1]=-0.30, [2]=-0.15, [3]=0.15, [4]=0.45, [5]=0.60, [6]=0.50, [7]=0.35, [8]=0.10, [9]=-0.05, [10]=-0.20, [11]=-0.35, [12]=-0.40},
        fiber =        {[1]=-0.15, [2]=-0.10, [3]=0.00, [4]=0.10, [5]=0.20, [6]=0.35, [7]=0.45, [8]=0.30, [9]=0.10, [10]=-0.05, [11]=-0.10, [12]=-0.15},
        animal =       {[1]=0.00, [2]=0.00, [3]=0.00, [4]=0.05, [5]=0.05, [6]=0.05, [7]=0.00, [8]=0.00, [9]=-0.05, [10]=-0.05, [11]=0.00, [12]=0.00},
        animalMarket = {[1]=0.00, [2]=0.00, [3]=0.05, [4]=0.05, [5]=0.05, [6]=0.00, [7]=0.00, [8]=-0.05, [9]=-0.05, [10]=0.00, [11]=0.00, [12]=0.00},
        production =   {[1]=0.00, [2]=0.00, [3]=0.00, [4]=0.05, [5]=0.05, [6]=0.05, [7]=0.00, [8]=0.00, [9]=0.00, [10]=0.05, [11]=0.05, [12]=0.00},
        preserved =    {[1]=-0.10, [2]=-0.10, [3]=-0.05, [4]=0.00, [5]=0.10, [6]=0.20, [7]=0.30, [8]=0.25, [9]=0.10, [10]=0.00, [11]=-0.05, [12]=-0.10},
        packaged =     {[1]=0.00, [2]=0.00, [3]=0.00, [4]=0.05, [5]=0.05, [6]=0.05, [7]=0.00, [8]=0.00, [9]=0.00, [10]=0.05, [11]=0.05, [12]=0.00},
        construction = {[1]=-0.05, [2]=-0.05, [3]=0.05, [4]=0.15, [5]=0.20, [6]=0.15, [7]=0.10, [8]=0.10, [9]=0.05, [10]=0.00, [11]=-0.05, [12]=-0.05},
        woodProduct =  {[1]=-0.05, [2]=-0.05, [3]=0.05, [4]=0.15, [5]=0.20, [6]=0.15, [7]=0.10, [8]=0.05, [9]=0.00, [10]=0.00, [11]=-0.05, [12]=-0.05}
    }

    local profile = profiles[groupName]
    if profile == nil then
        return 0
    end
    return tonumber(profile[period]) or 0
end

function DynamicMarket:buildMarketFactorForGroup(groupName, period, year, mapName)
    local cfg = self.MARKET_GROUPS[groupName]
    if cfg == nil then
        return 1, nil
    end

    period = tonumber(period) or 1
    year = tonumber(year) or 1
    mapName = tostring(mapName or "unknownMap")

    local key = self:getMarketKeyForPeriod(period, year, mapName)
    local volatility = tonumber(cfg.volatility) or 0.05
    local weather = self:noiseSigned(key .. ":weather:" .. groupName)
    local randomSupplyPressure = self:noiseSigned(key .. ":regionalSupply:" .. groupName)
    local seasonalSupplyPressure = self:getSeasonalSupplyPressure(groupName, period)
    local supplyPressure = (randomSupplyPressure * 0.65) + (seasonalSupplyPressure * 0.35)
    local demand = self:noiseSigned(key .. ":demand:" .. groupName)
    local supplyEffect = -supplyPressure
    local raw = ((weather * (cfg.weather or 0)) + (supplyEffect * (cfg.supply or 0)) + (demand * (cfg.demand or 0))) * volatility
    local factor = self:clampMarketFactor(1 + raw)

    return factor, {
        factor = factor,
        weather = weather,
        supply = supplyEffect,
        supplyPressure = supplyPressure,
        seasonalSupplyPressure = seasonalSupplyPressure,
        demand = demand,
        volatility = volatility
    }
end

function DynamicMarket:getEconomyPriceMultiplier()
    local mission = g_currentMission
    local manager = nil
    local difficulty = nil

    if mission ~= nil then
        manager = mission.economyManager
        if mission.missionInfo ~= nil then
            difficulty = tonumber(mission.missionInfo.economicDifficulty)
        end
    end

    if difficulty == nil then
        difficulty = 2
    end

    if manager ~= nil and type(manager.PRICE_MULTIPLIER) == "table" then
        return tonumber(manager.PRICE_MULTIPLIER[difficulty]) or 1
    end

    if EconomyManager ~= nil and type(EconomyManager.PRICE_MULTIPLIER) == "table" then
        return tonumber(EconomyManager.PRICE_MULTIPLIER[difficulty]) or 1
    end

    return 1
end

function DynamicMarket:getBaseGameYearlyAverageRawPrice(fillType)
    if fillType == nil then
        return 0
    end

    self:cacheBaseGameEconomy(fillType)

    local sum = 0
    local count = 0
    if type(fillType.dynamicMarketBaseGameHistory) == "table" then
        for period = 1, 12 do
            local price = tonumber(fillType.dynamicMarketBaseGameHistory[period])
            if price ~= nil and price > 0 then
                sum = sum + price
                count = count + 1
            end
        end
    end

    local baseAverage = nil
    if count > 0 then
        baseAverage = sum / count
    else
        local basePrice = tonumber(fillType.pricePerLiter) or 0
        local yearlyFactor = self:getBaseGameYearlyOrientationFactor(fillType)
        baseAverage = basePrice * yearlyFactor
    end

    if baseAverage == nil or baseAverage <= 0 then
        return 0
    end

    return baseAverage
end

function DynamicMarket:getBaseGameYearlyAveragePrice(fillType, station, fillTypeIndex, baseCurrentPrice)
    local rawAverage = self:getBaseGameYearlyAverageRawPrice(fillType)
    if rawAverage == nil or rawAverage <= 0 then
        return 0
    end

    return rawAverage * self:getEconomyPriceMultiplier()
end

function DynamicMarket:getStationRawPriceBase(station, fillTypeIndex)
    if station == nil or type(station) ~= "table" or fillTypeIndex == nil then
        return nil
    end

    station.dynamicMarketOriginalRawPrices = station.dynamicMarketOriginalRawPrices or {}
    local cached = tonumber(station.dynamicMarketOriginalRawPrices[fillTypeIndex])
    if cached ~= nil and cached > 0 then
        return cached
    end

    local rawPrice = nil
    if station.fillTypePrices ~= nil then
        rawPrice = tonumber(station.fillTypePrices[fillTypeIndex])
    end
    if (rawPrice == nil or rawPrice <= 0) and station.originalFillTypePricesUnscaled ~= nil then
        rawPrice = tonumber(station.originalFillTypePricesUnscaled[fillTypeIndex])
    end
    if (rawPrice == nil or rawPrice <= 0) and station.originalFillTypePrices ~= nil then
        rawPrice = tonumber(station.originalFillTypePrices[fillTypeIndex])
    end

    if rawPrice ~= nil and rawPrice > 0 then
        station.dynamicMarketOriginalRawPrices[fillTypeIndex] = rawPrice
        return rawPrice
    end

    return nil
end

function DynamicMarket:isValidSellingStationForFillType(station, fillTypeIndex)
    if station == nil or type(station) ~= "table" or fillTypeIndex == nil then
        return false
    end

    if SellingStation ~= nil and station.isa ~= nil and not station:isa(SellingStation) then
        return false
    end

    if station.hideFromPricesMenu == true then
        return false
    end

    if station.acceptedFillTypes ~= nil and station.acceptedFillTypes[fillTypeIndex] ~= true then
        return false
    end

    local mission = g_currentMission
    if mission ~= nil and mission.getFarmId ~= nil and station.ownerFarmId ~= nil and station.ownerFarmId == mission:getFarmId() then
        return false
    end

    return true
end

function DynamicMarket:prepareStationBasePriceCache(sellingStations)
    self.__bestStationRawPriceByFillType = {}
    self.__bestStationNameByFillType = {}
    self.__bestStationObjectByFillType = {}
    self.__stationCountByFillType = {}

    if sellingStations == nil or type(sellingStations) ~= "table" then
        return
    end

    for _, station in pairs(sellingStations) do
        if station ~= nil and type(station) == "table" and station.fillTypePrices ~= nil and type(station.fillTypePrices) == "table" then
            for key, _ in pairs(station.fillTypePrices) do
                if self:isValidSellingStationForFillType(station, key) then
                    local rawPrice = self:getStationRawPriceBase(station, key)
                    if rawPrice ~= nil and rawPrice > 0 then
                        self.__stationCountByFillType[key] = (tonumber(self.__stationCountByFillType[key]) or 0) + 1
                        local currentBest = tonumber(self.__bestStationRawPriceByFillType[key]) or 0
                        local stationName = ""
                        if station.getName ~= nil then
                            stationName = tostring(station:getName() or "")
                        end
                        local currentName = tostring(self.__bestStationNameByFillType[key] or "")
                        if rawPrice > currentBest or (rawPrice == currentBest and stationName ~= "" and (currentName == "" or stationName < currentName)) then
                            self.__bestStationRawPriceByFillType[key] = rawPrice
                            self.__bestStationNameByFillType[key] = stationName
                            self.__bestStationObjectByFillType[key] = station
                        end
                    end
                end
            end
        end
    end
end

function DynamicMarket:getStationNegativePriceScale(station, fillTypeIndex)
    if not self:isValidSellingStationForFillType(station, fillTypeIndex) then
        return 1
    end

    local stationCount = self.__stationCountByFillType ~= nil and tonumber(self.__stationCountByFillType[fillTypeIndex]) or 0
    if stationCount <= 1 then
        return 1
    end

    local rawPrice = self:getStationRawPriceBase(station, fillTypeIndex)
    local bestRawPrice = self.__bestStationRawPriceByFillType ~= nil and tonumber(self.__bestStationRawPriceByFillType[fillTypeIndex]) or nil

    if rawPrice == nil or rawPrice <= 0 or bestRawPrice == nil or bestRawPrice <= 0 then
        return 1
    end

    if rawPrice >= bestRawPrice then
        return 1
    end

    local scale = rawPrice / bestRawPrice
    if scale > 1 then
        scale = 1
    elseif scale < 0.01 then
        scale = 0.01
    end

    return scale
end

function DynamicMarket:getSaleBasePrice(station, fillTypeIndex, fillType, currentBasePrice)
    local basePrice = tonumber(currentBasePrice)

    if self.ENABLE_YEARLY_AVERAGE == true and self.USE_YEARLY_AVERAGE_AS_BASE_PRICE == true then
        local yearlyAverage = self:getBaseGameYearlyAveragePrice(fillType, station, fillTypeIndex, basePrice)
        if yearlyAverage ~= nil and yearlyAverage > 0 then
            return yearlyAverage
        end
    end

    local rawStationBase = self:getStationRawPriceBase(station, fillTypeIndex)
    if rawStationBase ~= nil and rawStationBase > 0 then
        return rawStationBase * self:getEconomyPriceMultiplier()
    end

    return basePrice
end

function DynamicMarket:getNeutralMarketPrice(fillType, fillTypeIndex, currentBasePrice, station)
    if fillType == nil then
        return nil, nil, nil
    end

    local groupName = self:getGroup(fillType)
    local skipReason = self:getSkipReason(fillType, groupName)
    if skipReason ~= nil then
        return nil, groupName, skipReason
    end

    local factor = self:getMarketFactor(groupName)
    local saleBasePrice = self:getSaleBasePrice(station, fillTypeIndex, fillType, currentBasePrice)
    if saleBasePrice == nil or factor == nil then
        return nil, groupName, "noNeutralPrice"
    end

    return saleBasePrice * factor, groupName, nil
end

function DynamicMarket:getTargetSalePrice(station, fillTypeIndex, fillType, currentBasePrice)
    local neutralPrice, groupName, skipReason = self:getNeutralMarketPrice(fillType, fillTypeIndex, currentBasePrice, station)
    if neutralPrice == nil or skipReason ~= nil then
        return nil, groupName, skipReason
    end

    local stationScale = self:getStationNegativePriceScale(station, fillTypeIndex)
    return neutralPrice * stationScale, groupName, nil
end

function DynamicMarket:writeTargetSalePrice(station, fillTypeIndex, targetPrice)
    if station == nil or type(station) ~= "table" or targetPrice == nil then
        return false
    end

    local key = fillTypeIndex
    local effectiveTargetPrice = tonumber(targetPrice)
    if effectiveTargetPrice == nil or effectiveTargetPrice <= 0 then
        return false
    end

    local economyMultiplier = self:getEconomyPriceMultiplier()
    if economyMultiplier == nil or economyMultiplier <= 0 then
        economyMultiplier = 1
    end

    local rawStationPrice = effectiveTargetPrice / economyMultiplier

    if station.fillTypePrices ~= nil then
        station.fillTypePrices[key] = rawStationPrice
    end

    if station.originalFillTypePrices ~= nil then
        station.originalFillTypePrices[key] = rawStationPrice
    end

    if station.originalFillTypePricesUnscaled ~= nil then
        station.originalFillTypePricesUnscaled[key] = rawStationPrice
    end

    if station.priceMultipliers ~= nil then
        station.priceMultipliers[key] = 1
    end

    if station.fillTypePriceRandomDelta ~= nil then
        station.fillTypePriceRandomDelta[key] = 0
    end

    if station.pendingPriceDrop ~= nil then
        station.pendingPriceDrop[key] = 0
    end

    return true
end

function DynamicMarket:getBaseGameYearlyOrientationFactor(fillType)
    if fillType == nil or type(fillType) ~= "table" then
        return 1
    end

    self:cacheBaseGameEconomy(fillType)

    local sum = 0
    local count = 0
    for period = 1, 12 do
        local factor = tonumber(self:getBaseGameEconomyValueForPeriod(fillType, period))
        if factor ~= nil then
            sum = sum + factor
            count = count + 1
        end
    end

    if count <= 0 then
        return 1
    end

    return sum / count
end

function DynamicMarket:buildYearlyAverageCurve(fillType)
    local orientationFactor = self:getBaseGameYearlyOrientationFactor(fillType)
    local curve = {}
    for _, period in ipairs(self.PERIODS) do
        curve[period] = orientationFactor
    end
    return curve
end

function DynamicMarket:buildMarketFactors(stats)
    local key, period, year, mapName = self:getMarketKey()
    if self.__marketKey == key and self.__marketFactors ~= nil then
        return self.__marketFactors, key, period, year, mapName
    end

    local factors = {}
    local marketParts = {}
    for groupName, _ in pairs(self.MARKET_GROUPS) do
        local factor, data = self:buildMarketFactorForGroup(groupName, period, year, mapName)
        factors[groupName] = data
        table.insert(marketParts, string.format("%s=%+.1f%%", groupName, (factor - 1) * 100))
    end

    table.sort(marketParts)
    self.__marketFactors = factors
    self.__marketKey = key

    local strongestPositiveName = nil
    local strongestNegativeName = nil
    local strongestPositiveValue = -999
    local strongestNegativeValue = 999
    for groupName, data in pairs(factors) do
        local value = tonumber(data.factor) or 1
        if value > strongestPositiveValue then
            strongestPositiveValue = value
            strongestPositiveName = groupName
        end
        if value < strongestNegativeValue then
            strongestNegativeValue = value
            strongestNegativeName = groupName
        end
    end

    self.__marketDriverReport = {
        strongestPositiveName = strongestPositiveName,
        strongestNegativeName = strongestNegativeName,
        strongestPositiveFactor = strongestPositiveValue,
        strongestNegativeFactor = strongestNegativeValue
    }

    if self.DIAGNOSTICS.marketModel then
        Logging.info("%s marketModel version=%s type=regionalSupplyDemand seasonalSupply=yes storageRead=no yieldChange=no priceOnly=yes strongestUp=%s strongestDown=%s",
            self.LOG_PREFIX,
            self.VERSION,
            self:formatMarketDriverShort(strongestPositiveName, factors[strongestPositiveName]),
            self:formatMarketDriverShort(strongestNegativeName, factors[strongestNegativeName])
        )
    end

    if self.DIAGNOSTICS.market then
        Logging.info("%s market version=%s period=%d year=%d map=%s mode=stationPriceTables saleHook=priceTable model=regionalSupplyDemand factors=%s",
            self.LOG_PREFIX,
            self.VERSION,
            period,
            year,
            tostring(mapName),
            table.concat(marketParts, ",")
        )

        Logging.info("%s marketDrivers version=%s strongestPositive=%s strongestNegative=%s",
            self.LOG_PREFIX,
            self.VERSION,
            self:formatMarketDriver(strongestPositiveName, factors[strongestPositiveName]),
            self:formatMarketDriver(strongestNegativeName, factors[strongestNegativeName])
        )
    end

    return factors, key, period, year, mapName
end

function DynamicMarket:getMarketFactor(groupName)
    if groupName == nil then
        return 1
    end
    local factors = self.__marketFactors
    if factors == nil or factors[groupName] == nil then
        return 1
    end
    return tonumber(factors[groupName].factor) or 1
end


function DynamicMarket:getFillTypeByIndex(fillTypeIndex)
    local index = tonumber(fillTypeIndex)
    if index == nil then
        return nil
    end
    local fillTypes = self:getFillTypes(g_fillTypeManager)
    if fillTypes == nil then
        return nil
    end
    return fillTypes[index]
end

function DynamicMarket:addSellingStationCandidate(list, seen, station)
    if station == nil or type(station) ~= "table" then
        return
    end
    if station.fillTypePrices == nil or type(station.fillTypePrices) ~= "table" then
        return
    end

    local key = tostring(station)
    if seen[key] == true then
        return
    end

    seen[key] = true
    table.insert(list, station)
end

function DynamicMarket:getSellingStationsForPriceWrite()
    local stations = {}
    local seen = {}
    local mission = g_currentMission

    local economyManager = mission ~= nil and mission.economyManager or nil
    local economyStations = economyManager ~= nil and economyManager.sellingStations or nil
    if economyStations ~= nil and type(economyStations) == "table" then
        for _, entry in pairs(economyStations) do
            local station = type(entry) == "table" and entry.station or entry
            self:addSellingStationCandidate(stations, seen, station)
        end
    end

    local storageSystem = mission ~= nil and mission.storageSystem or nil
    if storageSystem ~= nil and storageSystem.getUnloadingStations ~= nil then
        local unloadingStations = storageSystem:getUnloadingStations()
        if unloadingStations ~= nil and type(unloadingStations) == "table" then
            for _, station in pairs(unloadingStations) do
                if station ~= nil and station.isa ~= nil and SellingStation ~= nil and station:isa(SellingStation) then
                    self:addSellingStationCandidate(stations, seen, station)
                end
            end
        end
    end

    return stations
end

function DynamicMarket:getSellingStationCount()
    return #self:getSellingStationsForPriceWrite()
end

function DynamicMarket:addUniqueName(list, seen, name, maxCount)
    if list == nil or seen == nil or name == nil then
        return
    end
    local key = tostring(name)
    if key == "" or seen[key] == true then
        return
    end
    seen[key] = true
    if #list < maxCount then
        table.insert(list, key)
    end
end

function DynamicMarket:applyMonthlyMarketToSellingStations(passName)
    local marketKey, period, year, mapName = self:getMarketKey()
    self:buildMarketFactors(nil)

    self.__lastSaleMarketReport = {
        passName = tostring(passName or "unknown"),
        enabled = self.APPLY_MONTHLY_MARKET_TO_SALES == true,
        period = tonumber(period) or 1,
        year = tonumber(year) or 1,
        stations = 0,
        adjusted = 0,
        uniqueFillTypes = 0,
        skipped = 0,
        minFactor = 1,
        maxFactor = 1,
        success = false,
        reason = "notApplied"
    }

    local sellingStations = self:getSellingStationsForPriceWrite()
    self:prepareStationBasePriceCache(sellingStations)

    if sellingStations == nil or type(sellingStations) ~= "table" or #sellingStations == 0 then
        self.__lastSaleMarketReport.reason = "noSellingStations"
        if self.DIAGNOSTICS.saleMarket then
            Logging.info("%s saleMarketApplied version=%s pass=%s mode=stationPriceTables enabled=%s stations=0 adjusted=0 skipped=0 reason=noSellingStations",
                self.LOG_PREFIX,
                self.VERSION,
                tostring(passName or "unknown"),
                tostring(self.APPLY_MONTHLY_MARKET_TO_SALES)
            )
        end
        return
    end

    local stationCount = 0
    local adjusted = 0
    local skipped = 0
    local groupCounts = {}
    local changedNames = {}
    local changedNameSeen = {}
    local uniqueAdjustedFillTypes = 0
    local minFactor = 999
    local maxFactor = -999

    for _, station in pairs(sellingStations) do
        if station ~= nil and type(station) == "table" and station.fillTypePrices ~= nil and type(station.fillTypePrices) == "table" then
            stationCount = stationCount + 1
            for key, price in pairs(station.fillTypePrices) do
                local fillType = self:getFillTypeByIndex(key)
                local groupName = self:getGroup(fillType)
                local skipReason = self:getSkipReason(fillType, groupName)
                local basePrice = tonumber(price)
                local finalPrice, targetGroupName, targetSkipReason = self:getTargetSalePrice(station, key, fillType, basePrice)
                if targetGroupName ~= nil then
                    groupName = targetGroupName
                end
                local factor = self:getMarketFactor(groupName)

                if fillType ~= nil and skipReason == nil and targetSkipReason == nil and basePrice ~= nil and finalPrice ~= nil and factor ~= nil then
                    if self.APPLY_MONTHLY_MARKET_TO_SALES then
                        self:writeTargetSalePrice(station, key, finalPrice)
                    end
                    adjusted = adjusted + 1
                    groupCounts[groupName] = (groupCounts[groupName] or 0) + 1
                    minFactor = math.min(minFactor, factor)
                    maxFactor = math.max(maxFactor, factor)
                    local fillTypeName = self:getFillTypeName(fillType)
                    if changedNameSeen[fillTypeName] ~= true then
                        uniqueAdjustedFillTypes = uniqueAdjustedFillTypes + 1
                    end
                    self:addUniqueName(changedNames, changedNameSeen, fillTypeName, self.DIAGNOSTICS.maxSaleMarketNames)
                else
                    skipped = skipped + 1
                end
            end
        end
    end

    if minFactor == 999 then
        minFactor = 1
    end
    if maxFactor == -999 then
        maxFactor = 1
    end

    self.__lastSaleMarketReport.stations = stationCount
    self.__lastSaleMarketReport.adjusted = adjusted
    self.__lastSaleMarketReport.uniqueFillTypes = uniqueAdjustedFillTypes
    self.__lastSaleMarketReport.skipped = skipped
    self.__lastSaleMarketReport.minFactor = minFactor
    self.__lastSaleMarketReport.maxFactor = maxFactor
    self.__lastSaleMarketReport.success = adjusted > 0
    self.__lastSaleMarketReport.reason = adjusted > 0 and "applied" or "noAdjustedPrices"
    self.__lastSellingStationCount = stationCount
    if adjusted > 0 then
        self.__uiPriceRefreshToken = (tonumber(self.__uiPriceRefreshToken) or 0) + 1
    end

    if self.DIAGNOSTICS.saleMarket then
        table.sort(changedNames)
        self.__lastSalesMarketKey = marketKey
        self.__lastObservedMarketKey = marketKey
        if self.DIAGNOSTICS.saleMarketNames then
            Logging.info("%s saleMarketApplied version=%s pass=%s mode=stationPriceTables enabled=%s period=%d year=%d stations=%d adjusted=%d uniqueFillTypes=%d skipped=%d factorRange=%s names=%s",
                self.LOG_PREFIX,
                self.VERSION,
                tostring(passName or "unknown"),
                tostring(self.APPLY_MONTHLY_MARKET_TO_SALES),
                tonumber(period) or 1,
                tonumber(year) or 1,
                stationCount,
                adjusted,
                uniqueAdjustedFillTypes,
                skipped,
                self:formatFactorRange(minFactor, maxFactor),
                self:formatLimitedList(changedNames, self.DIAGNOSTICS.maxSaleMarketNames)
            )
        else
            Logging.info("%s saleMarketApplied version=%s pass=%s mode=stationPriceTables enabled=%s period=%d year=%d stations=%d adjusted=%d uniqueFillTypes=%d skipped=%d factorRange=%s names=disabled",
                self.LOG_PREFIX,
                self.VERSION,
                tostring(passName or "unknown"),
                tostring(self.APPLY_MONTHLY_MARKET_TO_SALES),
                tonumber(period) or 1,
                tonumber(year) or 1,
                stationCount,
                adjusted,
                uniqueAdjustedFillTypes,
                skipped,
                self:formatFactorRange(minFactor, maxFactor)
            )
        end
    end
end


function DynamicMarket:formatSignedPercent(value)
    value = tonumber(value) or 1
    return string.format("%+.1f%%", (value - 1) * 100)
end

function DynamicMarket:formatFactorRange(minFactor, maxFactor)
    return string.format("%s to %s", self:formatSignedPercent(minFactor), self:formatSignedPercent(maxFactor))
end

function DynamicMarket:formatDriver(value)
    value = tonumber(value) or 0
    return string.format("%+.2f", value)
end

function DynamicMarket:formatMarketDriverShort(groupName, data)
    if data == nil then
        return tostring(groupName or "none") .. "=none"
    end
    return string.format("%s=%s", tostring(groupName or "unknown"), self:formatSignedPercent(data.factor or 1))
end

function DynamicMarket:formatMarketDriver(groupName, data)
    if data == nil then
        return tostring(groupName or "none") .. "=none"
    end

    return string.format("%s=%s(weather=%s,supply=%s,demand=%s,volatility=%.2f)",
        tostring(groupName or "none"),
        self:formatSignedPercent(data.factor),
        self:formatDriver(data.weather),
        self:formatDriver(data.supply),
        self:formatDriver(data.demand),
        tonumber(data.volatility) or 0
    )
end

function DynamicMarket:getGameLanguage()
    local lang = nil
    if type(g_languageShort) == "string" and g_languageShort ~= "" then
        lang = g_languageShort
    elseif g_i18n ~= nil then
        if type(g_i18n.languageShort) == "string" and g_i18n.languageShort ~= "" then
            lang = g_i18n.languageShort
        elseif type(g_i18n.currentLanguage) == "string" and g_i18n.currentLanguage ~= "" then
            lang = g_i18n.currentLanguage
        end
    end

    lang = string.lower(tostring(lang or "en"))
    return string.sub(lang, 1, 2)
end

function DynamicMarket:getLocalizedText(key, fallback)
    local lang = self:getGameLanguage()
    local texts = self.NOTICE_TEXTS or {}
    if texts[lang] ~= nil and texts[lang][key] ~= nil then
        return texts[lang][key]
    end
    if texts.en ~= nil and texts.en[key] ~= nil then
        return texts.en[key]
    end
    return tostring(fallback or key or "")
end

function DynamicMarket:getMarketGroupDisplayName(groupName)
    local fallbacks = {
        cereal = "Getreide",
        oilseed = "Ölfrüchte",
        rootcrop = "Hackfrüchte",
        vegetable = "Gemüse",
        forage = "Futterpflanzen",
        fiber = "Fasern",
        animal = "Tierprodukte",
        animalMarket = "Tiere",
        auxiliaryProduct = "Hilfswaren",
        production = "verarbeitete Waren",
        preserved = "Konserven",
        packaged = "verpackte Waren",
        construction = "Baustoffe",
        woodProduct = "Holzprodukte"
    }

    return self:getLocalizedText("dm_group_" .. tostring(groupName or "unknown"), fallbacks[groupName] or tostring(groupName or "Markt"))
end

function DynamicMarket:formatMarketPercent(factor)
    local diff = ((tonumber(factor) or 1) - 1) * 100
    if diff >= 0 then
        return string.format("+%.1f%%", diff)
    end
    return string.format("%.1f%%", diff)
end

function DynamicMarket:formatNoticeMovement(groupName, factor)
    factor = tonumber(factor) or 1
    local diff = factor - 1
    local absDiff = math.abs(diff)
    if absDiff < (tonumber(self.MARKET_NOTICE_MIN_MOVEMENT) or 0.015) then
        return nil
    end

    return string.format("%s %s", self:getMarketGroupDisplayName(groupName), self:formatMarketPercent(factor))
end

function DynamicMarket:showMarketNotice(passName)
    if self.PLAYER_MARKET_NOTICES ~= true or tostring(passName or "") ~= "periodUpdate" then
        return
    end

    local marketKey = self.__lastSalesMarketKey or self:getMarketKey()
    if marketKey == nil or marketKey == self.__lastPlayerNoticeKey then
        return
    end

    local report = self.__marketDriverReport or {}
    local parts = {}
    local upText = self:formatNoticeMovement(report.strongestPositiveName, report.strongestPositiveFactor)
    local downText = self:formatNoticeMovement(report.strongestNegativeName, report.strongestNegativeFactor)
    if upText ~= nil then
        table.insert(parts, upText)
    end
    if downText ~= nil and downText ~= upText then
        table.insert(parts, downText)
    end

    local title = self:getLocalizedText("dm_notice_title", "Dynamischer Markt")
    local message = nil
    if #parts > 0 then
        message = table.concat(parts, ", ")
    else
        message = self:getLocalizedText("dm_notice_stable", "Warengruppen bleiben stabil.")
    end

    local text = title .. ": " .. message
    local mission = g_currentMission
    if mission ~= nil and mission.addIngameNotification ~= nil then
        local notificationType = 0
        if FSBaseMission ~= nil and FSBaseMission.INGAME_NOTIFICATION_OK ~= nil then
            notificationType = FSBaseMission.INGAME_NOTIFICATION_OK
        end
        mission:addIngameNotification(notificationType, text)
        self.__lastPlayerNoticeKey = marketKey
    end
end

function DynamicMarket:addSkippedName(stats, reason, fillType)
    if stats == nil or reason == nil then
        return
    end

    stats.skippedDetails = stats.skippedDetails or {}
    stats.skippedDetails[reason] = stats.skippedDetails[reason] or {}
    table.insert(stats.skippedDetails[reason], self:getFillTypeName(fillType))
end

function DynamicMarket:reportSkippedDetails(passName, stats)
    if not self.DIAGNOSTICS.skippedDetails or stats == nil or stats.skippedDetails == nil then
        return
    end

    local trackedReasons = {"noValidBasePrice", "unknownName", "excludedUtilityOrInternal"}
    for _, reason in ipairs(trackedReasons) do
        local names = stats.skippedDetails[reason]
        if names ~= nil and #names > 0 then
            table.sort(names)
            local maxNames = math.min(#names, self.DIAGNOSTICS.maxSkippedDetailNames)
            local out = {}
            for i = 1, maxNames do
                table.insert(out, names[i])
            end
            local suffix = #names > maxNames and string.format(",...(+%d more)", #names - maxNames) or ""
            Logging.info("%s skippedNames version=%s pass=%s reason=%s count=%d names=%s%s",
                self.LOG_PREFIX,
                self.VERSION,
                tostring(passName or "unknown"),
                tostring(reason),
                #names,
                table.concat(out, ","),
                suffix
            )
        end
    end
end


function DynamicMarket:reportFillType(action, fillType, groupName, groupReason, skipReason, oldCurve, newCurve)
    if not self.DIAGNOSTICS.everyFillType then
        return
    end

    local validFillType = fillType ~= nil and type(fillType) == "table"
    local name = self:getFillTypeName(fillType)
    local index = tostring(validFillType and fillType.index or "nil")
    local price = tonumber(validFillType and fillType.pricePerLiter or nil)
    local priceText = price ~= nil and string.format("%.6f", price) or "nil"
    local show = tostring(validFillType and fillType.showOnPriceTable == true or false)
    local existing = self:hasMeaningfulCurve(fillType) and "yes" or "no"

    Logging.info("%s report action=%s name=%s index=%s pricePerLiter=%s showOnPriceTable=%s group=%s groupSource=%s hadOwnCurve=%s oldCurve=%s newCurve=%s reason=%s",
        self.LOG_PREFIX,
        tostring(action),
        name,
        index,
        priceText,
        show,
        tostring(groupName or "none"),
        tostring(groupReason or "none"),
        existing,
        self:formatCurve(oldCurve) ~= "" and self:formatCurve(oldCurve) or "none",
        self:formatCurve(newCurve) ~= "" and self:formatCurve(newCurve) or "none",
        tostring(skipReason or "none")
    )
end

function DynamicMarket:applyToFillType(fillType, passName, stats)
    stats.total = stats.total + 1

    local groupName, groupReason = self:getGroup(fillType)
    local skipReason = self:getSkipReason(fillType, groupName)
    local oldCurve = self:copyCurve(self:getExistingCurve(fillType))
    local hadOwnCurve = self:hasMeaningfulCurve(fillType)

    if skipReason ~= nil then
        stats.skipped = stats.skipped + 1
        stats.skipCounts[skipReason] = (stats.skipCounts[skipReason] or 0) + 1
        self:addSkippedName(stats, skipReason, fillType)
        if skipReason == "noSafeCategory" then
            table.insert(stats.noSafeCategoryNames, self:getFillTypeName(fillType))
        end
        self:reportFillType("skipped", fillType, groupName, groupReason, skipReason, oldCurve, nil)
        return
    end

    local newCurve = nil
    if self.ENABLE_YEARLY_AVERAGE == true and self.YEARLY_AVERAGE_FLAT_BASEGAME_GRAPH == true then
        newCurve = self:buildYearlyAverageCurve(fillType)
    else
        newCurve = self:buildDynamicCurve(fillType, groupName)
    end

    if newCurve == nil then
        stats.skipped = stats.skipped + 1
        stats.skipCounts.applyFailed = (stats.skipCounts.applyFailed or 0) + 1
        self:reportFillType("skipped", fillType, groupName, groupReason, "applyFailed", oldCurve, nil)
        return
    end

    stats.eligible = stats.eligible + 1

    if self.APPLY_CURVES and self:applyCurve(fillType, newCurve) then
        stats.applied = stats.applied + 1
        stats.groupCounts[groupName] = (stats.groupCounts[groupName] or 0) + 1
        if hadOwnCurve then
            stats.adjustedExisting = stats.adjustedExisting + 1
        else
            stats.createdNew = stats.createdNew + 1
        end
        fillType.dynamicMarketGroup = groupName
        fillType.dynamicMarketFactor = self:getMarketFactor(groupName)
        stats.marketCounts[groupName] = (stats.marketCounts[groupName] or 0) + 1
        table.insert(stats.changedNames, self:getFillTypeName(fillType))
        self:reportFillType("applied", fillType, groupName, groupReason, nil, oldCurve, newCurve)
    else
        stats.skipped = stats.skipped + 1
        stats.skipCounts.reportOnly = (stats.skipCounts.reportOnly or 0) + 1
        self:reportFillType("skipped", fillType, groupName, groupReason, "reportOnly", oldCurve, newCurve)
    end
end

function DynamicMarket:formatCounts(counts)
    local parts = {}
    for name, count in pairs(counts) do
        table.insert(parts, string.format("%s=%d", name, count))
    end
    table.sort(parts)
    return #parts > 0 and table.concat(parts, ",") or "none"
end

function DynamicMarket:applyAll(manager, passName)
    local fillTypes = self:getFillTypes(manager)
    if fillTypes == nil then
        if self.DIAGNOSTICS.debugLog then
            Logging.info("%s summary version=%s pass=%s total=0 eligible=0 applied=0 skipped=0 reason=noFillTypeTable", self.LOG_PREFIX, self.VERSION, tostring(passName or "unknown"))
        end
        return
    end

    self.__applyPass = self.__applyPass + 1

    local stats = {
        total = 0,
        eligible = 0,
        applied = 0,
        skipped = 0,
        adjustedExisting = 0,
        createdNew = 0,
        groupCounts = {},
        marketCounts = {},
        skipCounts = {},
        changedNames = {},
        noSafeCategoryNames = {},
        skippedDetails = {}
    }

    self:buildMarketFactors(stats)

    for _, fillType in ipairs(fillTypes) do
        self:applyToFillType(fillType, passName, stats)
    end

    if self.DIAGNOSTICS.debugLog then
        Logging.info("%s summary version=%s pass=%s passIndex=%d total=%d eligible=%d applied=%d adjustedExisting=%d createdNew=%d skipped=%d",
            self.LOG_PREFIX,
            self.VERSION,
            tostring(passName or "unknown"),
            self.__applyPass,
            stats.total,
            stats.eligible,
            stats.applied,
            stats.adjustedExisting,
            stats.createdNew,
            stats.skipped
        )
    end

    if self.DIAGNOSTICS.market then
        Logging.info("%s marketAffected pass=%s groups=%s mode=stationPriceTables saleHook=priceTable", self.LOG_PREFIX, tostring(passName or "unknown"), self:formatCounts(stats.marketCounts))
    end


    if self.DIAGNOSTICS.unsafeNames and #stats.noSafeCategoryNames > 0 then
        table.sort(stats.noSafeCategoryNames)
        local maxUnsafeNames = math.min(#stats.noSafeCategoryNames, self.DIAGNOSTICS.maxUnsafeNames)
        local names = {}
        for i = 1, maxUnsafeNames do
            table.insert(names, stats.noSafeCategoryNames[i])
        end
        local suffix = #stats.noSafeCategoryNames > maxUnsafeNames and string.format(",...(+%d more)", #stats.noSafeCategoryNames - maxUnsafeNames) or ""
        Logging.info("%s noSafeCategoryNames pass=%s count=%d names=%s%s", self.LOG_PREFIX, tostring(passName or "unknown"), #stats.noSafeCategoryNames, table.concat(names, ","), suffix)
    end

    self:reportSkippedDetails(passName, stats)
    self:applyMonthlyMarketToSellingStations(passName)

    if self.DIAGNOSTICS.changedNames and #stats.changedNames > 0 then
        table.sort(stats.changedNames)
        local maxNames = math.min(#stats.changedNames, self.DIAGNOSTICS.maxChangedNames)
        local names = {}
        for i = 1, maxNames do
            table.insert(names, stats.changedNames[i])
        end
        local suffix = #stats.changedNames > maxNames and string.format(",...(+%d more)", #stats.changedNames - maxNames) or ""
        Logging.info("%s changedFillTypes pass=%s names=%s%s", self.LOG_PREFIX, tostring(passName or "unknown"), table.concat(names, ","), suffix)
    end

    self:reportFinalStatus(passName)
    self:reportMarketWatch(passName)
end

function DynamicMarket:ensurePricesReadyForUi(passName)
    if g_fillTypeManager == nil or self:getFillTypes(g_fillTypeManager) == nil then
        return false
    end

    if self:getSellingStationCount() <= 0 then
        return false
    end

    if self.__finalApplied ~= true or self.__lastSaleMarketReport == nil or self.__lastSaleMarketReport.success ~= true then
        self:applyAll(g_fillTypeManager, passName or "uiReady")
        if self.__lastSaleMarketReport ~= nil and self.__lastSaleMarketReport.success == true then
            self.__finalApplied = true
            return true
        end
        return false
    end

    return true
end

function DynamicMarket:reportMarketWatch(passName)
    local marketKey, period, year, _ = self:getMarketKey()
    if self.DIAGNOSTICS.debugLog then
        Logging.info("%s marketWatch version=%s pass=%s status=armed period=%d year=%d stationCount=%d checkIntervalMs=%d",
            self.LOG_PREFIX,
            self.VERSION,
            tostring(passName or "unknown"),
            tonumber(period) or 1,
            tonumber(year) or 1,
            tonumber(self.__lastSellingStationCount) or 0,
            tonumber(self.PERIOD_CHECK_INTERVAL_MS) or 0
        )
    end
    self.__lastObservedMarketKey = marketKey
end

function DynamicMarket:reportNameCandidates()
end

function DynamicMarket:reportFinalStatus(passName)
    if not self.DIAGNOSTICS.finalStatus then
        return
    end

    local report = self.__lastSaleMarketReport or {}
    Logging.info("%s FINAL status version=%s pass=%s saleMarketApplied=%s period=%d year=%d stations=%d adjusted=%d uniqueFillTypes=%d skipped=%d factorRange=%s reason=%s stationWatch=on model=regionalSupplyDemand seasonalSupply=yes",
        self.LOG_PREFIX,
        self.VERSION,
        tostring(passName or report.passName or "unknown"),
        report.success == true and "yes" or "no",
        tonumber(report.period) or self:getMissionPeriod(),
        tonumber(report.year) or self:getMissionYear(),
        tonumber(report.stations) or 0,
        tonumber(report.adjusted) or 0,
        tonumber(report.uniqueFillTypes) or 0,
        tonumber(report.skipped) or 0,
        self:formatFactorRange(report.minFactor or 1, report.maxFactor or 1),
        tostring(report.reason or "unknown")
    )
end





function DynamicMarket:fixInGameMenuPage(frame, pageName, uvs, position, predicateFunc)
    local inGameMenu = nil
    if g_gui ~= nil and type(g_gui.screenControllers) == "table" and InGameMenu ~= nil then
        inGameMenu = g_gui.screenControllers[InGameMenu]
    end
    if inGameMenu == nil or inGameMenu.pagingElement == nil or frame == nil then
        return false
    end
    if inGameMenu[pageName] ~= nil then
        return true
    end

    local insertPosition = tonumber(position) or 3
    for i = 1, #inGameMenu.pagingElement.elements do
        local child = inGameMenu.pagingElement.elements[i]
        if child == inGameMenu["pageStatistics"] then
            insertPosition = i
            break
        end
    end

    if inGameMenu.controlIDs ~= nil then
        inGameMenu.controlIDs[pageName] = nil
    end

    inGameMenu[pageName] = frame
    inGameMenu.pagingElement:addElement(inGameMenu[pageName])
    inGameMenu:exposeControlsAsFields(pageName)

    for i = 1, #inGameMenu.pagingElement.elements do
        local child = inGameMenu.pagingElement.elements[i]
        if child == inGameMenu[pageName] then
            table.remove(inGameMenu.pagingElement.elements, i)
            table.insert(inGameMenu.pagingElement.elements, insertPosition, child)
            break
        end
    end

    for i = 1, #inGameMenu.pagingElement.pages do
        local child = inGameMenu.pagingElement.pages[i]
        if child.element == inGameMenu[pageName] then
            table.remove(inGameMenu.pagingElement.pages, i)
            table.insert(inGameMenu.pagingElement.pages, insertPosition, child)
            break
        end
    end

    inGameMenu.pagingElement:updateAbsolutePosition()
    inGameMenu.pagingElement:updatePageMapping()
    inGameMenu:registerPage(inGameMenu[pageName], insertPosition, predicateFunc or function() return true end)
    inGameMenu:addPageTab(inGameMenu[pageName], Utils.getFilename("images/menuIcon.dds", self.MOD_DIR), GuiUtils.getUVs(uvs or {0,0,1024,1024}))

    for i = 1, #inGameMenu.pageFrames do
        local child = inGameMenu.pageFrames[i]
        if child == inGameMenu[pageName] then
            table.remove(inGameMenu.pageFrames, i)
            table.insert(inGameMenu.pageFrames, insertPosition, child)
            break
        end
    end

    inGameMenu:rebuildTabList()
    return true
end

function DynamicMarket:registerMenuPage()
    if self.__dynamicMarketMenuRegistered == true then
        return
    end
    if g_gui == nil or InGameMenu == nil or DynamicMarketMenuFrame == nil then
        return
    end

    g_gui:loadProfiles(self.MOD_DIR .. "gui/dynamicMarketProfiles.xml")

    local frame = DynamicMarketMenuFrame.new(g_i18n)
    g_gui:loadGui(self.MOD_DIR .. "gui/DynamicMarketMenuFrame.xml", "DynamicMarketMenuFrame", frame, true)
    if self:fixInGameMenuPage(frame, "pageDynamicMarket", {0,0,1024,1024}, 3, function() return true end) then
        if frame.initialize ~= nil then
            frame:initialize()
        end
        self.__dynamicMarketMenuRegistered = true
    end
end

function DynamicMarket:getBaseGameEconomyValueForPeriod(fillType, period)
    local month = tonumber(period) or 1
    if fillType == nil or type(fillType) ~= "table" then
        return 1
    end

    if type(fillType.dynamicMarketBaseGameEconomicCurve) == "table" and fillType.dynamicMarketBaseGameEconomicCurve[month] ~= nil then
        return tonumber(fillType.dynamicMarketBaseGameEconomicCurve[month]) or 1
    end

    if type(fillType.dynamicMarketBaseGameFactors) == "table" and fillType.dynamicMarketBaseGameFactors[month] ~= nil then
        return tonumber(fillType.dynamicMarketBaseGameFactors[month]) or 1
    end

    if type(fillType.dynamicMarketBaseGameHistory) == "table" and fillType.dynamicMarketBaseGameHistory[month] ~= nil then
        local historyValue = tonumber(fillType.dynamicMarketBaseGameHistory[month])
        local pricePerLiter = tonumber(fillType.pricePerLiter)
        if historyValue ~= nil and pricePerLiter ~= nil and pricePerLiter > 0 then
            return historyValue / pricePerLiter
        end
        if historyValue ~= nil then
            return historyValue
        end
    end

    if type(fillType.economicCurve) == "table" then
        return tonumber(fillType.economicCurve[month]) or 1
    end

    if fillType.economy ~= nil and type(fillType.economy.factors) == "table" then
        return tonumber(fillType.economy.factors[month]) or 1
    end

    return 1
end

function DynamicMarket:getBestMonthForFillType(fillType)
    local bestMonth = 1
    local bestValue = -math.huge
    if fillType == nil then
        return bestMonth
    end

    for period = 1, 12 do
        local factor = 1
        factor = tonumber(self:getBaseGameEconomyValueForPeriod(fillType, period)) or 1
        local periodPrice = (tonumber(fillType.pricePerLiter) or 0) * factor
        if periodPrice > bestValue then
            bestValue = periodPrice
            bestMonth = period
        end
    end
    return bestMonth
end

function DynamicMarket:getMarketTrendText(groupName)
    local factor = self:getMarketFactor(groupName)
    return self:formatMarketPercent(factor)
end

function DynamicMarket:getTrendDirection(groupName)
    local factor = self:getMarketFactor(groupName)
    if factor > 1.005 then
        return "up"
    elseif factor < 0.995 then
        return "down"
    end
    return "stable"
end


function DynamicMarket:addStockLevel(stockLevels, fillTypeIndex, fillLevel)
    fillTypeIndex = tonumber(fillTypeIndex)
    fillLevel = tonumber(fillLevel) or 0
    if fillTypeIndex ~= nil and fillLevel > 0 then
        stockLevels[fillTypeIndex] = (stockLevels[fillTypeIndex] or 0) + fillLevel
    end
end

function DynamicMarket:addStorageFillLevels(stockLevels, storage)
    if storage == nil or type(storage.fillLevels) ~= "table" then
        return
    end
    local mission = g_currentMission
    local farmId = mission ~= nil and mission.getFarmId ~= nil and mission:getFarmId() or nil
    if storage.ownerFarmId ~= nil and farmId ~= nil and storage.ownerFarmId ~= farmId then
        return
    end
    for fillTypeIndex, fillLevel in pairs(storage.fillLevels) do
        self:addStockLevel(stockLevels, fillTypeIndex, fillLevel)
    end
end

function DynamicMarket:getStockLevelsByFillType()
    local stockLevels = {}
    local mission = g_currentMission
    local farmId = mission ~= nil and mission.getFarmId ~= nil and mission:getFarmId() or nil

    if mission ~= nil and mission.placeableSystem ~= nil and type(mission.placeableSystem.placeables) == "table" then
        for _, placeable in ipairs(mission.placeableSystem.placeables) do
            local ownerFarmId = placeable.ownerFarmId
            local belongsToFarm = farmId == nil or ownerFarmId == nil or ownerFarmId == farmId or ownerFarmId == 0
            if belongsToFarm then
                if placeable.spec_silo ~= nil then
                    if type(placeable.spec_silo.storages) == "table" then
                        for _, storage in ipairs(placeable.spec_silo.storages) do
                            self:addStorageFillLevels(stockLevels, storage)
                        end
                    elseif placeable.spec_silo.loadingStation ~= nil and placeable.spec_silo.loadingStation.getAllFillLevels ~= nil and farmId ~= nil then
                        for fillTypeIndex, fillLevel in pairs(placeable.spec_silo.loadingStation:getAllFillLevels(farmId) or {}) do
                            self:addStockLevel(stockLevels, fillTypeIndex, fillLevel)
                        end
                    end
                end

                if placeable.spec_siloExtension ~= nil then
                    self:addStorageFillLevels(stockLevels, placeable.spec_siloExtension.storage)
                end

                if placeable.spec_husbandry ~= nil then
                    self:addStorageFillLevels(stockLevels, placeable.spec_husbandry.storage)
                end

                if placeable.spec_manureHeap ~= nil and placeable.spec_manureHeap.manureHeap ~= nil and type(placeable.spec_manureHeap.manureHeap.fillLevels) == "table" then
                    for fillTypeIndex, fillLevel in pairs(placeable.spec_manureHeap.manureHeap.fillLevels) do
                        self:addStockLevel(stockLevels, fillTypeIndex, fillLevel)
                    end
                end
            end
        end
    end

    if mission ~= nil and mission.productionChainManager ~= nil and type(mission.productionChainManager.productionPoints) == "table" then
        for _, productionPoint in ipairs(mission.productionChainManager.productionPoints) do
            local isMine = farmId == nil or productionPoint.getOwnerFarmId == nil or productionPoint:getOwnerFarmId() == farmId
            if isMine and productionPoint.storage ~= nil then
                if type(productionPoint.outputFillTypeIdsArray) == "table" and productionPoint.storage.getFillLevel ~= nil then
                    for _, fillTypeIndex in ipairs(productionPoint.outputFillTypeIdsArray) do
                        self:addStockLevel(stockLevels, fillTypeIndex, productionPoint.storage:getFillLevel(fillTypeIndex))
                    end
                else
                    self:addStorageFillLevels(stockLevels, productionPoint.storage)
                end
            end
        end
    end

    if mission ~= nil and mission.vehicleSystem ~= nil and type(mission.vehicleSystem.vehicles) == "table" then
        for _, vehicle in ipairs(mission.vehicleSystem.vehicles) do
            if (farmId == nil or vehicle.ownerFarmId == farmId) and vehicle.spec_fillUnit ~= nil and type(vehicle.spec_fillUnit.fillUnits) == "table" then
                if vehicle.isPallet == true or vehicle.typeName == "globalTransportPallet" or vehicle.typeName == "globalTransportPalletLiquids" then
                    for _, fillUnit in ipairs(vehicle.spec_fillUnit.fillUnits) do
                        self:addStockLevel(stockLevels, fillUnit.fillType, fillUnit.fillLevel)
                    end
                end
            end
        end
    end

    if mission ~= nil and mission.itemSystem ~= nil and type(mission.itemSystem.itemsToSave) == "table" then
        for _, item in pairs(mission.itemSystem.itemsToSave) do
            local bale = item.item
            if bale ~= nil and bale.isa ~= nil and Bale ~= nil and bale:isa(Bale) and (farmId == nil or bale.ownerFarmId == farmId) then
                self:addStockLevel(stockLevels, bale.fillType, bale.fillLevel)
            end
        end
    end

    return stockLevels
end

function DynamicMarket:buildMarketOverviewRows()
    self:buildMarketFactors(nil)

    local rowsByFillType = {}
    local stockLevelsByFillType = self:getStockLevelsByFillType()
    local mission = g_currentMission
    local storageSystem = mission ~= nil and mission.storageSystem or nil
    if storageSystem == nil or storageSystem.getUnloadingStations == nil then
        return {}
    end

    local stations = storageSystem:getUnloadingStations()
    if stations == nil then
        return {}
    end

    for _, station in pairs(stations) do
        if station ~= nil and station.isa ~= nil and station:isa(SellingStation) and not station.hideFromPricesMenu and station.acceptedFillTypes ~= nil then
            for fillTypeIndex, isAccepted in pairs(station.acceptedFillTypes) do
                if isAccepted == true and station.ownerFarmId ~= mission:getFarmId() then
                    local fillType = self:getFillTypeByIndex(fillTypeIndex)
                    local groupName = self:getGroup(fillType)
                    local skipReason = self:getSkipReason(fillType, groupName)
                    if fillType ~= nil and skipReason == nil then
                        local price = 0
                        if station.getEffectiveFillTypePrice ~= nil then
                            price = tonumber(station:getEffectiveFillTypePrice(fillTypeIndex)) or 0
                        elseif station.fillTypePrices ~= nil then
                            price = tonumber(station.fillTypePrices[fillTypeIndex]) or 0
                        end

                        local row = rowsByFillType[fillTypeIndex]
                        if row == nil then
                            row = {
                                index = fillTypeIndex,
                                title = tostring(fillType.title or fillType.name or fillTypeIndex),
                                name = tostring(fillType.name or fillTypeIndex),
                                hudOverlayFilename = fillType.hudOverlayFilename,
                                groupName = groupName,
                                groupTitle = self:getMarketGroupDisplayName(groupName),
                                marketFactor = self:getMarketFactor(groupName),
                                marketText = self:getMarketTrendText(groupName),
                                trendDirection = self:getTrendDirection(groupName),
                                bestPrice = 0,
                                currentBestPrice = 0,
                                stationBestPrice = 0,
                                bestStation = "",
                                bestMonth = self:getBestMonthForFillType(fillType),
                                bestMonthNumber = 1,
                                bestMonthPrice = 0,
                                baseCurrentPrice = 0,
                                yearlyAveragePrice = 0,
                                priceTrend = 0,
                                sellPointCount = 0,
                                stockLevel = tonumber(stockLevelsByFillType[fillTypeIndex]) or 0
                            }
                            row.bestMonthNumber = tonumber(row.bestMonth) or 1
                            rowsByFillType[fillTypeIndex] = row
                        end

                        row.sellPointCount = row.sellPointCount + 1

                        local neutralPrice, _, _ = self:getNeutralMarketPrice(fillType, fillTypeIndex, price, station)
                        local yearlyAverage = self:getBaseGameYearlyAveragePrice(fillType, station, fillTypeIndex, price)
                        local marketFactor = tonumber(row.marketFactor) or 1
                        local saleBasePrice = self:getSaleBasePrice(station, fillTypeIndex, fillType, price)
                        if self.ENABLE_YEARLY_AVERAGE == true and self.USE_YEARLY_AVERAGE_AS_BASE_PRICE == true and yearlyAverage ~= nil and yearlyAverage > 0 and neutralPrice ~= nil and neutralPrice > 0 then
                            row.yearlyAveragePrice = yearlyAverage
                            row.baseCurrentPrice = yearlyAverage
                            row.bestPrice = neutralPrice
                            row.currentBestPrice = neutralPrice
                        elseif neutralPrice ~= nil and neutralPrice > row.currentBestPrice then
                            row.currentBestPrice = neutralPrice
                            if saleBasePrice ~= nil and saleBasePrice > 0 then
                                row.baseCurrentPrice = saleBasePrice
                            elseif marketFactor ~= 0 then
                                row.baseCurrentPrice = neutralPrice / marketFactor
                            else
                                row.baseCurrentPrice = neutralPrice
                            end
                            row.bestPrice = neutralPrice
                        end

                        local stationComparePrice = self.__bestStationRawPriceByFillType ~= nil and tonumber(self.__bestStationRawPriceByFillType[fillTypeIndex]) or nil
                        local stationName = self.__bestStationNameByFillType ~= nil and tostring(self.__bestStationNameByFillType[fillTypeIndex] or "") or ""
                        local stationObject = self.__bestStationObjectByFillType ~= nil and self.__bestStationObjectByFillType[fillTypeIndex] or nil

                        if stationComparePrice == nil or stationComparePrice <= 0 then
                            stationComparePrice = self:getStationRawPriceBase(station, fillTypeIndex) or price
                            if station.getName ~= nil then
                                stationName = tostring(station:getName() or "")
                            end
                            stationObject = station
                        end

                        if stationComparePrice > row.stationBestPrice or (stationComparePrice == row.stationBestPrice and stationName ~= "" and (row.bestStation == "" or stationName < row.bestStation)) then
                            row.stationBestPrice = stationComparePrice
                            row.bestStation = stationName
                            row.bestStationObject = stationObject
                            if stationObject ~= nil and stationObject.getCurrentPricingTrend ~= nil then
                                row.priceTrend = stationObject:getCurrentPricingTrend(fillTypeIndex)
                            else
                                row.priceTrend = 0
                            end
                        end
                    end
                end
            end
        end
    end

    local rows = {}
    for _, row in pairs(rowsByFillType) do
        table.insert(rows, row)
    end
    table.sort(rows, function(a, b)
        return string.lower(tostring(a.title or "")) < string.lower(tostring(b.title or ""))
    end)
    return rows
end

function DynamicMarket:getPriceBaseMode()
    local mode = tonumber(self.priceBaseMode) or self.PRICE_BASE_YEAR_AVERAGE
    if mode ~= self.PRICE_BASE_NORMAL and mode ~= self.PRICE_BASE_YEAR_AVERAGE then
        mode = self.PRICE_BASE_YEAR_AVERAGE
    end
    return mode
end

function DynamicMarket:setPriceBaseMode(mode, passName)
    mode = tonumber(mode) or self.PRICE_BASE_YEAR_AVERAGE
    if mode ~= self.PRICE_BASE_NORMAL and mode ~= self.PRICE_BASE_YEAR_AVERAGE then
        mode = self.PRICE_BASE_YEAR_AVERAGE
    end

    local changed = self.priceBaseMode ~= mode
    self.priceBaseMode = mode
    self.USE_YEARLY_AVERAGE_AS_BASE_PRICE = mode == self.PRICE_BASE_YEAR_AVERAGE

    if changed then
        self.__finalApplied = false
        self.__stableMs = 0
        self.__armedLogged = false
        self.__marketKey = nil
        self.__marketFactors = {}
        self.__lastSalesMarketKey = nil
        self.__lastObservedMarketKey = nil
        self.__lastSaleMarketReport = nil

        if g_fillTypeManager ~= nil and self:getSellingStationCount() > 0 then
            self:applyAll(g_fillTypeManager, passName or "priceBaseSetting")
            if self.__lastSaleMarketReport ~= nil and self.__lastSaleMarketReport.success == true then
                self.__finalApplied = true
            end
        end
    end
end

function DynamicMarket:loadMap(name)
    self.__loadMapSeen = true
    self.__finalApplied = false
    self.__stableMs = 0
    self.__runtimeMs = 0
    self.__armedLogged = false
    self.__lastFillTypeCount = self:getFillTypeCount(g_fillTypeManager)
    self.__marketKey = nil
    self.__marketFactors = {}
    self.__lastSalesMarketKey = nil
    self.__lastObservedMarketKey = nil
    self.__lastSaleMarketReport = nil
    self.__lastSellingStationCount = 0
    self.__periodCheckMs = 0
    self.__lastPlayerNoticeKey = nil
    if self.settings ~= nil then
        self.settings:install()
        self.settings:loadSettings()
        self.settings:applyToModule(false)
        if self.settings.initializeSettingsOption ~= nil then
            self.settings:initializeSettingsOption()
        end
    end
    self:registerMenuPage()
    if self.DIAGNOSTICS.debugLog then
        Logging.info("%s armed version=%s initialFillTypes=%d mode=stableFinal", self.LOG_PREFIX, self.VERSION, self.__lastFillTypeCount)
    end
end

function DynamicMarket:update(dt)
    local delta = tonumber(dt) or 0

    if self.__finalApplied then
        self.__periodCheckMs = (self.__periodCheckMs or 0) + delta
        if self.__periodCheckMs >= self.PERIOD_CHECK_INTERVAL_MS then
            self.__periodCheckMs = 0
            local marketKey, period, year, mapName = self:getMarketKey()
            if marketKey ~= nil and marketKey ~= self.__lastSalesMarketKey then
                if self.DIAGNOSTICS.debugLog then
                    Logging.info("%s periodChange version=%s oldKey=%s newKey=%s period=%d year=%d map=%s action=recalculateSalesMarket",
                        self.LOG_PREFIX,
                        self.VERSION,
                        tostring(self.__lastSalesMarketKey or self.__lastObservedMarketKey or "none"),
                        tostring(marketKey),
                        tonumber(period) or 1,
                        tonumber(year) or 1,
                        tostring(mapName or "unknownMap")
                    )
                end
                self.__marketKey = nil
                self.__marketFactors = {}
                self:applyMonthlyMarketToSellingStations("periodUpdate")
                self:reportFinalStatus("periodUpdate")
                self:reportMarketWatch("periodUpdate")
                self:showMarketNotice("periodUpdate")
            elseif self.RECHECK_SALES_ON_STATION_COUNT_CHANGE == true then
                local stationCount = self:getSellingStationCount()
                if stationCount > 0 and stationCount ~= (tonumber(self.__lastSellingStationCount) or 0) then
                    if self.DIAGNOSTICS.debugLog then
                        Logging.info("%s stationChange version=%s oldStations=%d newStations=%d period=%d year=%d action=recalculateSalesMarket",
                            self.LOG_PREFIX,
                            self.VERSION,
                            tonumber(self.__lastSellingStationCount) or 0,
                            stationCount,
                            tonumber(period) or 1,
                            tonumber(year) or 1
                        )
                    end
                    self:applyMonthlyMarketToSellingStations("stationUpdate")
                    self:reportFinalStatus("stationUpdate")
                    self:reportMarketWatch("stationUpdate")
                end
            end
        end
        return
    end

    self.__runtimeMs = self.__runtimeMs + delta

    if g_fillTypeManager == nil or self:getFillTypes(g_fillTypeManager) == nil then
        return
    end

    if not self.__loadMapSeen then
        self.__loadMapSeen = true
        self.__stableMs = 0
        self.__lastFillTypeCount = self:getFillTypeCount(g_fillTypeManager)
        self.__marketKey = nil
        self.__marketFactors = {}
        self.__lastSalesMarketKey = nil
        self.__lastObservedMarketKey = nil
        self.__lastSaleMarketReport = nil
        self.__lastSellingStationCount = 0
        self.__periodCheckMs = 0
            self.__lastPlayerNoticeKey = nil
        if self.DIAGNOSTICS.debugLog then
            Logging.info("%s armedFallback version=%s initialFillTypes=%d mode=stableFinal", self.LOG_PREFIX, self.VERSION, self.__lastFillTypeCount)
        end
        return
    end

    local currentCount = self:getFillTypeCount(g_fillTypeManager)
    local stationCount = self:getSellingStationCount()
    if currentCount ~= self.__lastFillTypeCount or stationCount <= 0 then
        self.__lastFillTypeCount = currentCount
        self.__stableMs = 0
        self.__armedLogged = false
        return
    end

    self.__stableMs = self.__stableMs + delta

    if not self.__armedLogged and currentCount > 0 and stationCount > 0 and self.__runtimeMs >= self.MIN_APPLY_DELAY_MS then
        self.__armedLogged = true
        if self.DIAGNOSTICS.debugLog then
            Logging.info("%s waitingReady version=%s fillTypes=%d stations=%d stableMs=%d requiredMs=%d", self.LOG_PREFIX, self.VERSION, currentCount, stationCount, self.__stableMs, self.STABLE_DELAY_MS)
        end
    end

    if self.__runtimeMs >= self.MIN_APPLY_DELAY_MS and self.__stableMs >= self.STABLE_DELAY_MS then
        self:applyAll(g_fillTypeManager, "initialReady")
        if self.__lastSaleMarketReport ~= nil and self.__lastSaleMarketReport.success == true then
            self.__finalApplied = true
        else
            self.__stableMs = 0
            self.__armedLogged = false
        end
    end
end

function DynamicMarket:deleteMap()
    self.__loadMapSeen = false
    self.__finalApplied = false
    self.__stableMs = 0
    self.__runtimeMs = 0
    self.__lastFillTypeCount = -1
    self.__marketKey = nil
    self.__marketFactors = {}
    self.__lastSalesMarketKey = nil
    self.__lastObservedMarketKey = nil
    self.__lastSaleMarketReport = nil
    self.__lastSellingStationCount = 0
    self.__periodCheckMs = 0
    self.__lastPlayerNoticeKey = nil
    self.__armedLogged = false
    self.__bestStationRawPriceByFillType = nil
    self.__bestStationNameByFillType = nil
    self.__bestStationObjectByFillType = nil
    self.__stationCountByFillType = nil
    self.__uiPriceRefreshToken = 0
end

DynamicMarket.settings = DynamicMarketSettings.new(DynamicMarket)
DynamicMarket.settings:install()

addModEventListener(DynamicMarket)

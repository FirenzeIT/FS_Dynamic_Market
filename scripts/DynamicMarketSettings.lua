DynamicMarketSettings = {}
DynamicMarketSettings._mt = Class(DynamicMarketSettings)

function DynamicMarketSettings.new(dynamicMarket, customMt)
    local self = setmetatable({}, customMt or DynamicMarketSettings._mt)
    self.dynamicMarket = dynamicMarket
    self.installed = false
    self.mode = dynamicMarket ~= nil and dynamicMarket.PRICE_BASE_YEAR_AVERAGE or 2
    self.settingsHeader = nil
    self.settingsRow = nil
    self.priceBaseOption = nil
    self.settingsInitialized = false
    return self
end

function DynamicMarketSettings:install()
    if self.installed == true then
        return true
    end
    if InGameMenuSettingsFrame == nil or Utils == nil or Utils.appendedFunction == nil then
        return false
    end

    InGameMenuSettingsFrame.onFrameOpen = Utils.appendedFunction(InGameMenuSettingsFrame.onFrameOpen, function()
        self:onSettingsFrameOpen()
    end)

    if InGameMenuSettingsFrame.update ~= nil then
        InGameMenuSettingsFrame.update = Utils.appendedFunction(InGameMenuSettingsFrame.update, function(_, dt)
            self:onSettingsFrameUpdate(dt)
        end)
    end

    self.installed = true
    return true
end

function DynamicMarketSettings:getSaveKey()
    return "gameSettings.dynamicMarket.priceBase#mode"
end

function DynamicMarketSettings:normalizeMode(mode)
    mode = tonumber(mode) or 2
    if mode ~= 1 and mode ~= 2 then
        mode = 2
    end
    return mode
end

function DynamicMarketSettings:loadSettings()
    local mode = self.mode
    if g_savegameXML ~= nil and getXMLInt ~= nil then
        mode = Utils.getNoNil(getXMLInt(g_savegameXML, self:getSaveKey()), mode)
    end
    self.mode = self:normalizeMode(mode)
end

function DynamicMarketSettings:saveSettings()
    if g_savegameXML ~= nil and setXMLInt ~= nil then
        setXMLInt(g_savegameXML, self:getSaveKey(), self.mode)
    end
end

function DynamicMarketSettings:applyToModule(save)
    self.mode = self:normalizeMode(self.mode)
    if self.dynamicMarket ~= nil and self.dynamicMarket.setPriceBaseMode ~= nil then
        self.dynamicMarket:setPriceBaseMode(self.mode, "gameSetting")
    end
    if save == true then
        self:saveSettings()
    end
end

function DynamicMarketSettings:findElementRecursive(root, predicate)
    if root == nil then
        return nil
    end
    if predicate(root) then
        return root
    end
    if root.elements ~= nil then
        for _, child in ipairs(root.elements) do
            local found = self:findElementRecursive(child, predicate)
            if found ~= nil then
                return found
            end
        end
    end
    return nil
end

function DynamicMarketSettings:isMultiTextOptionElement(element)
    return element ~= nil
        and MultiTextOptionElement ~= nil
        and element.isa ~= nil
        and element:isa(MultiTextOptionElement)
end

function DynamicMarketSettings:getGameSettingsLayout()
    if g_inGameMenu == nil or g_inGameMenu.pageSettings == nil then
        return nil
    end
    return g_inGameMenu.pageSettings.gameSettingsLayout
end

function DynamicMarketSettings:hasMultiTextOption(element)
    if element == nil then
        return false
    end
    return self:findElementRecursive(element, function(child)
        return self:isMultiTextOptionElement(child)
    end) ~= nil
end

function DynamicMarketSettings:getTemplates(layout)
    if layout == nil or layout.elements == nil then
        return nil, nil
    end

    local sectionHeader = nil
    local optionRow = nil

    for _, element in pairs(layout.elements) do
        if element.name == "sectionHeader" and sectionHeader == nil then
            sectionHeader = element
        end

        if optionRow == nil and element.typeName == "Bitmap" and self:hasMultiTextOption(element) then
            optionRow = element
        end

        if sectionHeader ~= nil and optionRow ~= nil then
            break
        end
    end

    return sectionHeader, optionRow
end


function DynamicMarketSettings:setTooltipText(element, text)
    if element == nil then
        return
    end
    element.toolTip = text
    element.tooltip = text
    element.toolTipText = text
    element.tooltipText = text
    element.helpText = text
    element.description = text
    if element.setTooltip ~= nil then
        element:setTooltip(text)
    end
    if element.setToolTip ~= nil then
        element:setToolTip(text)
    end
    if element.setHelpText ~= nil then
        element:setHelpText(text)
    end
    if element.setDescription ~= nil then
        element:setDescription(text)
    end
end

function DynamicMarketSettings:getDescriptionText()
    if g_i18n ~= nil then
        return g_i18n:getText("dm_setting_pricebase_desc")
    end
    return ""
end

function DynamicMarketSettings:setNativeOptionTooltip(option, text)
    if option == nil then
        return
    end

    local function setIfText(element)
        if element ~= nil and element.setText ~= nil and element.typeName == "Text" then
            if element ~= option.labelElement and element ~= option.textElement then
                element:setText(text)
                return true
            end
        end
        return false
    end

    if option.elements ~= nil then
        if setIfText(option.elements[1]) then
            return
        end

        for _, child in pairs(option.elements) do
            if setIfText(child) then
                return
            end
        end
    end
end

function DynamicMarketSettings:updateSettingsDescriptionText()
    self:setNativeOptionTooltip(self.priceBaseOption, self:getDescriptionText())
end

function DynamicMarketSettings:getIsPriceBaseFocused()
    if self.priceBaseOption == nil then
        return false
    end
    if self.priceBaseOption.getIsFocused ~= nil then
        local ok, focused = pcall(self.priceBaseOption.getIsFocused, self.priceBaseOption)
        if ok and focused == true then
            return true
        end
    end
    if self.priceBaseOption.focused == true or self.priceBaseOption.focusActive == true then
        return true
    end
    if FocusManager ~= nil and FocusManager.currentFocusData ~= nil then
        return FocusManager.currentFocusData.focusElement == self.priceBaseOption
    end
    return false
end

function DynamicMarketSettings:onPriceBaseFocus()
    self:updateSettingsDescriptionText()
end

function DynamicMarketSettings:refreshFocusHandling(element)
    if element ~= nil and element.reloadFocusHandling ~= nil then
        element:reloadFocusHandling(true)
    end
end

function DynamicMarketSettings:resetFocusData(element)
    if element == nil then
        return
    end

    element.focusId = nil
    element.focusChangeData = {}
    element.focusActive = false
    element.isAlwaysFocusedOnOpen = false

    if element.elements ~= nil then
        for _, child in pairs(element.elements) do
            self:resetFocusData(child)
        end
    end
end

function DynamicMarketSettings:registerFocusData(element)
    if element == nil or FocusManager == nil or FocusManager.loadElementFromCustomValues == nil then
        return false
    end

    return FocusManager:loadElementFromCustomValues(element, nil, {}, false, false)
end

function DynamicMarketSettings:setOptionTexts(option)
    if option == nil then
        return
    end

    if option.setLabel ~= nil then
        option:setLabel(g_i18n:getText("dm_setting_pricebase_title"))
    end
    if option.setTexts ~= nil then
        option:setTexts({g_i18n:getText("dm_setting_pricebase_normal"), g_i18n:getText("dm_setting_pricebase_year")})
    end
    if option.setState ~= nil then
        option:setState(self.mode)
    end
    self:setTooltipText(option, g_i18n:getText("dm_setting_pricebase_desc"))
end

function DynamicMarketSettings:getStateFromCallback(a, b, c)
    if type(a) == "number" then
        return a
    end
    if type(b) == "number" then
        return b
    end
    if type(c) == "number" then
        return c
    end
    if self.priceBaseOption ~= nil and self.priceBaseOption.getState ~= nil then
        return self.priceBaseOption:getState()
    end
    return self.mode
end

function DynamicMarketSettings:onClickPriceBase(a, b, c)
    self.mode = self:normalizeMode(self:getStateFromCallback(a, b, c))
    self:applyToModule(true)
    self:setOptionTexts(self.priceBaseOption)
    self:onPriceBaseFocus()
end

function DynamicMarketSettings:prepareSettingsRow(row)
    if row == nil then
        return false
    end

    self:resetFocusData(row)

    local description = self:getDescriptionText()

    local function prepareChild(element)
        if element == nil then
            return
        end
        element.id = nil
        self:setTooltipText(element, description)
        element.onFocusCallback = function()
            self:onPriceBaseFocus()
        end
        element.onHighlightCallback = function()
            self:onPriceBaseFocus()
        end
        if element.elements ~= nil then
            for _, child in pairs(element.elements) do
                prepareChild(child)
            end
        end
    end

    row.id = nil
    row.name = "dmPriceBaseRow"
    row.onFocusCallback = function()
        self:onPriceBaseFocus()
    end
    row.onHighlightCallback = function()
        self:onPriceBaseFocus()
    end
    self.settingsRow = row
    self:setTooltipText(row, description)

    if row.elements ~= nil then
        for _, element in pairs(row.elements) do
            prepareChild(element)
            if element.typeName == "Text" and element.setText ~= nil then
                element:setText(g_i18n:getText("dm_setting_pricebase_title"))
            end
        end
    end

    local option = self:findElementRecursive(row, function(element)
        return self:isMultiTextOptionElement(element)
    end)

    if option == nil then
        return false
    end

    option.id = "dmPriceBase"
    option.name = "dmPriceBase"
    option.handleFocus = true
    if option.setHandleFocus ~= nil then
        option:setHandleFocus(true)
    end
    if option.setCanChangeState ~= nil then
        option:setCanChangeState(true)
    else
        option.canChangeState = true
    end
    option.isAlwaysFocusedOnOpen = false
    option.focused = false
    option.onFocusCallback = function()
        self:onPriceBaseFocus()
    end
    option.onHighlightCallback = function()
        self:onPriceBaseFocus()
    end
    option.onClickCallback = function(a, b, c)
        if FocusManager ~= nil then
            FocusManager:setFocus(option)
        end
        self:onPriceBaseFocus()
        self:onClickPriceBase(a, b, c)
    end
    self.priceBaseOption = option
    self:setOptionTexts(option)
    self:refreshFocusHandling(row)
    self:refreshFocusHandling(option)
    return true
end

function DynamicMarketSettings:initializeSettingsOption()
    if self.settingsInitialized == true then
        return true
    end

    local layout = self:getGameSettingsLayout()
    if layout == nil or layout.elements == nil then
        return false
    end

    local headerTemplate, rowTemplate = self:getTemplates(layout)
    if headerTemplate == nil or rowTemplate == nil or headerTemplate.clone == nil or rowTemplate.clone == nil then
        return false
    end

    local header = headerTemplate:clone(layout)
    header:setText(g_i18n:getText("dm_settings_header"))
    self.settingsHeader = header

    local row = rowTemplate:clone(layout)
    if not self:prepareSettingsRow(row) then
        return false
    end

    self.settingsInitialized = true
    if layout.invalidateLayout ~= nil then
        layout:invalidateLayout()
    end

    self:registerFocusData(header)
    self:registerFocusData(row)

    if FocusManager ~= nil and FocusManager.setGui ~= nil and g_inGameMenu ~= nil then
        FocusManager:setGui(g_inGameMenu)
    end

    self:refreshFocusHandling(layout)
    self:refreshFocusHandling(row)
    self:refreshFocusHandling(self.priceBaseOption)
    self:updateSettingsFrame()
    return true
end

function DynamicMarketSettings:updateSettingsFrame()
    self:loadSettings()
    self:applyToModule(false)
    self:setOptionTexts(self.priceBaseOption)

    if self.settingsHeader ~= nil then
        self.settingsHeader:setVisible(true)
    end
    if self.settingsRow ~= nil then
        self.settingsRow:setVisible(true)
    end
    self:refreshFocusHandling(self.settingsRow)
    self:refreshFocusHandling(self.priceBaseOption)
end

function DynamicMarketSettings:onSettingsFrameUpdate(dt)
    if self:getIsPriceBaseFocused() then
        self:updateSettingsDescriptionText()
    end
end

function DynamicMarketSettings:onSettingsFrameOpen()
    if self.settingsInitialized ~= true then
        self:initializeSettingsOption()
    end
    self:updateSettingsFrame()
end

local function replace(template, replacements)
  for k, v in pairs(replacements) do template = template:gsub("$"..k, v) end
  return template
end
local function write(filename, string)
  assert(io.open(filename, "w+")):write(string):close()
end

local template_smithing = [[{
  "type": "minecraft:smithing_transform",
  "template": "phantom_membrane",
  "base": "$ITEM",
  "result": {
    "id": "$ITEM",
    "components": {
      "equippable": {
        "slot": "$SLOT",
        "asset_id": "phantom_armor:nothing",
        "equip_sound": "$SOUND"
      },
      "stored_enchantments": {
        "phantom_armor:phantom_touched": 1
      }
    }
  }
}]]
local template_modifier = [[{
  "function": "sequence",
  "functions": [
    {
      "function": "set_components",
      "components": {
        "equippable": {
          "slot": "$SLOT",
          "asset_id": "$ASSET_ID",
          "equip_sound": "$SOUND"
        }
      }
    },
    {
      "function": "set_enchantments",
      "enchantments": {
        "phantom_armor:phantom_touched": $ENCHANTMENT_ENABLED,
        "phantom_armor:phantom_touched_disabled": $ENCHANTMENT_DISABLED
      }
    }
  ]
}]]

-- function to make armor visible when being damaged
local show_function = {"scoreboard players operation @s phantom_armor = $cooldown phantom_armor"}

-- function to make armor invisible again after the timer expires
local hide_function = {}

for _, data in ipairs{
  {"leather_helmet","head","leather"}, {"leather_chestplate","chest","leather"}, {"leather_leggings","legs","leather"}, {"leather_boots","feet","leather"},
  {"chainmail_helmet","head","chain"}, {"chainmail_chestplate","chest","chain"}, {"chainmail_leggings","legs","chain"}, {"chainmail_boots","feet","chain"},
  {"iron_helmet","head","iron"}, {"iron_chestplate","chest","iron"}, {"iron_leggings","legs","iron"}, {"iron_boots","feet","iron"},
  {"golden_helmet","head","gold"}, {"golden_chestplate","chest","gold"}, {"golden_leggings","legs","gold"}, {"golden_boots","feet","gold"},
  {"diamond_helmet","head","diamond"}, {"diamond_chestplate","chest","diamond"}, {"diamond_leggings","legs","diamond"}, {"diamond_boots","feet","diamond"},
  {"netherite_helmet","head","netherite"}, {"netherite_chestplate","chest","netherite"}, {"netherite_leggings","legs","netherite"}, {"netherite_boots","feet","netherite"},
  {"elytra","chest","elytra"},
  {"turtle_helmet","head","turtle"}
} do
  local item, slot, asset_id = table.unpack(data)
  local sound = "minecraft:item.armor.equip_"..asset_id

  -- smithing recipe
  write("data/phantom_armor/recipe/"..item..".json", replace(template_smithing, {
    ITEM = item,
    SLOT = slot,
    SOUND = sound
  }))

  -- item modifiers to restore default appearance
  write("data/phantom_armor/item_modifier/disable_"..item..".json", replace(template_modifier, {
    SLOT = slot,
    ASSET_ID = "minecraft:"..asset_id.. (asset_id == "turtle" and "_scute" or ""),
    SOUND = sound,
    ENCHANTMENT_ENABLED = 0,
    ENCHANTMENT_DISABLED = 1
  }))

  -- item modifiers to hide while preserving equip sound
  write("data/phantom_armor/item_modifier/enable_"..item..".json", replace(template_modifier, {
    SLOT = slot,
    ASSET_ID = "phantom_armor:nothing",
    SOUND = sound,
    ENCHANTMENT_ENABLED = 1,
    ENCHANTMENT_DISABLED = 0
  }))

  -- add line to functions
  table.insert(show_function, replace([=[execute if items entity @s armor.$SLOT $ITEM[enchantments~[{enchantments:"phantom_armor:phantom_touched"}]] run item modify entity @s armor.$SLOT phantom_armor:disable_$ITEM]=],
    {ITEM = item, SLOT = slot}))
  table.insert(hide_function, replace([=[execute if items entity @s armor.$SLOT $ITEM[enchantments~[{enchantments:"phantom_armor:phantom_touched_disabled"}]] run item modify entity @s armor.$SLOT phantom_armor:enable_$ITEM]=],
    {ITEM = item, SLOT = slot}))
end

write("data/phantom_armor/function/show_armor.mcfunction", table.concat(show_function, "\n"))
write("data/phantom_armor/function/hide_armor.mcfunction", table.concat(hide_function, "\n"))

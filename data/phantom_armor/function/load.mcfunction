scoreboard objectives add phantom_armor dummy
execute unless score $version phantom_armor matches 1 run tellraw @a {"text":"Phantom Armor (v1.0) is installed!", "color":"green"}
execute unless score $version phantom_armor matches 1 run tellraw @a ["This datapack is licensed under the ",{"text":"Mozilla Public License, v. 2.0","underlined":true,"color":"blue","clickEvent":{"action":"open_url","value":"http://mozilla.org/MPL/2.0/"},"hoverEvent":{"action":"show_text","contents":["http://mozilla.org/MPL/2.0/"]}},"."]
execute unless score $version phantom_armor matches 1 run tellraw @a ["The Source Code Form is available at ",{"text":"Penguin-Spy/phantom_armor","underlined":true,"color":"blue","clickEvent":{"action":"open_url","value":"https://github.com/Penguin-Spy/phantom_armor"},"hoverEvent":{"action":"show_text","contents":["https://github.com/Penguin-Spy/phantom_armor"]}},"."]
execute unless score $version phantom_armor matches 1 run tellraw @a ["Use ",{"text":"/function phantom_armor:settings","color":"gray","clickEvent":{"action":"run_command","value":"/function phantom_armor:settings"},"hoverEvent":{"action":"show_text","contents":["Click to run"]}}," to configure the datapack."]
scoreboard players set $version phantom_armor 1

execute unless score $damage phantom_armor matches 0..2 run scoreboard players set $damage phantom_armor 1
execute unless score $cooldown phantom_armor matches 1.. run scoreboard players set $cooldown phantom_armor 10
execute unless score $invisibility phantom_armor matches 0..1 run scoreboard players set $invisibility phantom_armor 1

schedule clear phantom_armor:second
function phantom_armor:second
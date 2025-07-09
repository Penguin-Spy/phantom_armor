scoreboard objectives add phantom_touched dummy
execute unless score $version phantom_touched matches 1 run tellraw @a {"text":"Phantom Touched (v1.1) is installed!", "color":"green"}
execute unless score $version phantom_touched matches 1 run tellraw @a ["This datapack is licensed under the ",{"text":"Mozilla Public License, v. 2.0","underlined":true,"color":"blue","click_event":{"action":"open_url","url":"http://mozilla.org/MPL/2.0/"},"hover_event":{"action":"show_text","value":"http://mozilla.org/MPL/2.0/"}},"."]
execute unless score $version phantom_touched matches 1 run tellraw @a ["The Source Code Form is available at ",{"text":"Penguin-Spy/phantom_touched","underlined":true,"color":"blue","click_event":{"action":"open_url","url":"https://github.com/Penguin-Spy/phantom_touched"},"hover_event":{"action":"show_text","value":"https://github.com/Penguin-Spy/phantom_touched"}},"."]
execute unless score $version phantom_touched matches 1 run tellraw @a ["Use ",{"text":"/function phantom_touched:settings","color":"gray","click_event":{"action":"run_command","command":"/function phantom_touched:settings"},"hover_event":{"action":"show_text","value":"Click to run"}}," to configure the datapack."]
scoreboard players set $version phantom_touched 1

execute unless score $damage phantom_touched matches 0..2 run scoreboard players set $damage phantom_touched 1
execute unless score $cooldown phantom_touched matches 1.. run scoreboard players set $cooldown phantom_touched 10
execute unless score $invisibility phantom_touched matches 0..1 run scoreboard players set $invisibility phantom_touched 1

schedule clear phantom_touched:second
function phantom_touched:second
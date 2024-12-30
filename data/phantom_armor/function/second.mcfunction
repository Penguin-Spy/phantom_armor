scoreboard players remove @a[scores={phantom_armor=0..}] phantom_armor 1
execute as @a[scores={phantom_armor=0}] run function phantom_armor:hide_armor

execute if score $invisibility phantom_armor matches 1 as @a[predicate=phantom_armor:has_invisibility] run function phantom_armor:show_armor

schedule function phantom_armor:second 1s
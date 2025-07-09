scoreboard players remove @a[scores={phantom_touched=1..}] phantom_touched 1
execute as @a[scores={phantom_touched=0}] run function phantom_touched:hide_armor
execute if score $invisibility phantom_touched matches 1 as @a[predicate=phantom_touched:has_invisibility] run function phantom_touched:show_armor
execute as @a run function phantom_touched:move_enchantment
schedule function phantom_touched:second 1s
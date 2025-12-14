return {
    spritePath = "assets/sprites/wooden_pickaxe.png",
    name = "Wooden Pickaxe",
    type = "useable",

    data = {
        breakingDamage = 20,
        breakingPower = 20,

        swingCooldown = 2,
        swingSpeed = .7
    },

    useAnimation = {
        {setTime = 0.0, rotation = 0, x = 0, y = 0},
        {setTime = 0.2, rotation = 60, x = 15, y = 0},
        {setTime = 0.4, rotation = 40, x = 0, y = -20},
        {setTime = 0.6, rotation = -120, x = -15, y = 20},
        {setTime = 0.7, rotation = -120, x = 0, y = 0},
        {setTime = 1.0, rotation = 0, x = 0, y = 0},
    }
}
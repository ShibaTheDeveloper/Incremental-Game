-- ~/code/data/boxes.lua

local RenderModule = require("code.engine.render")

local function HSVtoRGB(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return RenderModule:createColor(math.floor(r*255), math.floor(g*255), math.floor(b*255))
end

return {
    {
        spritePath = "assets/sprites/boxes/box1.png",

        description = "C'mon, it's Gerald! Do I really need to describe him? He's perfect!",
        quote = "Gerald.",
        name = "Gerald",

        mergeReward = 0,

        weight = 40,
        scale = .7,
        tier = 1,
    },
    {
        spritePath = "assets/sprites/boxes/box2.png",

        description = "Jimbo is constantly shocked at everything, constantly horrified of what'll happen next.",
        quote = "WHAT??",
        name = "Jimbo",

        mergeReward = 5,

        weight = 50,
        scale = .8,
        tier = 2,
    },
    {
        spritePath = "assets/sprites/boxes/box3.png",

        description = "Glumbo's constantly planning on taking over the world, but that'll never happen because he's telling his plans to everyone. He's the reason for his brother Jimbo's constant shock.",
        quote = "And that's how I'll take over the world!",
        name = "Glumbo",

        mergeReward = 10,

        weight = 55,
        scale = .9,
        tier = 3,
    },
    {
        spritePath = "assets/sprites/boxes/box4.png",

        description = "Jeremy loves to remind the teacher about the homework. Nobody likes Jeremy.",
        quote = "Ermm.. actually..! ☝️🤓",
        name = "Jeremy",

        mergeReward = 15,

        weight = 120,
        scale = 1,
        tier = 4,
    },
    {
        spritePath = "assets/sprites/boxes/box5.png",

        description = "An overweight box that most definitely ate that cookie.",
        quote = "I didn't eat that cookie!",
        name = "Muncher",

        mergeReward = 50,

        screenFlashFadeDuration = 1.2,
        flashScreen = true,

        mergeSoundData = {soundPath = "assets/sounds/merge/special.wav"},

        weight = 250,
        scale = 1.1,
        tier = 5,
    },
    {
        spritePath = "assets/sprites/boxes/box6.png",

        description = [[Dylan loves clothes shopping at "Cold Subject". He isn't very talkative.]],
        quote = "...",
        name = "Dylan",

        mergeReward = 55,

        weight = 255,
        scale = 1.2,
        tier = 6,
    },
    {
        spritePath = "assets/sprites/boxes/box7.png",

        description = "A really enthusiastic box, loves bothering people. Annoying.",
        quote = "HEY!!!",
        name = "Carlos",

        mergeReward = 60,

        weight = 270,
        scale = 1.3,
        tier = 7,
    },
    {
        spritePath = "assets/sprites/boxes/box8.png",

        description = "This goofy goober of a box loves sticking out his tongue! A very silly creature indeed.",
        quote = "Blehhhh!",
        name = "Goobster Goobington III",

        mergeReward = 65,

        weight = 300,
        scale = 1.4,
        tier = 8,
    },
    {
        spritePath = "assets/sprites/boxes/box9.png",

        description = "Goodness gracious!! Is this thing okay!?!? It's eyes are bloodshot!!",
        quote = "YASS QWEEN 💅💅 WE'RE GETTING SOME GEMINI ENERGY! SLAYY! 💅💅💅",
        name = "Angel",

        mergeReward = 70,

        weight = 345,
        scale = 1.5,
        tier = 9,
    },
    {
        spritePath = "assets/sprites/boxes/box10.png",

        description = [[An extremely cool cube, who apparantly has terrible parents. Who in their right mind would name their child "Frigid Wendyhot"? Also, who shaved off his other eyebrow?]],
        quote = "Sup, twin?",
        name = "Frigid Wendyhot",

        mergeReward = 100,

        screenFlashFadeDuration = 1.2,
        flashScreen = true,

        mergeSoundData = {soundPath = "assets/sounds/merge/special.wav"},

        weight = 370,
        scale = 1.58,
        tier = 10,
    },
    {
        spritePath = "assets/sprites/boxes/box11.png",

        description = "A dizzy cube which bears a striking resemblance to the creator of the game.",
        quote = "Whuh? wha-?",
        name = "Dizzy",

        mergeReward = 110,

        weight = 430,
        scale = 1.66,
        tier = 11,
    },
    {
        spritePath = "assets/sprites/boxes/box12.png",

        description = "A granite-man transformed into a box. He's the creator of the faces you see on the boxes.",
        quote = "ROCK NOISES!!!",
        name = "Gochged",

        mergeReward = 120,

        weight = 600,
        scale = .85,
        tier = 12,
    },
    {
        spritePath = "assets/sprites/boxes/box13.png",

        description = "A box that grew so big, it became classifiable as a mountain! Going past this point may not be wise.. He looks a little funny tho.",
        quote = "Big back, big back! Big back, big back! Yeah, my back is loaded up with snacks and different foods!",
        name = "Mt. Box",

        mergeReward = 130,

        weight = 500,
        scale = 1.8,
        tier = 13,
    },
    {
        spritePath = "assets/sprites/boxes/box14.png",

        description = "This box is so massive that it became red-hot from the outside! Being able to fuse so much matter into one point is inhuman.",
        quote = "RAAAAAAAAAHHH!!!",
        name = "Unstable",

        mergeReward = 140,

        reflectionPath = "assets/sprites/reflections/box14.png",
        reflective = true,

        weight = 750,
        scale = 1.865,
        tier = 14,
    },
    {
        spritePath = "assets/sprites/boxes/box15.png",

        description = "A box that has been enlightened with the knowledge of everything, even the fact that it's in a game! It has become mute and un-reactive, as it is trying to process everything at once.",
        quote = "...",
        name = "Transcended",

        mergeReward = 222,

        --screenFlashColor = RenderModule:createColor(255, 255, 255, 1),
        --screenFlashFadeDuration = 2.25,
        --flashScreen = true,

        --mergeSoundData = {soundPath = "assets/sounds/merge/box15.wav"},

        screenFlashFadeDuration = 1.2,
        flashScreen = true,

        mergeSoundData = {soundPath = "assets/sounds/merge/special.wav"},

        weight = 1000,
        scale = 1.95,
        tier = 15,
    },
    {
        spritePath = "assets/sprites/boxes/box16.png",

        description = "A mesmerizing box which is hard to look at. You have fused so much matter into one being, that it is starting to spill.",
        quote = "ZXZlcnl0aGluZw==",
        name = "Omnibox",

        mergeReward = 333,

        --screenFlashColor = RenderModule:createColor(255, 255, 255, 1),
        --screenFlashFadeDuration = 2.25,
        --flashScreen = true,

        onUpdateCosmetic = function(element)
            local hue = (os.clock() % 5) / 5
            element.color = HSVtoRGB(hue, 1, 1)
        end,

        --mergeSoundData = {soundPath = "assets/sounds/merge/box16.wav"},

        weight = 1100,
        scale = 2,
        tier = 16,
    },
    {
        spritePath = "assets/sprites/boxes/box17.png",

        description = "A sinister and unstable box. It has become so big that it's weight is in the negatives.",
        quote = "MUAHAHAHAHA!",
        name = "Devoided",

        mergeReward = 444,

        --screenFlashColor = RenderModule:createColor(43, 43, 255, 1),
        --screenFlashFadeDuration = 2.25,
        --flashScreen = true,

        reflectionPath = "assets/sprites/reflections/box17.png",
        reflective = true,

        --mergeSoundData = {soundPath = "assets/sounds/merge/box17.wav"},

        weight = -60,
        scale = 2.05,
        tier = 17,
    },
    {
        spritePath = "assets/sprites/boxes/box18.png",

        description = "Quite a playful box that likes to mess around with it's shapeshifting ability. Will occasionally shapeshift into the lower-tier boxes while still being counted as the same tier.",
        quote = "Hide and seek! will you find me?",
        name = "Box o' Matter",

        mergeReward = 555,

        --screenFlashFadeDuration = 2.25,
        --flashScreen = true,

        --mergeSoundData = {soundPath = "assets/sounds/merge/box18.wav"},

        weight = 1300,
        scale = 2.15,
        tier = 18,
    },
}
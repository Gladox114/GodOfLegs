-- This file Downloads all files from github https://github.com/Gladox114/ExcavatingLikeMaster

-- create a list full of files (excavate.lua, invCheck.lua, ...)
local folder = "GodOfLegs"
local files = {
  "invCheck.lua",
  "movement.lua",
  "fuelCheck.lua",
  "torch.lua",
  "gotoGPS.lua",
  "excavate.lua",
  "vectorCalc.lua",
  "getDirection.lua",
  "veinMining.lua",
  "home.lua"
}


-- use wget and github raw page to download each file

shell.run("mkdir " .. folder)

for i = 1, #files do
  shell.run("wget https://raw.githubusercontent.com/Gladox114/" .. folder .. "/master/" ..
    files[i] .. " " .. folder .. "/" .. files[i])
end

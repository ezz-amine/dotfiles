return function(prefix)
  prefix = prefix or ""
  local all_jokes = {
    "COFFEE STILL BREWING",
    "YESTERDAY'S BREW STILL NOT FULLY EXTRACTING",
    "PATIENCE IS A VIRTUE, ESPECIALLY WITH COLD BREW",
    "SLOW DROP = STRONG SIP",
    "BREWING TIME: LONGER THAN A TOLKIEN NOVEL",
    "COLD BREW IS JUST COFFEE TEA",
    "WAITING MAKES THE BEANS HAPPIER",
    "IT'S NOT STALLING, IT'S OPTIMIZING FLAVOR",
    "BREWING AT THE SPEED OF MOLASSES",
    "COFFEE ISN'T READY, BUT YOUR PATIENCE IS",
    "THE BEANS ARE STILL WHISPERING TO THE WATER",
    "COLD BREW: WHERE TIME BECOMES IRRELEVANT",
    "THIS ISN'T A DELAY, IT'S A FEATURE",
    "BREWING FASTER WOULD BE SACRILEGE",
    "COFFEE ALGORITHM: WAIT → ENJOY",
    "THIS BREW IS TRAVELING THROUGH TIME",
    "IT'S NOT LAZY, IT'S ENERGY-EFFICIENT",
    "THE CHEMISTRY NEEDS MORE TIME TO GOSSIP",
    "COFFEE IS PRACTICING MINDFULNESS",
    "BREWING FASTER WOULD REQUIRE A TIME MACHINE",
    "COLD BREW: THE SNAIL OF COFFEE",
    "THIS ISN'T SLOW, IT'S ARTISANAL",
    "THE WATER IS STILL MAKING FRIENDS WITH THE BEANS",
    "BREWING AT THE SPEED OF A GLACIER",
    "COFFEE IS MARINATING IN YOUR FUTURE JOY",
    "THE GRIND NEVER STOPS (BUT THE BREW DOES)",
    "COLD BREW: BECAUSE INSTANT COFFEE IS A LIE",
    "IT'S NOT DONE YET, BUT NEITHER ARE YOU",
    "THE BREW IS STILL COLLECTING ITS THOUGHTS",
    "COFFEE IS TEACHING YOU DELAYED GRATIFICATION",
    "THIS ISN'T WAITING, IT'S ANTICIPATION",
    "THE BEANS ARE STILL WRITING THEIR MEMOIRE",
    "COLD BREW: THE MOST PATIENT COFFEE",
    "BREWING FASTER WOULD BE RUDE",
    "THE CHEMISTRY LAB REPORT ISN'T READY YET",
    "COFFEE IS STILL TRAVELING THROUGH THE FILTER",
    "THIS BREW IS A TEST OF CHARACTER",
    "COLD BREW: BECAUSE GOOD THINGS TAKE TIME",
    "THE WATER IS STILL LEARNING THE BEANS' LANGUAGE",
    "DOWNLOADING MORE FLAVOR",
    "THIS BREW IS A SLOGAN FOR PATIENCE",
    "COLD BREW: THE COFFEE EQUIVALENT OF FERMENTATION",
    "THE BREW IS STILL COMPOSING ITS SYMPHONY",
    "IT'S NOT READY, BUT NEITHER IS YOUR SCHEDULE",
  }

  -- Randomly select one joke and concatenate with "Just wait... "
  math.randomseed(os.time()) -- Seed randomness
  return all_jokes[math.random(#all_jokes)] .. ". " .. prefix
end

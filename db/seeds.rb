cook = Captain.create(name: "Captain Cook", admiral: true)
kidd = Captain.create(name: "Captain Kidd", admiral: true)
william = Captain.create(name: "William Kyd", admiral: false)
arel = Captain.create(name: "Arel English", admiral: true)
henry = Captain.create(name: "Henry Hudson", admiral: false)
samuel = Captain.create(name: "Samuel Axe", admiral: false)

h_28 = Boat.create(name: "H 28", length: 27)
nacra_17 = Boat.create(name: "Nacra 17", length: 17)
regulator = Boat.create(name: "Regulator 34SS", length: 34)
zodiac = Boat.create(name: "Zodiac CZ7", length: 24)
boston_whaler = Boat.create(name: "Boston Whaler", length: 13)
forty_niner = Boat.create(name: "49er", length: 16)
cape_dory = Boat.create(name: "Cape Dory", length: 28)
laser = Boat.create(name: "Laser", length: 14)
triton = Boat.create(name: "Triton 21 TRX", length: 21)
sun_tracker = Boat.create(name: "Sun Tracker Regency 254 XP3", length: 27)
harpoon = Boat.create(name: "Harpoon 4.7", length: 15.5)
sunfish = Boat.create(name: "Sunfish", length: 13.7)

h_28.captain = cook
nacra_17.captain = kidd
regulator.captain = william
zodiac.captain = arel
boston_whaler.captain = henry
forty_niner.captain = samuel
cape_dory.captain = cook
laser.captain = cook
triton.captain = arel
sun_tracker.captain = samuel

h_28.save
nacra_17.save
regulator.save
zodiac.save
boston_whaler.save
forty_niner.save
cape_dory.save
laser.save
triton.save
sun_tracker.save

ketch = Classification.create(name: "Ketch")
sailboat = Classification.create(name: "Sailboat")
catamaran = Classification.create(name: "Catamaran")
sloop = Classification.create(name: "Sloop")
motorboat = Classification.create(name: "Motorboat")
center = Classification.create(name: "Center Console")
rib = Classification.create(name: "RIB")
trawler = Classification.create(name: "Trawler")
cat_rig = Classification.create(name: "Cat Rig Boat")
bass = Classification.create(name: "Bass Boat")
pontoon = Classification.create(name: "Pontoon Boat")

h_28.classifications << [ketch, sailboat]
nacra_17.classifications << [catamaran, sloop, sailboat]
regulator.classifications << [motorboat, center]
zodiac.classifications << [rib, motorboat, center]
boston_whaler.classifications << [motorboat]
forty_niner.classifications << [sailboat, sloop]
cape_dory.classifications << [motorboat, trawler]
laser.classifications << [sailboat, cat_rig]
triton.classifications << [motorboat, bass]
sun_tracker.classifications << [motorboat, pontoon, catamaran]
harpoon.classifications << [sailboat, sloop]
sunfish.classifications << [sailboat, cat_rig]

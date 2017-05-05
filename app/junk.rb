SELECT DISTINCT boats.* FROM boats
INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
INNER JOIN boat_classifications boat_classifications_boats_join
    ON boat_classifications_boats_join.boat_id = boats.id
INNER JOIN classifications
    ON classifications.id = boat_classifications_boats_join.classification_id
WHERE classifications.name = ?  [[name, Sailboat]]

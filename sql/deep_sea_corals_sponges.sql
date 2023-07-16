USE ocean;

-- How many types (Category) of organisms are there?
SELECT VernacularNameCategory, COUNT(*) AS count
FROM deep_sea_corals
WHERE VernacularNameCategory IS NOT NULL
GROUP BY VernacularNameCategory
ORDER BY count DESC;
# in this dataset contains data of different types of corals, sponges and fish


-- What are the methods of record used to collect data?
SELECT RecordType, COUNT(*) AS count
FROM deep_sea_corals
WHERE RecordType IS NOT NULL
GROUP BY RecordType
ORDER BY count DESC;
# There are 14 different record type. Half of the records were video observation


-- What equipment are used to collect data?
SELECT SamplingEquipment, COUNT(*) AS count
FROM deep_sea_corals
WHERE SamplingEquipment IS NOT NULL
GROUP BY SamplingEquipment
ORDER BY count DESC;
# Half of the samples were collected using Remotely Operated Vehicle (ROV)


-- How deep is the deepest spot in this dataset?
SELECT DepthInMeters
FROM deep_sea_corals
ORDER BY DepthInMeters DESC
LIMIT 1;
# 6369 meters


-- How many lives are there in the deepest spot?
SELECT ScientificName, TaxonRank, VernacularNameCategory, DepthInMeters, COUNT(*) AS count
FROM deep_sea_corals
WHERE DepthInMeters IS NOT NULL AND DepthInMeters = (
	SELECT DepthInMeters
	FROM deep_sea_corals
	ORDER BY DepthInMeters DESC
	LIMIT 1
)
GROUP BY DepthInMeters, ScientificName, TaxonRank, VernacularNameCategory
ORDER BY DepthInMeters ASC;
# There was only 1 record of life at the depth of 6369 meters >> Genus Umbellula (category: sea pen)


-- How many organisms are living under the depth 6000 meters and what are they?
SELECT ScientificName, TaxonRank, VernacularNameCategory, DepthInMeters, COUNT(*) AS count
FROM deep_sea_corals
WHERE DepthInMeters IS NOT NULL AND DepthInMeters > 6000
GROUP BY DepthInMeters, ScientificName, TaxonRank, VernacularNameCategory;
# Found only sea pen under this depth >> Genus Umbellula


-- Show organisms at the depth between 3000-5000 meters
SELECT ScientificName, TaxonRank, VernacularNameCategory, DepthInMeters, COUNT(*) AS count
FROM deep_sea_corals
WHERE DepthInMeters IS NOT NULL AND DepthInMeters BETWEEN 3000 AND 5000
GROUP BY ScientificName, TaxonRank, VernacularNameCategory, DepthInMeters
ORDER BY DepthInMeters DESC;


-- Who are the providers to this dataset?
SELECT DataProvider, COUNT(*) AS count
FROM deep_sea_corals
WHERE DataProvider IS NOT NULL
GROUP BY DataProvider
ORDER BY count DESC
;

-- Where and when was the data collected?
SELECT Locality, ObservationDate
FROM deep_sea_corals
WHERE Locality IS NOT NULL
GROUP BY Locality, ObservationDate
ORDER BY ObservationDate DESC;


-- Show the first record of this dataset, show how deep and what's in there and how it was recored
SELECT TaxonRank, 
	ScientificName, 
    VernacularNameCategory, 
	DepthInMeters, 
    SamplingEquipment, 
    RecordType, 
    ObservationDate
FROM deep_sea_corals
WHERE ObservationDate IS NOT NULL
ORDER BY ObservationDate ASC
LIMIT 1;
# Species Spongia (Spongia) zimocca (demosponge) at 23 meters depth, record type: specimen, date:1833-01-01


-- Show the newest record in this dataset, show how deep and what's in there and how it was recored
SELECT 
	TaxonRank, 
	ScientificName, 
    VernacularNameCategory, 
	DepthInMeters, 
    SamplingEquipment, 
    RecordType, 
    ObservationDate
FROM deep_sea_corals
ORDER BY ObservationDate DESC
LIMIT 1;
# Phylum Porifera (sponge) at 181 meters depth, record type: video, date:2022-09-07



-- What are the most sampling equipment used to collect data in year 2022?
SELECT SamplingEquipment, ObservationDate
FROM deep_sea_corals
WHERE ObservationDate LIKE '2022%'
GROUP BY SamplingEquipment, ObservationDate
ORDER BY ObservationDate DESC;
# Only ROV was used to collect data in the year 2022
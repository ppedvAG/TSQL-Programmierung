--Referenz
select * from sys.spatial_reference_systems

--zb ist folgendes nicht supported
select geography::STGeomFromText('LINESTRING(-122.360 47.656, -122.343 47.656)',0)

IF OBJECT_ID ( 'dbo.SpatialTable', 'U' ) IS NOT NULL   
    DROP TABLE dbo.SpatialTable;  
GO  

CREATE TABLE SpatialTable   
    ( id int IDENTITY (1,1),  
    GeogCol1 geography,   
    GeogCol2 AS GeogCol1.STAsText() );  
GO  

INSERT INTO SpatialTable (GeogCol1)  
VALUES (geography::STGeomFromText('LINESTRING(-122.360 47.656, -122.343 47.656 )', 4326));  

INSERT INTO SpatialTable (GeogCol1)  
VALUES (geography::STGeomFromText('POLYGON((-122.358 47.653 , -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326));  
GO  




DECLARE @geog1 geography;  
DECLARE @geog2 geography;  
DECLARE @result geography;  

SELECT @geog1 = GeogCol1 FROM SpatialTable WHERE id = 1;  
SELECT @geog2 = GeogCol1 FROM SpatialTable WHERE id = 2;  
SELECT @result = @geog1.STIntersection(@geog2);  
SELECT @result.STAsText();




----------------------------------
CREATE TABLE [dbo].[Landmark] (
    [ID]                INT IDENTITY(1, 1),
    [LandmarkName]      VARCHAR(100),
    [Location]          VARCHAR(50),
    [Latitude]          FLOAT,
    [Longitude]         FLOAT
)
GO

INSERT INTO [dbo].[Landmark] ( [LandmarkName], [Location], [Latitude], [Longitude] )
VALUES ( 'Statue of Liberty', 'New York, USA', 40.689168,-74.044563 ),
       ( 'Eiffel Tower', 'Paris, France', 48.858454, 2.294694),
       ( 'Leaning Tower of Pisa', 'Pisa, Italy', 43.72294, 10.396604 ),
       ( 'Great Pyramids of Giza', 'Cairo, Egypt', 29.978989, 31.134632 ),
       ( 'Sydney Opera House', 'Syndey, Australia', -33.856651, 151.214967 ),
       ( 'Taj Mahal', 'Agra, India', 27.175047, 78.042042 ),
       ( 'Colosseum', 'Rome, Italy', 41.890178, 12.492378 )
GO  


ALTER TABLE [dbo].[Landmark]
ADD [GeoLocation] GEOGRAPHY
GO

UPDATE [dbo].[Landmark]
SET [GeoLocation] = geography::STPointFromText('POINT(' + CAST([Longitude] AS VARCHAR(20)) + ' ' + 
                    CAST([Latitude] AS VARCHAR(20)) + ')', 4326)
GO

select * from Landmark


--wie weoit ist etwas von mir weg:23.012034, 72.510754.
DECLARE
@GEO1 GEOGRAPHY,
@LAT VARCHAR(10),
@LONG VARCHAR(10)

SET @LAT='48.1725613'
SET @LONG='12.8310753'


SET @geo1= geography::Point(@LAT, @LONG, 4326)

SELECT ID,LOCATION,(@geo1.STDistance(geography::Point(ISNULL(LATITUDE,0), 
ISNULL(LONGITUDE,0), 4326))) as DISTANCE  FROM Landmark

--in km
SELECT ID,LOCATION,LEFT(CONVERT(VARCHAR,
(@geo1.STDistance(geography::Point(ISNULL(LATITUDE,0), 
ISNULL(LONGITUDE,0), 4326))/1000)),5)+' Km' as DISTANCE FROM LANDMARK


--Innerhalb eines Umkreises+
DECLARE
@GEO1 GEOGRAPHY,
@LAT VARCHAR(10),
@LONG VARCHAR(10)


SET @LAT='48.1725613'
SET @LONG='12.8310753'

SET @geo1= geography::Point(@LAT, @LONG, 4326)

SELECT ID,LOCATION,
	LEFT(CONVERT(VARCHAR,
						(@geo1.STDistance(geography::Point(ISNULL(LATITUDE,0), 
	ISNULL(LONGITUDE,0), 4326)))/1000),5)+' Km' 
as DISTANCE 
from LANDMARK
	WHERE (@geo1.STDistance(geography::Point(ISNULL(LATITUDE,0), 
							ISNULL(LONGITUDE,0), 4326)))/1000 < 1000
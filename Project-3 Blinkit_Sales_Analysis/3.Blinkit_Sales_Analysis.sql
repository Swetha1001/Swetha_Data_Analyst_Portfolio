--1.Select all the data 
SELECT * FROM blinkit_data;

--2.Clean inconsistent labels in Item Fat Content
UPDATE blinkit_data
SET item_Fat_Content =
CASE 
WHEN item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN item_Fat_Content = 'reg' THEN 'Regular'
ELSE item_Fat_Content
END;

--3.Check whether the data has been cleaned
SELECT DISTINCT (item_Fat_Content) 
FROM blinkit_data;

--4.Total Sales
SELECT CAST (SUM(Total_Sales)/1000000 AS DECIMAL (10,2) )AS Total_Sales_Millions
FROM blinkit_data;

--5.Average Sales
SELECT CAST (AVG(Total_Sales)AS DECIMAL(10,0)) Average_Sales 
FROM blinkit_data;

--6.Number of items
SELECT COUNT(*) AS Number_of_Items 
FROM blinkit_data;

--7.Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,1))AS Average_Rating 
FROM blinkit_data;

--8.Total Sales by Fat Content
SELECT Item_Fat_Content,  
       CAST (SUM(Total_Sales)AS DECIMAL (10,2) )AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

--9.Total Sales by Item Type
SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2))AS Total_Sales
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

--10.Fat Content by Outlet Location Type  for Total Sales
SELECT Outlet_Location_Type,
    CAST(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END)AS DECIMAL (10,2)) AS Low_Fat_Sales,
    CAST(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END)AS DECIMAL (10,2))AS Regular_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

--11.Percentage of Sales by Outlet size
SELECT 
   Outlet_Size,
    CAST (SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
    ROUND(
        (SUM(Total_Sales) * 100.0) / 
        (SELECT SUM(Total_Sales) FROM blinkit_data), 2
    ) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Sales_Percentage DESC;

--12.Sales by Outlet Location
SELECT Outlet_Location_Type,
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

--13.Highest Rated Item
SELECT *
FROM blinkit_data
WHERE Rating = (SELECT MAX(Rating) FROM blinkit_data);

--14.Top 3 Best-Selling Item Types by Total Sales
SELECT TOP 3 Item_Type, 
       CAST (SUM(Total_Sales)AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

--15.Top Item in Each Outlet Type
SELECT Outlet_Type, Item_Type, Total_Sales
FROM (
    SELECT Outlet_Type,
           Item_Type,
           CAST(SUM(Total_Sales)AS DECIMAL(10,2) )AS Total_Sales,
           ROW_NUMBER() OVER (PARTITION BY Outlet_Type ORDER BY SUM(Total_Sales) DESC) AS rn
    FROM blinkit_data
    GROUP BY Outlet_Type, Item_Type
) ranked
WHERE rn = 1;

--16.Analyze Sales Growth over years by Outlet Establishment Year
SELECT Outlet_Establishment_Year,
CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Yearly_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;

--17.Average Sales and Rating by Outlet Size
WITH outlet_summary AS (
    SELECT Outlet_Size,
       CAST(AVG(Total_Sales)AS DECIMAL (10,2))AS Average_Sales,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
    FROM blinkit_data
    GROUP BY Outlet_Size
)
SELECT * FROM outlet_summary
ORDER BY Average_Sales DESC;

--18.RANK Top 3 Item_Types by Sales per Outlet_Type
SELECT *
FROM (
    SELECT Outlet_Type,
           Item_Type,
           SUM(Total_Sales) AS Total_Sales,
           RANK() OVER (PARTITION BY Outlet_Type ORDER BY SUM(Total_Sales) DESC) AS rnk
    FROM blinkit_data
    GROUP BY Outlet_Type, Item_Type
) ranked
WHERE rnk <= 3;

--19.Total Sales by Item Visibility Range
SELECT 
    CASE 
        WHEN Item_Visibility < 0.05 THEN 'Low Visibility'
        WHEN Item_Visibility < 0.15 THEN 'Medium Visibility'
        ELSE 'High Visibility'
    END AS Visibility_Level,
    COUNT(*) AS Item_Count,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sale
FROM blinkit_data
GROUP BY 
    CASE 
        WHEN Item_Visibility < 0.05 THEN 'Low Visibility'
        WHEN Item_Visibility < 0.15 THEN 'Medium Visibility'
        ELSE 'High Visibility'
    END
ORDER BY Total_Sales DESC;

--20.All Metrics by Outlet Type
SELECT Outlet_Type,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales,
       COUNT(*) AS Number_of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
       CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
Order by Total_Sales DESC;









Use dbSQL1;
SET NOCOUNT ON;


---Drop Table Statements 
IF OBJECT_ID ('TJobMaterials')			IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID ('TJobWorkers')			IS NOT NULL DROP TABLE TJobWorkers  
IF OBJECT_ID ('TWorkerSkills')			IS NOT NULL DROP TABLE TWorkerSkills
IF OBJECT_ID ('TJobs')				IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TStatuses')			IS NOT NULL DROP TABLE TStatuses
IF OBJECT_ID ('TMaterials')			IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID ('TVendors')			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TWorkers')			IS NOT NULL DROP TABLE TWorkers	
IF OBJECT_ID ('TSkills')			IS NOT NULL DROP TABLE TSkills







----Create Tables 

CREATE TABLE TJobs
(
	 intJobID						INTEGER				NOT NULL
	,intCustomerID						INTEGER				NOT NULL
	,intStatusID						INTEGER				NOT NULL
	,dtmStartDate						DATETIME			NOT NULL
	,dtmEndDate						DATETIME			NOT NULL
	,strJobDesc						VARCHAR(2000)		NOT NULL
	,CONSTRAINT TJobs_PK					PRIMARY KEY ( intJobID )
)


CREATE TABLE TCustomers
(
	  intCustomerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(50)			NOT NULL
	 ,strLastName						VARCHAR(50)			NOT NULL
	 ,strAddress						VARCHAR(50)			NOT NULL
	 ,strCity						VARCHAR(50)			NOT NULL
	 ,strState						VARCHAR(50)			NOT NULL
	 ,strZip						VARCHAR(50)			NOT NULL
	 ,strPhoneNumber					VARCHAR(50)			NOT NULL
	 ,CONSTRAINT TCustomer_PK			PRIMARY KEY ( intCustomerID )
)


CREATE TABLE TStatuses
(
	 intStatusID						INTEGER				NOT NULL
	,strStatus						VARCHAR(50)			NOT NULL
	,CONSTRAINT TStatuses_PK			PRIMARY KEY ( intStatusID )
)

CREATE TABLE TJobMaterials
(
	 intJobMaterialID					INTEGER				NOT NULL
	,intJobID						INTEGER				NOT NULL
	,intMaterialID						INTEGER				NOT NULL
	,intQuantity						INTEGER				NOT NULL
	,CONSTRAINT TCustomerJobMaterials_PK 			PRIMARY KEY ( intJobMaterialID )
)

CREATE TABLE TMaterials
(
	 intMaterialID						INTEGER				NOT NULL
	,strDescription						VARCHAR(100)		NOT NULL
	,monCost						MONEY				NOT NULL
	,intVendorID						INTEGER				NOT NULL
	,CONSTRAINT TMaterials_PK				PRIMARY KEY ( intMaterialID )
)

CREATE TABLE TVendors
(
	 intVendorID						INTEGER				NOT NULL
	,strVendorName						VARCHAR(50)			NOT NULL
	,strAddress						VARCHAR(50)			NOT NULL
	,strCity						VARCHAR(50)			NOT NULL
	,strState						VARCHAR(50)			NOT NULL
	,strZip							VARCHAR(50)			NOT NULL
	,strPhoneNumber						VARCHAR(50)			NOT NULL
	,CONSTRAINT TVendors_PK					PRIMARY KEY ( intVendorID )
)

CREATE TABLE TJobWorkers
(
	 intJobWorkerID						INTEGER				NOT NULL
	,intJobID						INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intHoursWorked						INTEGER				NOT NULL
	,CONSTRAINT TCustomerJobWorkers_PK			PRIMARY KEY ( intJobWorkerID )
)

CREATE TABLE TWorkers
(
	 intWorkerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(50)			NOT NULL
	 ,strLastName						VARCHAR(50)			NOT NULL
	 ,strAddress						VARCHAR(50)			NOT NULL
	 ,strCity						VARCHAR(50)			NOT NULL
	 ,strState						VARCHAR(50)			NOT NULL
	 ,strZip						VARCHAR(50)			NOT NULL
	 ,strPhoneNumber					VARCHAR(50)			NOT NULL
	 ,dtmHireDate						DATETIME			NOT NULL
	 ,monHourlyRate						MONEY				NOT NULL
	 ,CONSTRAINT TWorkers_PK				PRIMARY KEY ( intWorkerID )
)

CREATE TABLE TWorkerSkills
(
	 intWorkerSkillID					INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intSkillID						INTEGER				NOT NULL
	,CONSTRAINT	TWorkerSkills_PK			PRIMARY KEY ( intWorkerSkillID )
)

CREATE TABLE TSkills
(
	 intSkillID						INTEGER				NOT NULL
	,strSkill						VARCHAR(50)			NOT NULL
	,strDescription						VARCHAR(100)		NOT NULL
	,CONSTRAINT TSkills_PK					PRIMARY KEY ( intSkillID )
)




--Create Relationships & Foreign Keys
	---------------------------------------------------------
	
--		Child							Parent					Column
--      -----								------					---------
---  1	TJobs								TCustomers				intCustomerID
---  2  TJobs								TStatuses				intStatusID
---  3  TJobMaterials							TJobs					intJobID
---- 4	TJobMaterials							TMaterials				intMaterialID
-----5	TMaterials							TVendors				intVendorID
-----6  TJobWorkers							TJobs					intJobID
---- 7	TJobWorkers							TWorkers				intWorkerID
-----8	TWorkerSkills							TWorkers				intWorkerID
-----9  TWorkerSkills							TSkills					intSkillID


----Alter Statements

ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY (intCustomerID) REFERENCES TCustomers (intCustomerID)


ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatuses_FK
FOREIGN KEY (intStatusID) REFERENCES TStatuses (intStatusID)

ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY (intJobID) REFERENCES TJobs (intJobID)

ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY (intMaterialID) REFERENCES TMaterials (intMaterialID)

ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK
FOREIGN KEY (intVendorID) REFERENCES TVendors (intVendorID)

ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TJobs_FK
FOREIGN KEY (intJobID) REFERENCES TJobs (intJobID)

ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TWorkers_FK
FOREIGN KEY (intWorkerID) REFERENCES TWorkers (intWorkerID)

ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TWorkers_FK
FOREIGN KEY (intWorkerID) REFERENCES TWorkers (intWorkerID)

ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TSkills_FK
FOREIGN KEY (intSkillID) REFERENCES TSkills (intSkillID)



---INSERTS 

INSERT INTO TStatuses (intStatusID, strStatus)
VALUES					(1, 'Open')
						,(2, 'In process')
						,(3, 'Complete')

INSERT INTO TSkills (intSkillID, strSkill, strDescription)
VALUES				(1, 'Plumbing', 'Unclogging toilets, fixing water leaks, repairing gas lines, fixing other pipes')
					,(2, 'Electrical work', 'Fixing broken light sockets, outlets, and wiring')
					,(3, 'Heating and cooling', 'Fixing AC and Furnace units')
					,(4, 'HouseKeeping', 'Cleans bathrooms and bedrooms')
					,(5, 'Painting', 'Painting')
					,(6, 'Lawncare', 'Mowing lawn and trimming bushes')
					,(7, 'Construction', 'Building additions to houses')


INSERT INTO TVendors (intVendorID, strVendorName, strAddress, strCity, strState, strZip, strPhoneNumber)
VALUES				(1, 'Ace Hardware', '323 Lower St', 'Cincinnati', 'Ohio', '45432', '777-777-9999')
					,(2, 'Walmart', '111 Ferguson St', 'Cincinnati', 'Ohio', '45432', '392-321-7799')
					,(3, ' Lowes', '222 Edward St', 'Columbus', 'Ohio', '43235', '666-007-9911')
					,(4, 'Home Depot', '5399 Walnut St', 'Oxford', 'Ohio', '45056', '892-111-1192')
					,(5, 'Luber Liquidators', '419 Polar St', 'Cincinnati', 'Ohio', '45522', '098-997-4199')
					

INSERT INTO TMaterials (intMaterialID,strDescription, monCost, intVendorID)
VALUES					(1, 'Pvc Pipes', 100, 1)
						,(2, '50 pieces of wood', 1500, 5)
						,(3, '5 gallons of interior paint', 75, 1)
						,(4, ' 10 gallons of gasoline for lawn mower', 40, 2)
						,(5, 'Electrical wires', 200, 3)
						,(6, 'Furnace Filters', 700, 4)
						,(7, 'Hedge Clippers', 150, 2)
						,(8, 'Nails', 25, 5)
						,(9, 'Sanitizing spray', 60, 3)
						,(10, 'Wrenches', 100, 4)
						,(11, 'Sealing Tape', 150, 1)
						,(12, 'Leak detectors', 200, 2)
						,(13, '25 gallons exterior paint', 375, 1)

				


INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, strCity, strState, strZip, strPhoneNumber)
VALUES					(1, 'Alek', 'Chrismer', '999 Main St' , 'Cincinnati', 'Ohio', '45223', '513-444-5555')
						,(2, 'Eric', 'Cox', '343 Main St', 'Oxford', 'Ohio', '45056', '513-222-3333')
						,(3, 'Thomas', 'Stone', '567 Main St', 'Covington', 'Kentucky', '45555', '512-552-5533')
						,(4, 'Blain', 'Smith', '333 Power St', 'Cincinnati', 'Ohio', '43156', '513-312-6633')
						,(5, 'Seth', 'Hoop', '431 Scioto St', 'Cincinnati', 'Ohio', '43116', '740-999-3633')


INSERT INTO TWorkers (intWorkerID, strFirstName, strLastName, strAddress, strCity, strState, strZip, strPhoneNumber, dtmHireDate, monHourlyRate)
VALUES				(1, 'Carlos', 'Reyes', '9302 Hamilton St', 'Cincinnati', 'Ohio', '45221', '513-203-0322', '01-05-2021' , 20)
					,(2, 'Matt', 'Burlingame', '3278 First St', 'Cincinnati', 'Ohio', '45231', '513-893-4212', '02-05-2021' , 15)
					,(3, 'Patricia', 'Bare', '32403 Lynn St', 'Cincinnati', 'Ohio', '45221', '513-555-0982', '03-05-2021' , 18)
					,(4, 'Jacob', 'Byant', '1616 Fourth St', 'Cincinnati', 'Ohio', '45333', '513-777-5552', '09-05-2021' , 25)
					,(5, 'Jimmy', 'Peters', '1212 Grace St', 'Covington', 'Kentucky', '45891', '513-429-7622', '05-05-2021' , 30)
					,(6, 'Helen', 'Combs', '88990 Andrews st', 'Oxford', 'Ohio', '45056', '513-859-9254', '08-17-2021' , 35)


INSERT INTO TJobs (intJobID, intCustomerID, intStatusID, dtmStartDate, dtmEndDate, strJobDesc)
VALUES				(1, 1, 3, '09-09-2021', '09-11-2021', 'Repainting Basement and bathrooms')
					,(2, 1, 3, '09-15-2021', '09-16-2021', 'Mowing lawn')
					,(3, 1, 3, '09-17-2021', '09-17-2021', 'Cleaning house')
					,(4, 1, 1, '09-25-2021', '09-27-2021', 'Fixing Leaking air conditioner')
					,(5, 1, 2, '07-05-2022', '09-20-2022', 'Adding to back patio')
					,(6, 2, 3, '10-01-2021', '11-11-2021', 'Painting outside of entire house')
					,(7, 2, 2, '06-15-2022', '11-25-2022', 'Building guest house')
					,(8, 2, 1, '08-01-2022', '08-11-2022', 'Fixing furnace')
					,(9, 3, 3, '12-01-2021', '12-25-2021', 'Building back porch')
					,(10, 3, 2, '08-02-2022', '08-10-2022', 'House keeping')
					,(11, 4, 2, '08-04-2022', '04-25-2023', ' Building entire house')
					,(12, 5, 3, '12-26-2021', '12-30-2021', 'Fixing Roof leak')
					,(13, 5, 1, '08-08-2022', '09-09-2022', 'Yard work')

INSERT INTO TWorkerSkills (intWorkerSkillID, intWorkerID, intSkillID)
VALUES					(1, 1, 1)
						,(2, 1, 2)
						,(3, 1, 7)
						,(4, 2, 7)
						,(5, 2, 3)
						,(6, 2, 6)
						,(7, 2, 5)
						,(8, 3, 4)
						,(9, 3, 6)
						,(10, 4, 7)
						,(11, 4, 3)
						,(12, 4, 1)
						,(13, 4, 2)
						,(14, 4, 4)
						,(15, 5, 4)
						,(16, 5, 5)

INSERT INTO TJobMaterials (intJobMaterialID, intJobID, intMaterialID, intQuantity)
VALUES					(1, 1, 3, 5)
						,(2, 2, 4, 1)
						,(3, 2, 7, 2)
						,(4, 3, 9, 3)
						,(5, 4, 11, 2)
						,(6, 4, 12, 1)
						,(7, 5, 2, 100)
						,(8, 5, 8, 200)
						,(9, 5, 10, 20)
						,(10, 6, 13, 10)
						,(11, 7, 2, 750)
						,(12, 7, 8, 25)
						,(13, 8, 6, 1)
						,(14, 8, 10, 2)
						,(15, 9, 6, 50)
						,(16, 9, 8, 100)
						,(17, 10, 9, 3)
						,(18, 11, 2, 500)
						,(19, 11, 8, 1000)
						,(20, 11, 10, 100)
						,(21, 12, 11, 2)
						,(22, 12, 12, 2)
						,(23, 13, 7, 1)


INSERT INTO TJobWorkers (intJobWorkerID, intJobID, intWorkerID, intHoursWorked)
VALUES					(1,  1, 2, 100)
						,(2, 1, 5, 100)
						,(3, 2, 2, 10)
						,(4, 3, 3, 21)
						,(5, 4, 2, 5)
						,(6, 5, 1, 50)
						,(7, 5, 4, 50)
						,(8, 6, 5, 100)
						,(9, 6, 2, 100)
						,(10, 7, 1, 50)
						,(11, 7, 2, 50)
						,(12, 7, 4, 50)
						,(13, 8, 4, 4)
						,(14, 9, 2, 100)
						,(15, 9, 4, 100)
						,(16, 10, 5, 15)
						,(17, 11, 4, 500)
						,(18, 11, 2, 500)
						,(19, 11, 1, 500)
						,(20, 12, 4, 10)
						,(21, 12, 1, 10)

						

						
-- Create SQL to update the address for a specific custome		
Select *

From TCustomers

Update TCustomers
	Set strAddress = '500 Update Street'

Where TCustomers.intCustomerID = 4


Select * 
from TCustomers



-- Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year

Select * 
from TWorkers

Update TWorkers
Set monHourlyRate = monHourlyRate + 2
where dtmHireDate < '08/08/2021'

Select * from TWorkers


--. Create SQL to delete a specific job that has associated work hours and materials assigned to it

Select * from Tjobs

Delete TJobMaterials
Where TJobMaterials.intJobID = 8

Delete TJobWorkers
Where TJobWorkers.intJobID = 8

Delete TJobs
where Tjobs.intJobID = 8

Select * from TJobs






--Write a query to list all jobs that are in process

Select Tjobs.intJobID, Tjobs.strJobDesc as 'Job Description', TCustomers.intCustomerID, TCustomers.strFirstName + ',' + TCustomers.strLastName as 'Customer Name', TJobs.dtmStartDate as 'Job Start Date'
From TJobs
join TCustomers
on TJobs.intCustomerID = TCustomers.intCustomerID
Where TJobs.intStatusID = 2

Order by TJobs.intJobID






---Write a query to list all complete jobs for a specific customer and the materials used on each job. Include the quantity, unit cost, and total cost for each material on each job. Order by Job ID and material ID
Select TCustomers.intCustomerID
		,TJobs.intJobID
		,TStatuses.strStatus
		,TJobs.strJobDesc as 'Job description'
		,TMaterials.intMaterialID
		,TMaterials.strDescription	as 'Material Description'
		,TMaterials.monCost as 'Unit Cost'
		,TJobMaterials.intQuantity as 'Material Quantities'
		,TMaterials.monCost * TJobMaterials.intQuantity as 'Total Material cost'

From TCustomers
join TJobs
on TCustomers.intCustomerID = Tjobs.intCustomerID
join TStatuses
on TStatuses.intStatusID = TJobs.intStatusID
join TJobMaterials
on TJobMaterials.intJobID = TJobs.intJobID
join TMaterials
on TJobMaterials.intMaterialID = TMaterials.intMaterialID
 
Where TStatuses.intStatusID = 3 and TCustomers.intCustomerID = 1


Order by Tjobs.intJobID, TMaterials.intMaterialID






--
--Using same customer as above, write a query to list the total cost for all materials for each completed job for the customer. Use the data returned in step 4.2 to validate results. 

Select TCustomers.intCustomerID
		,Tjobs.intJobID
		,TStatuses.strStatus
		, Tjobs.strJobDesc
		, Sum(TMaterials.monCost *TJobMaterials.intQuantity) as 'Total Material cost'

From TCustomers
join TJobs
on TCustomers.intCustomerID = TJobs.intCustomerID
join TStatuses
on TStatuses.intStatusID = TJobs.intStatusID
join TJobMaterials
on TJobMaterials.intJobID = TJobs.intJobID
join TMaterials
on TMaterials.intMaterialID = TJobMaterials.intMaterialID

Where TStatuses.intStatusID = 3 and TCustomers.intCustomerID = 1


Group by TCustomers.intCustomerID, TJobs.intJobID, TStatuses.strStatus, Tjobs.strJobDesc

	




----A query to list all jobs that have work entered for them. Included is the job ID, job description, and job status description. List the total hours worked for each job with the lowest, highest, and average hourly rate. Data includes at least one job that does not have hours logged. This job is not be included in the query. Ordered by highest to lowest average hourly rate. 
Select	Tjobs.intJobID
		,Tjobs.strJobDesc
		,TStatuses.strStatus
		,Sum(TJobWorkers.intHoursWorked) as 'Total hours worked'
		,Min(TWorkers.monHourlyRate) as 'Lowest rate'
		,MAX(TWorkers.monHourlyRate) as 'Highest rate'
		,AVG(TWorkers.monHourlyRate) as 'Average rate'

From TJobs
join TStatuses
on Tjobs.intStatusID = TStatuses.intStatusID
join TJobWorkers
on TJobs.intJobID = TJobWorkers.intJobID
join Tworkers
on TWorkers.intWorkerID = TJobWorkers.intWorkerID

Where TJobWorkers.intWorkerID in (Select TJobs.intJobID
								From TJobs join TJobWorkers
								on TJobs.intJobID = TJobWorkers.intJobID)


Group by Tjobs.intJobID
		,Tjobs.strJobDesc
		,TStatuses.strStatus

Order by AVG(TWorkers.monHourlyRate) desc
		

				






----A query that lists all materials that have not been used on any jobs. Included are Material ID and Description. Ordered by Material ID. 
Select TMaterials.intMaterialID, TMaterials.strDescription

From TMaterials
left join TJobMaterials
on TMaterials.intMaterialID = TJobMaterials.intMaterialID

Where TJobMaterials.intMaterialID Not in (Select TJobMaterials.intMaterialID
										From TJobMaterials join TJobs
										on TJobMaterials.intMaterialID = TMaterials.intMaterialID)
										
Order by TMaterials.intMaterialID





------A query that lists all workers with a specific skill, their hire date, and the total number of jobs that they worked on. Listed is the Skill ID and description with each row. Ordered by Worker ID. 

Select TWorkers.intWorkerID,
TWorkers.strFirstName + ',' + TWorkers.strLastName as 'Worker Name', 
TWorkers.dtmHireDate, 
Count(TJobWorkers.intWorkerID) as '# of jobs worked',
TSkills.intSkillID

From TWorkers
join TWorkerSkills
on TWorkers.intWorkerID = TWorkerSkills.intWorkerID
join TSkills
on TSkills.intSkillID = TWorkerSkills.intSkillID
join TJobWorkers
on TJobWorkers.intWorkerID = TWorkers.intWorkerID

Group by TWorkers.intWorkerID, TWorkers.strFirstName, TWorkers.strLastName, TWorkers.dtmHireDate, TSkills.intSkillID

Having TSkills.intSkillID = 7

Order by TWorkers.intWorkerID






----A query that lists all workers that worked greater than 20 hours for all jobs that they worked on. Included is the Worker ID and name, number of hours worked, and number of jobs that they worked on. Ordered by Worker ID. 

Select TWorkers.intWorkerID,
		TWorkers.strFirstName + ',' + TWorkers.strLastName as 'Worker Name', 
		Sum(TJobWorkers.intHoursWorked) as 'Total hours worked',
		Count(TJobWorkers.intWorkerID) as 'Number of jobs worked'

From TWorkers 
join TJobWorkers
on TWorkers.intWorkerID = TJobWorkers.intWorkerID

Group by TWorkers.intWorkerID, TWorkers.strFirstName, TWorkers.strLastName

Having Sum(TJobWorkers.intHoursWorked) > 20

Order by TWorkers.intWorkerID




-----A query that includes the labor costs associated with each job. Included are Customer ID and Name. 


Select TCustomers.intCustomerID
	,	TCustomers.strFirstName + ',' + TCustomers.strLastName as 'Customer Name'
	, Tjobs.intJobID
	,TJobWorkers.intHoursWorked * TWorkers.monHourlyRate as 'Total cost for worker labor'
	, TWorkers.intWorkerID

	From TJobs
Join TCustomers
on Tjobs.intCustomerID = TCustomers.intCustomerID
join TJobWorkers
on TJobWorkers.intJobID = Tjobs.intJobID
join TWorkers
on Tworkers.intWorkerID = TJobWorkers.intWorkerID

Group by TCustomers.intCustomerID,
		TCustomers.strFirstName, TCustomers.strLastName,
		TJobs.intJobID,
		TWorkers.monHourlyRate,
		TWorkers.intWorkerID,
		TJobWorkers.intHoursWorked

Order by Tjobs.intJobID

	
	
---	 A query that lists all customers who are located on 'Main Street'. Included is the customer Id and full address. Ordered by Customer ID
	Select TCustomers.intCustomerID, TCustomers.strAddress, TCustomers.strCity, TCustomers.strState, TCustomers.strZip
	From TCustomers
	Where TCustomers.strAddress like '%Main st%'

	Order by TCustomers.intCustomerID


--A query to list completed jobs that started and ended in the same month. Listed: Job, Job Status, Start Date and End Date. 

	Select Tjobs.intJobID,
			Tjobs.intStatusID, 
			Tjobs.dtmStartDate, Tjobs.dtmEndDate
From TJobs

Where Month(Tjobs.dtmStartDate) = Month(Tjobs.dtmEndDate)
and Tjobs.intStatusID = 3


---A query to list workers that worked on three or more jobs for the same customer. 


Select TWorkers.intWorkerID,
		TCustomers.intCustomerID, 
		Count(TJobs.intJobID) as '# of jobs worked for customer'
From TWorkers
join TJobWorkers
on TWorkers.intWorkerID=  TJobWorkers.intWorkerID
join TJobs
on Tjobs.intJobID = TJobWorkers.intJobID
join TCustomers
on TCustomers.intCustomerID = Tjobs.intCustomerID


Group by TWorkers.intWorkerID,
		TCustomers.intCustomerID
		

Having Count(Tjobs.intJobID) >= 3






---A query to list all workers and their total # of skills. I Have workers that have multiple skills and  at least 1 worker with no skills. The worker with no skills is included with a total number of skills = 0. Ordered by Worker ID. 
 
Select TWorkers.intWorkerID
		, Count(TWorkerSkills.intSkillID) as 'Total # of skills'

From TWorkers
left join TWorkerSkills
on TWorkers.intWorkerID = TWorkerSkills.intWorkerID



Group by TWorkers.intWorkerID

Order by TWorkers.intWorkerID




--A query to list the total Charge to the customer for each job. Calculated is the total charge to the customer as the total cost of materials + total Labor costs + 30% Profit. 


Select TCustomers.intCustomerID
		,Tjobs.intJobID
		, (TMaterials.monCost * TJobMaterials.intQuantity) as 'Total Material cost' 
		,AVG(TJobWorkers.intHoursWorked) * sUM(TWorkers.monHourlyRate) as 'Total labor cost'
		,(Sum(TMaterials.monCosT) *TJobMaterials.intQuantity)  + (AVG(TJobWorkers.intHoursWorked) * SUM(TWorkers.monHourlyRate)) * ( 1.3) as 'Total cost for job'

from TCustomers
join TJobs
on TCustomers.intCustomerID = Tjobs.intCustomerID
join TJobMaterials
on TJobMaterials.intJobID = Tjobs.intJobID
join TJobWorkers
on TJobWorkers.intJobID = Tjobs.intJobID
join TWorkers
on Tworkers.intWorkerID = TJobWorkers.intWorkerID
join TMaterials
on TMaterials.intMaterialID = TJobMaterials.intMaterialID

Group by TCustomers.intCustomerID, Tjobs.intJobID, TMaterials.monCost, TJobMaterials.intQuantity


------A query that totals what is owed to each vendor for a particular job. 

Select TVendors.intVendorID
		,TJobMaterials.intJobID
		,TMaterials.monCost
		,TJobMaterials.intQuantity
		,TMaterials.monCost * TJobMaterials.intQuantity as 'Total owed to vendor'

From TVendors
join TMaterials
on TVendors.intVendorID = TMaterials.intVendorID
join TJobMaterials
on TMaterials.intMaterialID = TJobMaterials.intMaterialID

where TJobMaterials.intJobID = 4




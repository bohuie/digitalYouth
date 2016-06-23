# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[:admin, :employee, :employer].each do |role|
  Role.create({ name: role })
end

first_names = ['Allison','Arthur','Ana','Alex','Arlene','Alberto','Barry','Bertha','Bill','Bonnie','Bret','Beryl','Chantal','Cristobal','Claudette','Charley','Cindy','Chris','Dean',
	'Dolly','Danny','Danielle','Dennis','Debby','Erin','Edouard','Erika','Earl','Emily','Ernesto','Felix','Fay','Fabian','Frances','Franklin','Florence','Gabielle','Gustav','Grace',
	'Gaston','Gert','Gordon','Humberto','Hanna','Henri','Hermine','Harvey','Helene','Iris','Isidore','Isabel','Ivan','Irene','Isaac','Jerry','Josephine','Juan','Jeanne','Jose','Joyce',
	'Karen','Kyle','Kate','Karl','Katrina','Kirk','Lorenzo','Lili','Larry','Lisa','Lee','Leslie','Michelle','Marco','Mindy','Maria','Michael','Noel','Nana','Nicholas','Nicole','Nate',
	'Nadine','Olga','Omar','Odette','Otto','Ophelia','Oscar','Pablo','Paloma','Peter','Paula','Philippe','Patty','Rebekah','Rene','Rose','Richard','Rita','Rafael','Sebastien','Sally',
	'Sam','Shary','Stan','Sandy','Tanya','Teddy','Teresa','Tomas','Tammy','Tony','Van','Vicky','Victor','Virginie','Vince','Valerie','Wendy','Wilfred','Wanda','Walter','Wilma','William',
	'Kumiko','Aki','Miharu','Chiaki','Michiyo','Itoe','Nanaho','Reina','Emi','Yumi','Ayumi','Kaori','Sayuri','Rie','Miyuki','Hitomi','Naoko','Miwa','Etsuko','Akane','Kazuko','Miyako',
	'Youko','Sachiko','Mieko','Toshie','Junko']

last_names = ['Abbott', 'Acevedo', 'Acosta', 'Adams', 'Adkins', 'Aguilar', 'Aguirre', 'Albert', 'Alexander', 'Alford', 'Allen', 'Allison', 'Alston', 'Alvarado', 'Alvarez', 'Anderson', 
	'Andrews', 'Anthony', 'Armstrong', 'Arnold', 'Ashley', 'Atkins', 'Atkinson', 'Austin', 'Avery', 'Avila', 'Ayala', 'Ayers', 'Bailey', 'Baird', 'Baker', 'Baldwin', 'Ball', 'Ballard', 
	'Banks', 'Barber', 'Barker', 'Barlow', 'Barnes', 'Barnett', 'Barr', 'Barrera', 'Barrett', 'Barron', 'Barry', 'Bartlett', 'Barton', 'Bass', 'Bates', 'Battle', 'Bauer', 'Baxter', 
	'Beach', 'Bean', 'Beard', 'Beasley', 'Beck', 'Becker', 'Bell', 'Bender', 'Benjamin', 'Bennett', 'Benson', 'Bentley', 'Benton', 'Berg', 'Berger', 'Bernard', 'Berry', 'Best', 'Bird', 
	'Bishop', 'Black', 'Blackburn', 'Blackwell', 'Blair', 'Blake', 'Blanchard', 'Blankenship', 'Blevins', 'Bolton', 'Bond', 'Bonner', 'Booker', 'Boone', 'Booth', 'Bowen', 'Bowers', 
	'Bowman', 'Boyd', 'Boyer', 'Boyle', 'Bradford', 'Bradley', 'Bradshaw', 'Brady', 'Branch', 'Bray', 'Brennan', 'Brewer', 'Bridges', 'Briggs', 'Bright', 'Britt', 'Brock', 'Brooks', 
	'Brown', 'Browning', 'Bruce', 'Bryan', 'Bryant', 'Buchanan', 'Buck', 'Buckley', 'Buckner', 'Bullock', 'Burch', 'Burgess', 'Burke', 'Burks', 'Burnett', 'Burns', 'Burris', 'Burt', 
	'Burton', 'Bush', 'Butler', 'Byers', 'Byrd', 'Cabrera', 'Cain', 'Calderon', 'Caldwell', 'Calhoun', 'Callahan', 'Camacho', 'Cameron', 'Campbell', 'Campos', 'Cannon', 'Cantrell', 
	'Cantu', 'Cardenas', 'Carey', 'Carlson', 'Carney', 'Carpenter', 'Carr', 'Carrillo', 'Carroll', 'Carson', 'Carter', 'Carver', 'Case', 'Casey', 'Cash', 'Castaneda', 'Castillo', 'Castro', 
	'Cervantes', 'Chambers', 'Chan', 'Chandler', 'Chaney', 'Chang', 'Chapman', 'Charles', 'Chase', 'Chavez', 'Chen', 'Cherry', 'Christensen', 'Christian', 'Church', 'Clark', 'Clarke', 
	'Clay', 'Clayton', 'Clements', 'Clemons', 'Cleveland', 'Cline', 'Cobb', 'Cochran', 'Coffey', 'Cohen', 'Cole', 'Coleman', 'Collier', 'Collins', 'Colon', 'Combs', 'Compton', 'Conley', 
	'Conner', 'Conrad', 'Contreras', 'Conway', 'Cook', 'Cooke', 'Cooley', 'Cooper', 'Copeland', 'Cortez', 'Cote', 'Cotton', 'Cox', 'Craft', 'Craig', 'Crane', 'Crawford', 'Crosby', 'Cross', 
	'Cruz', 'Cummings', 'Cunningham', 'Curry', 'Curtis', 'Dale', 'Dalton', 'Daniel', 'Daniels', 'Daugherty', 'Davenport', 'David', 'Davidson', 'Davis', 'Dawson', 'Day', 'Dean', 'Decker', 
	'Dejesus', 'Delacruz', 'Delaney', 'Deleon', 'Delgado', 'Dennis', 'Diaz', 'Dickerson', 'Dickson', 'Dillard', 'Dillon', 'Dixon', 'Dodson', 'Dominguez', 'Donaldson', 'Donovan', 'Dorsey', 
	'Dotson', 'Douglas', 'Downs', 'Doyle', 'Drake', 'Dudley', 'Duffy', 'Duke', 'Duncan', 'Dunlap', 'Dunn', 'Duran', 'Durham', 'Dyer', 'Eaton', 'Edwards', 'Elliott', 'Ellis', 'Ellison', 
	'Emerson', 'England', 'English', 'Erickson', 'Espinoza', 'Estes', 'Estrada', 'Evans', 'Everett', 'Ewing', 'Farley', 'Farmer', 'Farrell', 'Faulkner', 'Ferguson', 'Fernandez', 'Ferrell', 
	'Fields', 'Figueroa', 'Finch', 'Finley', 'Fischer', 'Fisher', 'Fitzgerald', 'Fitzpatrick', 'Fleming', 'Fletcher', 'Flores', 'Flowers', 'Floyd', 'Flynn', 'Foley', 'Forbes', 'Ford', 
	'Foreman', 'Foster', 'Fowler', 'Fox', 'Francis', 'Franco', 'Frank', 'Franklin', 'Franks', 'Frazier', 'Frederick', 'Freeman', 'French', 'Frost', 'Fry', 'Frye', 'Fuentes', 'Fuller', 
	'Fulton', 'Gaines', 'Gallagher', 'Gallegos', 'Galloway', 'Gamble', 'Garcia', 'Gardner', 'Garner', 'Garrett', 'Garrison', 'Garza', 'Gates', 'Gay', 'Gentry', 'George', 'Gibbs', 'Gibson', 
	'Gilbert', 'Giles', 'Gill', 'Gillespie', 'Gilliam', 'Gilmore', 'Glass', 'Glenn', 'Glover', 'Goff', 'Golden', 'Gomez', 'Gonzales', 'Gonzalez', 'Good', 'Goodman', 'Goodwin', 'Gordon', 
	'Gould', 'Graham', 'Grant', 'Graves', 'Gray', 'Green', 'Greene', 'Greer', 'Gregory', 'Griffin', 'Griffith', 'Grimes', 'Gross', 'Guerra', 'Guerrero', 'Guthrie', 'Gutierrez', 'Guy', 
	'Guzman', 'Hahn', 'Hale', 'Haley', 'Hall', 'Hamilton', 'Hammond', 'Hampton', 'Hancock', 'Haney', 'Hansen', 'Hanson', 'Hardin', 'Harding', 'Hardy', 'Harmon', 'Harper', 'Harrell', 
	'Harrington', 'Harris', 'Harrison', 'Hart', 'Hartman', 'Harvey', 'Hatfield', 'Hawkins', 'Hayden', 'Hayes', 'Haynes', 'Hays', 'Head', 'Heath', 'Hebert', 'Henderson', 'Hendricks', 
	'Hendrix', 'Henry', 'Hensley', 'Henson', 'Herman', 'Hernandez', 'Herrera', 'Herring', 'Hess', 'Hester', 'Hewitt', 'Hickman', 'Hicks', 'Higgins', 'Hill', 'Hines', 'Hinton', 'Hobbs', 
	'Hodge', 'Hodges', 'Hoffman', 'Hogan', 'Holcomb', 'Holden', 'Holder', 'Holland', 'Holloway', 'Holman', 'Holmes', 'Holt', 'Hood', 'Hooper', 'Hoover', 'Hopkins', 'Hopper', 'Horn', 
	'Horne', 'Horton', 'House', 'Houston', 'Howard', 'Howe', 'Howell', 'Hubbard', 'Huber', 'Hudson', 'Huff', 'Huffman', 'Hughes', 'Hull', 'Humphrey', 'Hunt', 'Hunter', 'Hurley', 'Hurst', 
	'Hutchinson', 'Hyde', 'Ingram', 'Irwin', 'Jackson', 'Jacobs', 'Jacobson', 'James', 'Jarvis', 'Jefferson', 'Jenkins', 'Jennings', 'Jensen', 'Jimenez', 'Johns', 'Johnson', 'Johnston', 
	'Jones', 'Jordan', 'Joseph', 'Joyce', 'Joyner', 'Juarez', 'Justice', 'Kane', 'Kaufman', 'Keith', 'Keller', 'Kelley', 'Kelly', 'Kemp', 'Kennedy', 'Kent', 'Kerr', 'Key', 'Kidd', 'Kim', 
	'King', 'Kinney', 'Kirby', 'Kirk', 'Kirkland', 'Klein', 'Kline', 'Knapp', 'Knight', 'Knowles', 'Knox', 'Koch', 'Kramer', 'Lamb', 'Lambert', 'Lancaster', 'Landry', 'Lane', 'Lang', 
	'Langley', 'Lara', 'Larsen', 'Larson', 'Lawrence', 'Lawson', 'Le', 'Leach', 'Leblanc', 'Lee', 'Leon', 'Leonard', 'Lester', 'Levine', 'Levy', 'Lewis', 'Lindsay', 'Lindsey', 'Little', 
	'Livingston', 'Lloyd', 'Logan', 'Long', 'Lopez', 'Lott', 'Love', 'Lowe', 'Lowery', 'Lucas', 'Luna', 'Lynch', 'Lynn', 'Lyons', 'Macdonald', 'Macias', 'Mack', 'Madden', 'Maddox', 
	'Maldonado', 'Malone', 'Mann', 'Manning', 'Marks', 'Marquez', 'Marsh', 'Marshall', 'Martin', 'Martinez', 'Mason', 'Massey', 'Mathews', 'Mathis', 'Matthews', 'Maxwell', 'May', 'Mayer', 
	'Maynard', 'Mayo', 'Mays', 'Mcbride', 'Mccall', 'Mccarthy', 'Mccarty', 'Mcclain', 'Mcclure', 'Mcconnell', 'Mccormick', 'Mccoy', 'Mccray', 'Mccullough', 'Mcdaniel', 'Mcdonald', 
	'Mcdowell', 'Mcfadden', 'Mcfarland', 'Mcgee', 'Mcgowan', 'Mcguire', 'Mcintosh', 'Mcintyre', 'Mckay', 'Mckee', 'Mckenzie', 'Mckinney', 'Mcknight', 'Mclaughlin', 'Mclean', 'Mcleod', 
	'Mcmahon', 'Mcmillan', 'Mcneil', 'Mcpherson', 'Meadows', 'Medina', 'Mejia', 'Melendez', 'Melton', 'Mendez', 'Mendoza', 'Mercado', 'Mercer', 'Merrill', 'Merritt', 'Meyer', 'Meyers', 
	'Michael', 'Middleton', 'Miles', 'Miller', 'Mills', 'Miranda', 'Mitchell', 'Molina', 'Monroe', 'Montgomery', 'Montoya', 'Moody', 'Moon', 'Mooney', 'Moore', 'Morales', 'Moran', 'Moreno', 
	'Morgan', 'Morin', 'Morris', 'Morrison', 'Morrow', 'Morse', 'Morton', 'Moses', 'Mosley', 'Moss', 'Mueller', 'Mullen', 'Mullins', 'Munoz', 'Murphy', 'Murray', 'Myers', 'Nash', 'Navarro', 
	'Neal', 'Nelson', 'Newman', 'Newton', 'Nguyen', 'Nichols', 'Nicholson', 'Nielsen', 'Nieves', 'Nixon', 'Noble', 'Noel', 'Nolan', 'Norman', 'Norris', 'Norton', 'Nunez', 'Obrien', 'Ochoa', 
	'Oconnor', 'Odom', 'Odonnell', 'Oliver', 'Olsen', 'Olson', 'Oneal', 'Oneil', 'Oneill', 'Orr', 'Ortega', 'Ortiz', 'Osborn', 'Osborne', 'Owen', 'Owens', 'Pace', 'Pacheco', 'Padilla', 
	'Page', 'Palmer', 'Park', 'Parker', 'Parks', 'Parrish', 'Parsons', 'Pate', 'Patel', 'Patrick', 'Patterson', 'Patton', 'Paul', 'Payne', 'Pearson', 'Peck', 'Pena', 'Pennington', 'Perez', 
	'Perkins', 'Perry', 'Peters', 'Petersen', 'Peterson', 'Petty', 'Phelps', 'Phillips', 'Pickett', 'Pierce', 'Pittman', 'Pitts', 'Pollard', 'Poole', 'Pope', 'Porter', 'Potter', 'Potts', 
	'Powell', 'Powers', 'Pratt', 'Preston', 'Price', 'Prince', 'Pruitt', 'Puckett', 'Pugh', 'Quinn', 'Ramirez', 'Ramos', 'Ramsey', 'Randall', 'Randolph', 'Rasmussen', 'Ratliff', 'Ray', 
	'Raymond', 'Reed', 'Reese', 'Reeves', 'Reid', 'Reilly', 'Reyes', 'Reynolds', 'Rhodes', 'Rice', 'Rich', 'Richard', 'Richards', 'Richardson', 'Richmond', 'Riddle', 'Riggs', 'Riley', 
	'Rios', 'Rivas', 'Rivera', 'Rivers', 'Roach', 'Robbins', 'Roberson', 'Roberts', 'Robertson', 'Robinson', 'Robles', 'Rocha', 'Rodgers', 'Rodriguez', 'Rodriquez', 'Rogers', 'Rojas', 
	'Rollins', 'Roman', 'Romero', 'Rosa', 'Rosales', 'Rosario', 'Rose', 'Ross', 'Roth', 'Rowe', 'Rowland', 'Roy', 'Ruiz', 'Rush', 'Russell', 'Russo', 'Rutledge', 'Ryan', 'Salas', 'Salazar', 
	'Salinas', 'Sampson', 'Sanchez', 'Sanders', 'Sandoval', 'Sanford', 'Santana', 'Santiago', 'Santos', 'Sargent', 'Saunders', 'Savage', 'Sawyer', 'Schmidt', 'Schneider', 'Schroeder', 
	'Schultz', 'Schwartz', 'Scott', 'Sears', 'Sellers', 'Serrano', 'Sexton', 'Shaffer', 'Shannon', 'Sharp', 'Sharpe', 'Shaw', 'Shelton', 'Shepard', 'Shepherd', 'Sheppard', 'Sherman', 
	'Shields', 'Short', 'Silva', 'Simmons', 'Simon', 'Simpson', 'Sims', 'Singleton', 'Skinner', 'Slater', 'Sloan', 'Small', 'Smith', 'Snider', 'Snow', 'Snyder', 'Solis', 'Solomon', 'Sosa', 
	'Soto', 'Sparks', 'Spears', 'Spence', 'Spencer', 'Stafford', 'Stanley', 'Stanton', 'Stark', 'Steele', 'Stein', 'Stephens', 'Stephenson', 'Stevens', 'Stevenson', 'Stewart', 'Stokes', 
	'Stone', 'Stout', 'Strickland', 'Strong', 'Stuart', 'Suarez', 'Sullivan', 'Summers', 'Sutton', 'Swanson', 'Sweeney', 'Sweet', 'Sykes', 'Talley', 'Tanner', 'Tate', 'Taylor', 'Terrell', 
	'Terry', 'Thomas', 'Thompson', 'Thornton', 'Tillman', 'Todd', 'Torres', 'Townsend', 'Tran', 'Travis', 'Trevino', 'Trujillo', 'Tucker', 'Turner', 'Tyler', 'Tyson', 'Underwood', 'Valdez', 
	'Valencia', 'Valentine', 'Valenzuela', 'Vance', 'Vang', 'Vargas', 'Vasquez', 'Vaughan', 'Vaughn', 'Vazquez', 'Vega', 'Velasquez', 'Velazquez', 'Velez', 'Villarreal', 'Vincent', 'Vinson', 
	'Wade', 'Wagner', 'Walker', 'Wall', 'Wallace', 'Waller', 'Walls', 'Walsh', 'Walter', 'Walters', 'Walton', 'Ward', 'Ware', 'Warner', 'Warren', 'Washington', 'Waters', 'Watkins', 'Watson', 
	'Watts', 'Weaver', 'Webb', 'Weber', 'Webster', 'Weeks', 'Weiss', 'Welch', 'Wells', 'West', 'Wheeler', 'Whitaker', 'White', 'Whitehead', 'Whitfield', 'Whitley', 'Whitney', 'Wiggins', 
	'Wilcox', 'Wilder', 'Wiley', 'Wilkerson', 'Wilkins', 'Wilkinson', 'William', 'Williams', 'Williamson', 'Willis', 'Wilson', 'Winters', 'Wise', 'Witt', 'Wolf', 'Wolfe', 'Wong', 'Wood', 
	'Woodard', 'Woods', 'Woodward', 'Wooten', 'Workman', 'Wright', 'Wyatt', 'Wynn', 'Yang', 'Yates', 'York', 'Young', 'Zamora', 'Zimmerman']

company_names = ["3Com Corp", "3M Company", "A.G. Edwards Inc.", "Abbott Laboratories", "Abercrombie & Fitch Co.", "ABM Industries Incorporated", "Ace Hardware Corporation", "ACT Manufacturing Inc.",
				 "Acterna Corp.", "Adams Resources & Energy Inc.", "ADC Telecommunications Inc.", "Adelphia Communications Corporation", "Administaff Inc.", "Adobe Systems Incorporated", 
				 "Adolph Coors Company", "Advance Auto Parts Inc.", "Advanced Micro Devices Inc.", "AdvancePCS Inc.", "Advantica Restaurant Group Inc.", "The AES Corporation", "Aetna Inc.", 
				 "Affiliated Computer Services Inc.", "AFLAC Incorporated", "AGCO Corporation", "Agilent Technologies Inc.", "Agway Inc.", "Apartment Investment and Management Company", 
				 "Air Products and Chemicals Inc.", "Airborne Inc.", "Airgas Inc.", "AK Steel Holding Corporation", "Alaska Air Group Inc.", "Alberto-Culver Company", "Albertson's Inc.", "Alcoa Inc.",
				 "Alleghany Corporation", "Allegheny Energy Inc.", "Allegheny Technologies Incorporated", "Allergan Inc.", "ALLETE Inc.", "Alliant Energy Corporation", "Allied Waste Industries Inc.", 
				 "Allmerica Financial Corporation", "The Allstate Corporation", "ALLTEL Corporation", "The Alpine Group Inc.", "Amazon.com Inc.", "AMC Entertainment Inc.", "American Power Conversion Corporation",
				 "Amerada Hess Corporation", "AMERCO", "Ameren Corporation", "America West Holdings Corporation", "American Axle & Manufacturing Holdings Inc.", "American Eagle Outfitters Inc.", 
				 "American Electric Power Company Inc.", "American Express Company", "American Financial Group Inc.", "American Greetings Corporation", "American International Group Inc.", 
				 "American Standard Companies Inc.", "American Water Works Company Inc.", "AmerisourceBergen Corporation", "Ames Department Stores Inc.", "Amgen Inc.", "Amkor Technology Inc.", "AMR Corporation",
				 "AmSouth Bancorp.", "Amtran Inc.", "Anadarko Petroleum Corporation", "Analog Devices Inc.", "Anheuser-Busch Companies Inc.", "Anixter International Inc.", "AnnTaylor Inc.", "Anthem Inc.", 
				 "AOL Time Warner Inc.", "Aon Corporation", "Apache Corporation", "Apple Computer Inc.", "Applera Corporation", "Applied Industrial Technologies Inc.", "Applied Materials Inc.", "Aquila Inc.", 
				 "ARAMARK Corporation", "Arch Coal Inc.", "Archer Daniels Midland Company", "Arkansas Best Corporation", "Armstrong Holdings Inc.", "Arrow Electronics Inc.", "ArvinMeritor Inc.", "Ashland Inc.",
				 "Astoria Financial Corporation", "AT&T Corp.", "Atmel Corporation", "Atmos Energy Corporation", "Audiovox Corporation", "Autoliv Inc.", "Automatic Data Processing Inc.", "AutoNation Inc.",
				 "AutoZone Inc.", "Avaya Inc.", "Avery Dennison Corporation", "Avista Corporation", "Avnet Inc.", "Avon Product Inc.", "Baker Hughes Incorporated", "Ball Corporation", "Bank of America Corporation",
				 "The Bank of New York Company Inc.", "Bank One Corporation", "Banknorth Group Inc.", "Banta Corporation", "Barnes & Noble Inc.", "Bausch & Lomb Incorporated", "Baxter International Inc.", 
				 "BB&T Corporation","The Bear Stearns Companies Inc.","Beazer Homes USA Inc.","Beckman Coulter Inc.","Becton","Dickinson and Company","Bed Bath & Beyond Inc.","Belk Inc.",
				 "Bell Microproducts Inc.","BellSouth Corporation","Belo Corp.","Bemis Company Inc.","Benchmark Electronics Inc.","Berkshire Hathaway Inc.","Best Buy Co. Inc.","Bethlehem Steel Corporation",
				 "Beverly Enterprises Inc.","Big Lots Inc.","BJ Services Company","BJ's Wholesale Club Inc.","The Black & Decker Corporation","Black Hills Corporation","BMC Software Inc.","The Boeing Company",
				 "Boise Cascade Corporation","Borders Group Inc.","BorgWarner Inc.","Boston Scientific Corporation","Bowater Incorporated","Briggs & Stratton Corporation","Brightpoint Inc.",
				 "Brinker International Inc.","Bristol-Myers Squibb Company","BroadwingInc.","Brown Shoe CompanyInc.","Brown-Forman Corporation","Brunswick Corporation","Budget GroupInc.",
				 "Burlington Coat Factory Warehouse Corporation","Burlington IndustriesInc.","Burlington Northern Santa Fe Corporation","Burlington Resources Inc.","C. H. Robinson Worldwide Inc.",
				 "Cablevision Systems Corp","Cabot Corp","Cadence Design SystemsInc.","Calpine Corp.","Campbell Soup Co.","Capital One Financial Corp.","Cardinal Health Inc.","Caremark Rx Inc.",
				 "Carlisle Cos. Inc.","Carpenter Technology Corp.","Casey's General Stores Inc.","Caterpillar Inc.","CBRL Group Inc.","CDI Corp.","CDW Computer Centers Inc.","CellStar Corp.","Cendant Corp",
				 "Cenex Harvest States Cooperatives","Centex Corp.","CenturyTel Inc.","Ceridian Corp.","CH2M Hill Cos. Ltd.","Champion Enterprises Inc.","Charles Schwab Corp.","Charming Shoppes Inc.",
				 "Charter Communications Inc.","Charter One Financial Inc.","ChevronTexaco Corp.","Chiquita Brands International Inc.","Chubb Corp","Ciena Corp.","Cigna Corp","Cincinnati Financial Corp.",
				 "Cinergy Corp.","Cintas Corp.","Circuit City Stores Inc.","Cisco Systems Inc.","Citigroup","Inc","Citizens Communications Co.","CKE Restaurants Inc.","Clear Channel Communications Inc.",
				 "The Clorox Co.","CMGI Inc.","CMS Energy Corp.","CNF Inc.","Coca-Cola Co.","Coca-Cola Enterprises Inc.","Colgate-Palmolive Co.","Collins & Aikman Corp.","Comcast Corp.","Comdisco Inc.",
				 "Comerica Inc.","Comfort Systems USA Inc.","Commercial Metals Co.","Community Health Systems Inc.","Compass Bancshares Inc","Computer Associates International Inc.","Computer Sciences Corp.",
				 "Compuware Corp.","Comverse Technology Inc.","ConAgra Foods Inc.","Concord EFS Inc.","Conectiv","Inc","Conoco Inc","Conseco Inc.","Consolidated Freightways Corp.","Consolidated Edison Inc.",
				 "Constellation Brands Inc.","Constellation Emergy Group Inc.","Continental Airlines Inc.","Convergys Corp.","Cooper Cameron Corp.","Cooper Industries Ltd.","Cooper Tire & Rubber Co.",
				 "Corn Products International Inc.","Corning Inc.","Costco Wholesale Corp.","Countrywide Credit Industries Inc.","Coventry Health Care Inc.","Cox Communications Inc.","Crane Co.",
				 "Crompton Corp.","Crown Cork & Seal Co. Inc.","CSK Auto Corp.","CSX Corp.","Cummins Inc.","CVS Corp.","Cytec Industries Inc.","D&K Healthcare ResourcesInc.","D.R. Horton Inc.",
				 "Dana Corporation","Danaher Corporation","Darden Restaurants Inc.","DaVita Inc.","Dean Foods Company","Deere & Company","Del Monte Foods Co","Dell Computer Corporation","Delphi Corp.",
				 "Delta Air Lines Inc.","Deluxe Corporation","Devon Energy Corporation","Di Giorgio Corporation","Dial Corporation","Diebold Incorporated","Dillard's Inc.","DIMON Incorporated",
				 "Dole Food CompanyInc.","Dollar General Corporation","Dollar Tree StoresInc.","Dominion ResourcesInc.","Domino's Pizza LLC","Dover CorporationInc.","Dow Chemical Company",
				 "Dow Jones & CompanyInc.","DPL Inc.","DQE Inc.","Dreyer's Grand Ice CreamInc.","DST SystemsInc.","DTE Energy Co.","E.I. Du Pont de Nemours and Company","Duke Energy Corp",
				 "Dun & Bradstreet Inc.","DURA Automotive Systems Inc.","DynCorp","Dynegy Inc.","E*Trade GroupInc.","E.W. Scripps Company","EarthlinkInc.","Eastman Chemical Company","Eastman Kodak Company",
				 "Eaton Corporation","Echostar Communications Corporation","Ecolab Inc.","Edison International","EGL Inc.","El Paso Corporation","Electronic Arts Inc.","Electronic Data Systems Corp.",
				 "Eli Lilly and Company","EMC Corporation","Emcor Group Inc.","Emerson Electric Co.","Encompass Services Corporation","Energizer Holdings Inc.","Energy East Corporation","Engelhard Corporation",
				 "Enron Corp.","Entergy Corporation","Enterprise Products Partners L.P.","EOG ResourcesInc.","Equifax Inc.","Equitable Resources Inc.","Equity Office Properties Trust",
				 "Equity Residential Properties Trust","Estee Lauder Companies Inc.","Exelon Corporation","Exide Technologies","Expeditors International of Washington Inc.","Express Scripts Inc.",
				 "ExxonMobil Corporation","Fairchild Semiconductor International Inc.","Family Dollar Stores Inc.","Farmland Industries Inc.","Federal Mogul Corp.","Federated Department Stores Inc.",
				 "Federal Express Corp.","Felcor Lodging Trust Inc.","Ferro Corp.","Fidelity National Financial Inc.","Fifth Third Bancorp","First American Financial Corp.","First Data Corp.",
				 "First National of Nebraska Inc.","First Tennessee National Corp.","FirstEnergy Corp.","Fiserv Inc.","Fisher Scientific International Inc.","FleetBoston Financial Co.",
				 "Fleetwood Enterprises Inc.","Fleming Companies Inc.","Flowers Foods Inc.","Flowserv Corp","Fluor Corp","FMC Corp","Foamex International Inc","Foot Locker Inc","Footstar Inc.",
				 "Ford Motor Co","Forest Laboratories Inc.","Fortune Brands Inc.","Foster Wheeler Ltd.","FPL Group Inc.","Franklin Resources Inc.","Freeport McMoran Copper & Gold Inc.",
				 "Frontier Oil Corp","Furniture Brands International Inc.","Gannett Co.Inc.","Gap Inc.","Gateway Inc.","GATX Corporation","Gemstar-TV Guide International Inc.","GenCorp Inc.",
				 "General Cable Corporation","General Dynamics Corporation","General Electric Company","General Mills Inc","General Motors Corporation","Genesis Health Ventures Inc.","Gentek Inc.",
				 "Gentiva Health Services Inc.","Genuine Parts Company","Genuity Inc.","Genzyme Corporation","Georgia Gulf Corporation","Georgia-Pacific Corporation","Gillette Company","Gold Kist Inc.",
				 "Golden State Bancorp Inc.","Golden West Financial Corporation","Goldman Sachs Group Inc.","Goodrich Corporation","The Goodyear Tire & Rubber Company","Granite Construction Incorporated",
				 "Graybar Electric Company Inc.","Great Lakes Chemical Corporation","Great Plains Energy Inc.","GreenPoint Financial Corp.","Greif Bros. Corporation","Grey Global Group Inc.",
				 "Group 1 Automotive Inc.","Guidant Corporation","H&R Block Inc.","H.B. Fuller Company","H.J. Heinz Company","Halliburton Co.","Harley-Davidson Inc.","Harman International Industries Inc.",
				 "Harrah's Entertainment Inc.","Harris Corp.","Harsco Corp.","Hartford Financial Services Group Inc.","Hasbro Inc.","Hawaiian Electric Industries Inc.","HCA Inc.",
				 "Health Management Associates Inc.","Health Net Inc.","Healthsouth Corp","Henry Schein Inc.","Hercules Inc.","Herman Miller Inc.","Hershey Foods Corp.","Hewlett-Packard Company",
				 "Hibernia Corp.","Hillenbrand Industries Inc.","Hilton Hotels Corp.","Hollywood Entertainment Corp.","Home Depot Inc.","Hon Industries Inc.","Honeywell International Inc.","Hormel Foods Corp.",
				 "Host Marriott Corp.","Household International Corp.","Hovnanian Enterprises Inc.","Hub Group Inc.","Hubbell Inc.","Hughes Supply Inc.","Humana Inc.","Huntington Bancshares Inc.",
				 "Idacorp Inc.","IDT Corporation","IKON Office Solutions Inc.","Illinois Tool Works Inc.","IMC Global Inc.","Imperial Sugar Company","IMS Health Inc.","Ingles Market Inc","Ingram Micro Inc.",
				 "Insight Enterprises Inc.","Integrated Electrical Services Inc.","Intel Corporation","International Paper Co.","Interpublic Group of Companies Inc.","Interstate Bakeries Corporation",
				 "International Business Machines Corp.","International Flavors & Fragrances Inc.","International Multifoods Corporation","Intuit Inc.","IT Group Inc.","ITT Industries Inc.","Ivax Corp.",
				 "J.B. Hunt Transport Services Inc.","J.C. Penny Co.","J.P. Morgan Chase & Co.","Jabil Circuit Inc.","Jack In The Box Inc.","Jacobs Engineering Group Inc.","JDS Uniphase Corp.",
				 "Jefferson-Pilot Co.","John Hancock Financial Services Inc.","Johnson & Johnson","Johnson Controls Inc.","Jones Apparel Group Inc.","KB Home","Kellogg Company","Kellwood Company",
				 "Kelly Services Inc.","Kemet Corp.","Kennametal Inc.","Kerr-McGee Corporation","KeyCorp","KeySpan Corp.","Kimball International Inc.","Kimberly-Clark Corporation","Kindred Healthcare Inc.",
				 "KLA-Tencor Corporation","K-Mart Corp.","Knight-Ridder Inc.","Kohl's Corp.","KPMG Consulting Inc.","Kroger Co.","L-3 Communications Holdings Inc.","Laboratory Corporation of America Holdings",
				 "Lam Research Corporation","LandAmerica Financial Group Inc.","Lands' End Inc.","Landstar System Inc.","La-Z-Boy Inc.","Lear Corporation","Legg Mason Inc.","Leggett & Platt Inc.",
				 "Lehman Brothers Holdings Inc.","Lennar Corporation","Lennox International Inc.","Level 3 Communications Inc.","Levi Strauss & Co.","Lexmark International Inc.","Limited Inc.",
				 "Lincoln National Corporation","Linens 'n Things Inc.","Lithia Motors Inc.","Liz Claiborne Inc.","Lockheed Martin Corporation","Loews Corporation","Longs Drug Stores Corporation",
				 "Louisiana-Pacific Corporation","Lowe's Companies Inc.","LSI Logic Corporation","The LTV Corporation","The Lubrizol Corporation","Lucent Technologies Inc.","Lyondell Chemical Company",
				 "M & T Bank Corporation","Magellan Health Services Inc.","Mail-Well Inc.","Mandalay Resort Group","Manor Care Inc.","Manpower Inc.","Marathon Oil Corporation","Mariner Health Care Inc.",
				 "Markel Corporation","Marriott International Inc.","Marsh & McLennan Companies Inc.","Marsh Supermarkets Inc.","Marshall & Ilsley Corporation","Martin Marietta Materials Inc.",
				 "Masco Corporation","Massey Energy Company","MasTec Inc.","Mattel Inc.","Maxim Integrated Products Inc.","Maxtor Corporation","Maxxam Inc.","The May Department Stores Company",
				 "Maytag Corporation","MBNA Corporation","McCormick & Company Incorporated","McDonald's Corporation","The McGraw-Hill Companies Inc.","McKesson Corporation","McLeodUSA Incorporated",
				 "M.D.C. Holdings Inc.","MDU Resources Group Inc.","MeadWestvaco Corporation","Medtronic Inc.","Mellon Financial Corporation","The Men's Wearhouse Inc.","Merck & Co.Inc.",
				 "Mercury General Corporation","Merrill Lynch & Co. Inc.","Metaldyne Corporation","Metals USA Inc.","MetLife Inc.","Metris Companies Inc","MGIC Investment Corporation","MGM Mirage",
				 "Michaels Stores Inc.","Micron Technology Inc.","Microsoft Corporation","Milacron Inc.","Millennium Chemicals Inc.","Mirant Corporation","Mohawk Industries Inc.","Molex Incorporated",
				 "The MONY Group Inc.","Morgan Stanley Dean Witter & Co.","Motorola Inc.","MPS Group Inc.","Murphy Oil Corporation","Nabors Industries Inc","Nacco Industries Inc","Nash Finch Company",
				 "National City Corp.","National Commerce Financial Corporation","National Fuel Gas Company","National Oilwell Inc","National Rural Utilities Cooperative Finance Corporation",
				 "National Semiconductor Corporation","National Service Industries Inc","Navistar International Corporation","NCR Corporation","The Neiman Marcus Group Inc.","New Jersey Resources Corporation",
				 "New York Times Company","Newell Rubbermaid Inc","Newmont Mining Corporation","Nextel Communications Inc","Nicor Inc","Nike Inc","NiSource Inc","Noble Energy Inc","Nordstrom Inc",
				 "Norfolk Southern Corporation","Nortek Inc","North Fork Bancorporation Inc","Northeast Utilities System","Northern Trust Corporation","Northrop Grumman Corporation","NorthWestern Corporation",
				 "Novellus Systems Inc","NSTAR","NTL Incorporated","Nucor Corp","Nvidia Corp","NVR Inc","Northwest Airlines Corp","Occidental Petroleum Corp","Ocean Energy Inc","Office Depot Inc.",
				 "OfficeMax Inc","OGE Energy Corp","Oglethorpe Power Corp.","Ohio Casualty Corp.","Old Republic International Corp.","Olin Corp.","OM Group Inc","Omnicare Inc","Omnicom Group",
				 "On Semiconductor Corp","ONEOK Inc","Oracle Corp","Oshkosh Truck Corp","Outback Steakhouse Inc.","Owens & Minor Inc.","Owens Corning","Owens-Illinois Inc","Oxford Health Plans Inc",
				 "Paccar Inc","PacifiCare Health Systems Inc","Packaging Corp. of America","Pactiv Corp","Pall Corp","Pantry Inc","Park Place Entertainment Corp","Parker Hannifin Corp.",
				 "Pathmark Stores Inc.","Paychex Inc","Payless Shoesource Inc","Penn Traffic Co.","Pennzoil-Quaker State Company","Pentair Inc","Peoples Energy Corp.","PeopleSoft Inc","Pep Boys Manny",
				 "Moe & Jack","Potomac Electric Power Co.","Pepsi Bottling Group Inc.","PepsiAmericas Inc.","PepsiCo Inc.","Performance Food Group Co.","Perini Corp","PerkinElmer Inc","Perot Systems Corp",
				 "Petco Animal Supplies Inc.","Peter Kiewit Sons'Inc.","PETsMART Inc","Pfizer Inc","Pacific Gas & Electric Corp.","Pharmacia Corp","Phar Mor Inc.","Phelps Dodge Corp.",
				 "Philip Morris Companies Inc.","Phillips Petroleum Co","Phillips Van Heusen Corp.","Phoenix Companies Inc","Pier 1 Imports Inc.","Pilgrim's Pride Corporation","Pinnacle West Capital Corp",
				 "Pioneer-Standard Electronics Inc.","Pitney Bowes Inc.","Pittston Brinks Group","Plains All American Pipeline LP","PNC Financial Services Group Inc.","PNM Resources Inc","Polaris Industries Inc.",
				 "Polo Ralph Lauren Corp","PolyOne Corp","Popular Inc","Potlatch Corp","PPG Industries Inc","PPL Corp","Praxair Inc","Precision Castparts Corp","Premcor Inc.","Pride International Inc","Primedia Inc",
				 "Principal Financial Group Inc.","Procter & Gamble Co.","Pro-Fac Cooperative Inc.","Progress Energy Inc","Progressive Corporation","Protective Life Corp","Provident Financial Group",
				 "Providian Financial Corp.","Prudential Financial Inc.","PSS World Medical Inc","Public Service Enterprise Group Inc.","Publix Super Markets Inc.","Puget Energy Inc.","Pulte Homes Inc","Qualcomm Inc",
				 "Quanta Services Inc.","Quantum Corp","Quest Diagnostics Inc.","Questar Corp","Quintiles Transnational","Qwest Communications Intl Inc","R.J. Reynolds Tobacco Company","R.R. Donnelley & Sons Company",
				 "Radio Shack Corporation","Raymond James Financial Inc.","Raytheon Company","Reader's Digest Association Inc.","Reebok International Ltd.","Regions Financial Corp.","Regis Corporation",
				 "Reliance Steel & Aluminum Co.","Reliant Energy Inc.","Rent A Center Inc","Republic Services Inc","Revlon Inc","RGS Energy Group Inc","Rite Aid Corp","Riverwood Holding Inc.","RoadwayCorp",
				 "Robert Half International Inc.","Rock-Tenn Co","Rockwell Automation Inc","Rockwell Collins Inc","Rohm & Haas Co.","Ross Stores Inc","RPM Inc.","Ruddick Corp","Ryder System Inc","Ryerson Tull Inc",
				 "Ryland Group Inc.","Sabre Holdings Corp","Safeco Corp","Safeguard Scientifics Inc.","Safeway Inc","Saks Inc","Sanmina-SCI Inc","Sara Lee Corp","SBC Communications Inc","Scana Corp.",
				 "Schering-Plough Corp","Scholastic Corp","SCI Systems Onc.","Science Applications Intl. Inc.","Scientific-Atlanta Inc","Scotts Company","Seaboard Corp","Sealed Air Corp","Sears Roebuck & Co",
				 "Sempra Energy","Sequa Corp","Service Corp. International","ServiceMaster Co","Shaw Group Inc","Sherwin-Williams Company","Shopko Stores Inc","Siebel Systems Inc","Sierra Health Services Inc",
				 "Sierra Pacific Resources","Silgan Holdings Inc.","Silicon Graphics Inc","Simon Property Group Inc","SLM Corporation","Smith International Inc","Smithfield Foods Inc","Smurfit-Stone Container Corp",
				 "Snap-On Inc","Solectron Corp","Solutia Inc","Sonic Automotive Inc.","Sonoco Products Co.","Southern Company","Southern Union Company","SouthTrust Corp.","Southwest Airlines Co","Southwest Gas Corp",
				 "Sovereign Bancorp Inc.","Spartan Stores Inc","Spherion Corp","Sports Authority Inc","Sprint Corp.","SPX Corp","St. Jude Medical Inc","St. Paul Cos.","Staff Leasing Inc.","StanCorp Financial Group Inc",
				 "Standard Pacific Corp.","Stanley Works","Staples Inc","Starbucks Corp","Starwood Hotels & Resorts Worldwide Inc","State Street Corp.","Stater Bros. Holdings Inc.","Steelcase Inc","Stein Mart Inc",
				 "Stewart & Stevenson Services Inc","Stewart Information Services Corp","Stilwell Financial Inc","Storage Technology Corporation","Stryker Corp","Sun Healthcare Group Inc.","Sun Microsystems Inc.",
				 "SunGard Data Systems Inc.","Sunoco Inc.","SunTrust Banks Inc","Supervalu Inc","Swift Transportation","Co.","Inc","Symbol Technologies Inc","Synovus Financial Corp.","Sysco Corp","Systemax Inc.",
				 "Target Corp.","Tech Data Corporation","TECO Energy Inc","Tecumseh Products Company","Tektronix Inc","Teleflex Incorporated","Telephone & Data Systems Inc","Tellabs Inc.","Temple-Inland Inc",
				 "Tenet Healthcare Corporation","Tenneco Automotive Inc.","Teradyne Inc","Terex Corp","Tesoro Petroleum Corp.","Texas Industries Inc.","Texas Instruments Incorporated","Textron Inc",
				 "Thermo Electron Corporation","Thomas & Betts Corporation","Tiffany & Co","Timken Company","TJX Companies Inc","TMP Worldwide Inc","Toll Brothers Inc","Torchmark Corporation","Toro Company",
				 "Tower Automotive Inc.","Toys 'R' Us Inc","Trans World Entertainment Corp.","TransMontaigne Inc","Transocean Inc","TravelCenters of America Inc.","Triad Hospitals Inc","Tribune Company",
				 "Trigon Healthcare Inc.","Trinity Industries Inc","Trump Hotels & Casino Resorts Inc.","TruServ Corporation","TRW Inc","TXU Corp","Tyson Foods Inc","U.S. Bancorp","U.S. Industries Inc.","UAL Corporation",
				 "UGI Corporation","Unified Western Grocers Inc","Union Pacific Corporation","Union Planters Corp","Unisource Energy Corp","Unisys Corporation","United Auto Group Inc","United Defense Industries Inc.",
				 "United Parcel Service Inc","United Rentals Inc","United Stationers Inc","United Technologies Corporation","UnitedHealth Group Incorporated","Unitrin Inc","Universal Corporation",
				 "Universal Forest Products Inc","Universal Health Services Inc","Unocal Corporation","Unova Inc","UnumProvident Corporation","URS Corporation","US Airways Group Inc","US Oncology Inc","USA Interactive",
				 "USFreighways Corporation","USG Corporation","UST Inc","Valero Energy Corporation","Valspar Corporation","Value City Department Stores Inc","Varco International Inc","Vectren Corporation",
				 "Veritas Software Corporation","Verizon Communications Inc","VF Corporation","Viacom Inc","Viad Corp","Viasystems Group Inc","Vishay Intertechnology Inc","Visteon Corporation",
				 "Volt Information Sciences Inc","Vulcan Materials Company","W.R. Berkley Corporation","W.R. Grace & Co","W.W. Grainger Inc","Wachovia Corporation","Wakenhut Corporation","Walgreen Co",
				 "Wallace Computer Services Inc","Wal-Mart Stores Inc","Walt Disney Co","Walter Industries Inc","Washington Mutual Inc","Washington Post Co.","Waste Management Inc","Watsco Inc",
				 "Weatherford International Inc","Weis Markets Inc.","Wellpoint Health Networks Inc","Wells Fargo & Company","Wendy's International Inc","Werner Enterprises Inc","WESCO International Inc",
				 "Western Digital Inc","Western Gas Resources Inc","WestPoint Stevens Inc","Weyerhauser Company","WGL Holdings Inc","Whirlpool Corporation","Whole Foods Market Inc","Willamette Industries Inc.",
				 "Williams Companies Inc","Williams Sonoma Inc","Winn Dixie Stores Inc","Wisconsin Energy Corporation","Wm Wrigley Jr Company","World Fuel Services Corporation","WorldCom Inc",
				 "Worthington Industries Inc","WPS Resources Corporation","Wyeth","Wyndham International Inc","Xcel Energy Inc","Xerox Corp","Xilinx Inc","XO Communications Inc","Yellow Corporation",
				 "York International Corp","Yum Brands Inc.","Zale Corporation","Zions Bancorporation"]

streets = ["West Velvetleaf Way","Fox Creek Mount","East Foothill Vista","North Jessup Row","Minoru Trail","Sunken Meadow Causeway","Dares Wharf Promenade","Lynestra Vale West","Sugden Bypass","Southwest Halevy Grove",
		  "Binscombe Green","Aldfield Rise","Mac Donald","East Berkmans Manor","North Scouller Mount","East Burngarten Grove","Copped Hall West","Gona Trace South","South Deacon Haynes Circle","South Battles Pathway",
		  "Canon Barns Trace","West House of Correction Loop","Father Capodanno Route","Anthony Hill Row","East Elrose Way","Creasys Canyon","Chuter Court East","Northwest Middlegate Close","West Aladdin Quay","East Half Moon Bay Hill",
		  "Southeast Whisperwillow Garth","North Weston Bay Rise","Cabrito Bypass West","Kulas Knoll","North Kempston Parkway","Saint Moritz","Cliff View North","Don Mills","Northeast Revensey Spur","Southeast Barnmead Trail",
		  "South Van Tines","Eastland Arch South","Alta Sierra","Stillman Knoll West","Northwest Millbeck Way","Southwest Green Court Trace","East Stonestile Loop","Baja Spur West","Molle Quay","Hancock Grade"]

cities = ["Toronto","Montreal","Vancouver","Lachine","Mississauga","Leamington","Camrose","Richmond","Markham","Creston","Coquitlam","Victoria","Port Coquitlam","North Vancouver","Burnaby","Surrey","Delta","Vernon","New Westminster",
		  "Langley","Kamloops","Maple Ridge","Abbotsford","Chilliwack","Whistler Village","Kelowna","Port Moody","Calgary","Lethbridge","Edmonton","Lacombe","Fort McMurray","Fort Saskatchewan","Red Deer",
		  "Morinville","Spruce Grove","Sherwood Park","Okotoks","Strathmore","Airdrie","High Level","Fairview, Alberta","Leduc","Grande Prairie","Chatham","Tavistock","Perth","Midland","Laval","Hamilton","Ottawa",
		  "Fergus","Scarborough","Cambridge","Waterloo","Welland","Vieux-Saint-Laurent","Kitchener","Longueuil","Oshawa","Brampton","Rougemont","Saint-Remi","London","Milton","Pointe-Claire","Sherbrooke","Kanata",
		  "Gatineau","Lasalle","Quebec","Beauport","Donnacona","Charlesbourg","Saint-Augustin","Joliette","Saint-Felicien","Dolbeau-Mistassini","Albanel","Port Clements","Queen Charlotte","Masset","Ingersoll",
		  "Alma","Hawkesbury","Shannonville","Elk Point","Burgessville","Brantford","Woodstock","Thornhill","Stoney Creek","Caledonia","Burlington","Grimsby","Vineland Station","Beamsville","Niagara Falls",
		  "Smithville","Jordan","Peterborough","Granby","Cowansville","Boisbriand","Levis","Sorel","Blainville","Mont-Royal","Saint-Michel-des-Saints","Saint-Hubert-de-Riviere-du-Loup","Rosemere","Sainte-Marthe",
		  "Nominingue","Saint-Eustache","Sainte-Catherine","Terrebonne","Saint-Leonard","Westmount","Kirkland","Delson","Saint-Sauveur","Saint-Jean-sur-Richelieu","Sabrevois","Saint-Lambert","Mascouche",
		  "Saint-Jerome","Chambly","Varennes","Mirabel","RiviÃ¨re-du-Loup","Brossard","Repentigny","Sainte-Therese","Dorval","Leonard","Saint-Lin-Laurentides","Verdun","Saint-Agapit","Boucherville","Jonquiere",
		  "Chicoutimi","Saint-Lambert","Brossard","Candiac","Kincardine","North Perth","Stratford","Les Escoumins","Saint-Jacques","L'Assomption","Greenfield Park","Deux-Montagnes","Waterville","Amos",
		  "La Morandiere","Barraute","Val-d'Or","Rouyn-Noranda","Saint-Prosper","Saint-Georges","Saint-Simon-de-Rimouski","Saint-Victor","La Guadeloupe","Alma","Drummondville","Roberval","Asbestos","Rimouski",
		  "Saint-Anaclet-de-Lessard","Trois-RiviÃ¨res","Magog","Shawinigan","Sainte-Agathe-des-Monts","Sainte-Adele","Sainte-Anne-des-Monts","Salaberry-de-Valleyfield","Saint-Germain-de-Grantham","Thetford-Mines",
		  "Champlain","North York","Aurora","Richmond Hill","Orleans","Etobicoke","Guelph","Whitby","Pickering","Vercheres","Saint-Gabriel-de-Valcartier","Canning","Wolfville","Kentville","Centreville","Cambridge",
		  "Ancaster","Jerseyville","North Russell","Cote-Saint-Luc","Mont-Tremblant","Saint-Faustin--Lac-Carre","Plessisville","Port-Cartier","Sept-Iles","Montmagny","Notre-Dame-du-Mont-Carmel","Shawinigan-Sud",
		  "Saint-Mathieu","Windsor","Belle River","Tecumseh","Kingsville","Amherstburg","Newmarket","Essex","Harrow","Wheatley","Tecumseh","Memphremagog","Stettler","Rocky Mountain House","Banff","Canmore","Didsbury",
		  "Carstairs","Blairmore","Pincher Creek","Coleman","Cowley","Taber","Brooks","Drumheller","High River","Drayton Valley","Barrhead","Edson","Lloydminster","Vermilion","Winnipeg","Hinton","Jasper","Westlock",
		  "Kimberley","Cranbrook","Marysville","Fernie","Canyon","Golden","Invermere","Fairmont Hot Springs","Penticton","Summerland","Okanagan Centre","Westbank","Chase","Nelson","Coldstream","Port Alberni","Sooke",
		  "Courtenay","Comox","Parksville","Cumberland","Winfield","Enderby","Salmon Arm","Armstrong","Sorrento","Williams Lake","Grand Forks","Greenwood","Peachland","Regina","Rosetown","Canora","Kindersley","La Ronge",
		  "Humboldt","Warman","Melfort","Meadow Lake","Unity","Esterhazy","Kamsack","North Battleford","Weyburn","Maidstone","Estevan","Yorkton","Melville","Maple Creek","Moosomin","Saint-Pierre-de-Broughton",
		  "Saint-Hyacinthe","Steinbach","Stonewall","Selkirk","Teulon","Pine Falls","Beausejour","Thompson","St. Paul","Portage la Prairie","Tsawwassen","White Rock","Sechelt","Mission","Biggar","Midale","Nipawin",
		  "Lampman","Saskatoon","Halifax","Bridgewater","Italy Cross","Lunenburg","Shelburne","Mahone Bay","Dartmouth","Eastern Passage","Sydney","Truro","Springhill","Halifax","Sackville","Mount Uniacke","Beaver Bank",
		  "Port Dover","Canfield","Dunnville","Hagersville","Waterford","Cayuga","Sidney","Crofton","Saanichton","North Saanich","Mayne","Shawnigan Lake","Duncan","Chemainus","Lake Cowichan","Cobble Hill","Ladysmith",
		  "Powell River","Van Anda","Sault Ste. Marie","Manitouwadge","Wawa","Thunder Bay","Atikokan","Terrace Bay","Schreiber","Woodbridge","Shelburne","Bolton","Puslinch","York","Acton","Stouffville","Ajax",
		  "Orangeville","Glencoe","Caledon","Oakville","Norfolk County","Tillsonburg","Orillia","Millbrook","Arthur","North Hatley","Roxboro","Crabtree","Huntingdon","Beloeil","Rawdon","Bourget","Niagara-on-the-Lake",
		  "Concord","Maskinonge","Saint-Maurice","Saint-Barthelemy","Batiscan","Pierreville","Becancour","Nicolet","Saint-Etienne-des-Gres","Yamachiche","GaspÃ©","Baie-Comeau","Saint-Pierre","Sainte-Angele-de-Premont",
		  "Chandler","Val-David","Yamaska","Matane","Saint-Ulric","Saint-Leonard-d'Aston","Deschaillons-sur-Saint-Laurent","Aston-Jonction","Sainte-Perpetue","Saint-Cyrille-de-Wendover","Roxton Falls","Richmond",
		  "Disraeli","Normandin","Saint-Gedeon","Louiseville","Saint-Dominique","East Broughton","Desbiens","Hebertville","Carmel","Sainte-Anne-de-la-Perade","Ayer's Cliff","Windsor","Tumbler Ridge","Osoyoos","Oliver",
		  "Fenelon Falls","Lindsay","Bobcaygeon","Dunsford","Potter","Vaughan","Murray River","Charlottetown","New Glasgow","Trenton","Stellarton","Sydney","North Sydney","Villa Marie","Yarmouth","Digby","Brookfield",
		  "Victoria","Clarke's Beach","Harbour Grace","Bellevue","Bay Roberts","Heart's Delight-Islington","Summerside","Coleman","Annapolis Royal","Oxford","Amherst","Fogo","Greenspond","Lumsden","Digby","Antigonish",
		  "Kensington","Arichat","Port Hawkesbury","D'Escousse","Petit-de-Grat","Cornwall","Georgetown","New Hamburg","St. John's","Mount Pearl","Bedford","Church Point","Placentia","Meteghan River","East Chezzetcook",
		  "Sydney Mines","Stratford","Windsor","Barrie","King City","Beeton","Alliston","Bradford","Uxbridge","Angus","Schomberg","Tottenham","Caledon","Greater Sudbury","Lively","Chelmsford","New Liskeard","Timmins",
		  "Copper Cliff","Elliot Lake","Blind River","Casimir","Massey","Rockwood","Belleville","Sturgeon Falls","North Bay","Aylmer","Garson","Port Elgin","Hanover","Listowel","Mildmay","Palmerston","Wingham",
		  "Mount Forest","Chesley","Kingston","Napanee","Simcoe","Marmora","Campbellford","Napanee","Winchester","Walkerton","Chesterville","Cornwall","Kapuskasing","Picton","Fort-Coulonge","Owen Sound","Durham",
		  "Britt","Gore Bay","Dundas","Waterdown","Carlisle","Hanna","Lougheed","Wetaskiwin","Cold Lake","Calmar","Clairmont","Bonnyville","Aylesford","Berwick","Greenwood","Middleton","Kingston","Three Mile Plains",
		  "Saint-Frederic","Rigaud","Huntsville","Bracebridge","Gravenhurst","Parry Sound","Maple","Saint-Joseph-de-Beauce","La Patrie","Saint-Camille","Eastman","Napierville","Austin","Martinville","Compton",
		  "Sawyerville","Sainte-Marie","Saint-Louis-de-Gonzague","Trenton","Corbyville","Petawawa","Pembroke","Grenville","Elora","Vaudreuil-Dorion","Lachute","Saint-Basile-le-Grand","Chateauguay",
		  "Sainte-Sophie-d'Halifax","Pointe-aux-Trembles","Mont-Saint-Hilaire","Otterburn Park","Circonscription electorale d'Anjou","Howick","Pointe-Calumet","La Pocatiere","Ange-Gardien","Saint Romuald",
		  "Saint-Honore-de-Temiscouata","Dollard-Des Ormeaux","Sainte-Julie","L'Epiphanie","La Prairie","Baie-D'Urfe","Oka","Saint-Jean-de-l'Ile-d'Orleans","Beaupre","Marieville","Clarence-Rockland","Contrecoeur",
		  "Maniwaki","Saint-Lin","Lavaltrie","Hampton","Saint John","Luskville","Hudson","Bruno","Saint-Joachim-de-Shefford","McMasterville","Mercier","Sainte-Julienne","Saint-Antonin","Tadoussac","Chute-aux-Outardes",
		  "Pointe-Lebel","Beaconsfield","Saint-Marc-sur-Richelieu","Portneuf","Farnham","Saint-Venant-de-Paquette","Vallee-Jonction","Sutton","Saint-Zacharie","Lac-Megantic","Brome","Sainte-Cecile-de-Whitton",
		  "Ormstown","Stanbridge East","Dudswell","Saint-Elzear","St. Catharines","Callander","Renfrew","Gibsons","Prince George","Princeton","Merritt","Fort Nelson","Mackenzie","Roberts Creek","Halfmoon Bay","La Sarre",
		  "Dupuy","Notre-Dame-du-Nord","Ville-Marie","Temiscaming","Macamic","Massueville","Saint-Hugues","Malartic","Bearn","La Tuque","Laverlochere","Richmond","St. Thomas","Nepean","Stewiacke","Valley","Westville",
		  "Eureka","Pictou","Marystown","Troy","La Conception","Middle Musquodoboit","Hebron","Cavendish","Grono Road","Jordan Falls","Barrington Passage","Barrington","Crapaud","Brigus","Clarenville","Blackville",
		  "Scotsburn","Hant's Harbour","Carbonear","Holyrood","Cornwallis","Black Diamond","Trochu","Three Hills","Bonne Bay","Fortune","Morell","Bridgetown","Clementsvale","Bear River","Springdale","Murray Harbour",
		  "Seldom-Little Seldom","Liverpool","Port Medway","Paradise Cove","Victoria Cove","Birchy Bay","Gander","Twillingate","Burin","St. Alban's","West Lake","Margaretsville","Hampton","Corner Brook","Wainwright",
		  "Daniel's Harbour","Tusket","Saulnierville","Rockville","Chester","Baie Verte","Happy Valley-Goose Bay","Gambo","Granville Ferry","Western Bay","Old Perlican","Bay de Verde",
		  "Circonscription electorale d'Outremont","Bromont","Victoriaville","Acton Vale","Valcourt","Metabetchouan-Lac-a-la-Croix","Wickham","Warwick","La Presentation","Saint-Damase","La Baie","L'Anse-Saint-Jean",
		  "Pont-Rouge","Baie-Saint-Paul","Mitchell","Paisley","Iroquois Falls","Kirkland Lake","Levack","Omemee","Pefferlaw","Goderich","Clinton","Exeter","Bayfield","Prescott","Berthierville","Lakefield","Cobourg",
		  "Baltimore","Port Hope","Port Perry","Kitimat","Terrace","Smithers","Prince Rupert","Roseneath","Brandon","Stittsville","Norway House","Winkler","Port Colborne","Noyan","Fredericton","Moncton","Perth-Andover",
		  "Tracadieâ€“Sheila","Miramichi","Woodstock","Edmundston","Campbellton","Bathurst","Souris","Coniston","Saint-Quentin","Plaster Rock","Neguac","Canterbury","Rogersville","Doaktown","Lavillette","Hartland",
		  "Nackawic","Pointe-Verte","Dover","Lewisporte","Port Saunders","Saint Fintan's","L'Anse-au-Loup","Deer Lake","Grand Falls-Windsor","Conception Bay South","Hantsport","Bay Bulls","Dieppe","Berry Mills",
		  "Rothesay","Quispamsis","South Porcupine","Haileybury","Grand Bayâ€“Westfield","Timberlea","Elmsdale","Carters Cove","Mira Gut","Sable River","Alberton","Glace Bay","New Waterford","Portugal Cove",
		  "Grand Falls","Pouch Cove","Sicamous","Tappen","Pritchard","Pitt Meadows","Fort St. John","Onoway","St. Albert","Oyama","Aldergrove","Squamish","Garibaldi","Brackendale","Trail","Castlegar","Hope",
		  "Vanderhoof","Fort St. James","Lumby","Sexsmith","McLennan","Peace River","Grimshaw","Beaverlodge","Rycroft","Irricana","Turner Valley","Bassano","Innisfail","Blackfalds","Sylvan Lake","Ponoka"]

provinces = ["AB","BC","MB","MB","NB","NL","NT","NS","NU","ON","PE","QC","SK","YT"]
chars = ("A".."Z").to_a

for i in 0...50
	first = first_names[rand(first_names.length)]
	last = last_names[rand(last_names.length)]
	if rand(1) == 1
		usr = User.create(first_name: first, last_name: last, email: first+"_"+last+"@example.com",password:"password", password_confirmation: 'password')
		usr.add_role :employee
		usr.confirm
	else
		cname = company_names[rand(company_names.length)]
		caddr = (111 + rand(999)).to_s + streets[rand(streets.length)]
		ccity = cities[rand(cities.length)]
		cprov = provinces[rand(provinces.length)]
		cpost = chars[rand(chars.length)] + rand(9).to_s + chars[rand(chars.length)] + " " + rand(9).to_s + chars[rand(chars.length)] + rand(9).to_s
		usr = User.create(first_name: first, last_name: last, email: first+"_"+last+"@example.com",password:"password", password_confirmation: 'password',
		company_name: cname, company_address: caddr, company_city: ccity, company_province: cprov, company_postal_code: cpost)
		
		usr.add_role :employer
		usr.confirm
	end
end



user1 = User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'password', password_confirmation: 'password')
user1.add_role :employee
user1.confirm

user4 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'jane@doe.com', password: 'password', password_confirmation: 'password')
user4.add_role :employee
user4.confirm


reference1 = Reference.create(first_name: 'Bernie', last_name: 'Smith', email: 'Andrew@gmail.com', company: 'Apple Picking Co.',
			 position: "Lead Apple Picker", phone_number:"(250)555-5555", reference_body: "They were the best Apple Picker.", user_id: user4.id)


user2 = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
	company_name: 'Google', company_address: '123 Fake Street', company_city: 'Kelowna', company_province: 'BC', company_postal_code: 'V1V 1V1')
user2.add_role :employer
user2.confirm

user3 = User.create(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
user3.add_role :admin
user3.confirm

JobPosting.create(title: 'Social Media Manager', description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: '2016-01-01', close_date: '2016-04-01', user_id: user2.id)

skill1 = Skill.create(name: 'Facebook Posting')
skill2 = Skill.create(name: 'Twitter Posting')
skill3 = Skill.create(name: 'Content Creator')
UserSkill.create(user_id: user1.id, skill_id: skill1.id, rating: "2")


project1 = user1.projects.create(title: 'No Image project', description: 'some description')

ProjectSkill.create(project_id: project1.id, skill_id: skill1.id)
ProjectSkill.create(project_id: project1.id, skill_id: skill2.id)



# ---- Surveys ----

#Surveys - title and category
survey1 = Survey.create(title: 'General'				, category: 'Computer')
survey2 = Survey.create(title: 'Internet and Networks'	, category: 'Computer')
survey3 = Survey.create(title: 'Programming'			, category: 'Computer')
survey4 = Survey.create(title: 'Word Processing'		, category: 'Productivity')
survey5 = Survey.create(title: 'Spreadsheet'			, category: 'Productivity')
survey6 = Survey.create(title: 'Online Communication and Collaboration'	, category: 'Productivity')
survey7 = Survey.create(title: 'Time, Project, People'	, category: 'Management')
survey8 = Survey.create(title: 'Money'					, category: 'Management')
survey9 = Survey.create(title: 'Presentation'			, category: 'Management')
survey10 = Survey.create(title: 'Multimedia'			, category: 'New Media and Personal Qualities')
survey11 = Survey.create(title: 'Social Media'			, category: 'New Media and Personal Qualities')
survey12 = Survey.create(title: '21st Century Skills'	, category: 'New Media and Personal Qualities')

#Questions - These are essentially the labels for each question
question1 = Question.create(classification: 'Basic'			, survey_id: survey1.id, )
question2 = Question.create(classification: 'Intermediate'	, survey_id: survey1.id, )
question3 = Question.create(classification: 'Advanced'		, survey_id: survey1.id, )
question4 = Question.create(classification: 'Expert'		, survey_id: survey1.id, )

question5 = Question.create(classification: 'Basic'			, survey_id: survey2.id, )
question6 = Question.create(classification: 'Intermediate'	, survey_id: survey2.id, )
question7 = Question.create(classification: 'Advanced'		, survey_id: survey2.id, )
question8 = Question.create(classification: 'Expert'		, survey_id: survey2.id, )

question9 = Question.create(classification: 'Basic'			, survey_id: survey3.id, )
question10 = Question.create(classification: 'Intermediate'	, survey_id: survey3.id, )
question11 = Question.create(classification: 'Advanced'		, survey_id: survey3.id, )
question12 = Question.create(classification: 'Expert'		, survey_id: survey3.id, )

question13 = Question.create(classification: 'Basic'		, survey_id: survey4.id, )
question14 = Question.create(classification: 'Intermediate'	, survey_id: survey4.id, )
question15 = Question.create(classification: 'Advanced'		, survey_id: survey4.id, )
question16 = Question.create(classification: 'Expert'		, survey_id: survey4.id, )

question17 = Question.create(classification: 'Basic'		, survey_id: survey5.id, )
question18 = Question.create(classification: 'Intermediate'	, survey_id: survey5.id, )
question19 = Question.create(classification: 'Advanced'		, survey_id: survey5.id, )
question20 = Question.create(classification: 'Expert'		, survey_id: survey5.id, )

question21 = Question.create(classification: 'Basic'		, survey_id: survey6.id, )
question22 = Question.create(classification: 'Intermediate'	, survey_id: survey6.id, )
question23 = Question.create(classification: 'Advanced'		, survey_id: survey6.id, )
question24 = Question.create(classification: 'Expert'		, survey_id: survey6.id, )

question25 = Question.create(classification: 'Time'			, survey_id: survey7.id, )
question26 = Question.create(classification: 'Project'		, survey_id: survey7.id, )
question27 = Question.create(classification: 'People'		, survey_id: survey7.id, )

question28 = Question.create(classification: 'Basic'		, survey_id: survey8.id, )
question29 = Question.create(classification: 'Intermediate'	, survey_id: survey8.id, )
question30 = Question.create(classification: 'Advanced'		, survey_id: survey8.id, )
question31 = Question.create(classification: 'Expert'		, survey_id: survey8.id, )

question32 = Question.create(classification: 'Basic'		, survey_id: survey9.id, )
question33 = Question.create(classification: 'Intermediate'	, survey_id: survey9.id, )
question34 = Question.create(classification: 'Advanced'		, survey_id: survey9.id, )
question35 = Question.create(classification: 'Expert'		, survey_id: survey9.id, )

question36 = Question.create(classification: 'Basic'		, survey_id: survey10.id, )
question37 = Question.create(classification: 'Intermediate'	, survey_id: survey10.id, )
question38 = Question.create(classification: 'Advanced'		, survey_id: survey10.id, )
question39 = Question.create(classification: 'Expert'		, survey_id: survey10.id, )

question40 = Question.create(classification: 'Basic'		, survey_id: survey11.id, )
question41 = Question.create(classification: 'Intermediate'	, survey_id: survey11.id, )
question42 = Question.create(classification: 'Advanced'		, survey_id: survey11.id, )
question43 = Question.create(classification: 'Expert'		, survey_id: survey11.id, )

question44 = Question.create(classification: 'Communication'		, survey_id: survey12.id, )
question45 = Question.create(classification: 'Problem Solving'		, survey_id: survey12.id, )
question46 = Question.create(classification: 'Self-Directed Skill'				, survey_id: survey12.id, )
question47 = Question.create(classification: 'Accountability'	, survey_id: survey12.id, )

#Prompts
#Survey 1: General
survey1_prompt1 = Prompt.create(question_id: question1.id, prompt: 'Start a program')
survey1_prompt2 = Prompt.create(question_id: question1.id, prompt: 'Navigate between multiple opened programs')
survey1_prompt3 = Prompt.create(question_id: question1.id, prompt: 'Exit a program')
survey1_prompt4 = Prompt.create(question_id: question1.id, prompt: 'Use a mouse or track pad')
survey1_prompt5 = Prompt.create(question_id: question1.id, prompt: 'Use a keyboard')
survey1_prompt6 = Prompt.create(question_id: question1.id, prompt: 'Turn on a computer')
survey1_prompt7 = Prompt.create(question_id: question1.id, prompt: 'Shut down a computer')

survey1_prompt8 = Prompt.create(question_id: question2.id, prompt: 'Find a program')
survey1_prompt9 = Prompt.create(question_id: question2.id, prompt: 'Export a file to a different format')
survey1_prompt10 = Prompt.create(question_id: question2.id, prompt: 'Use a webcam')
survey1_prompt11 = Prompt.create(question_id: question2.id, prompt: 'Determine the type and version of an operating system')
survey1_prompt12 = Prompt.create(question_id: question2.id, prompt: 'Log off a computer')

survey1_prompt13 = Prompt.create(question_id: question3.id, prompt: 'Save a file to a flash drive (e.g. USB)')
survey1_prompt14 = Prompt.create(question_id: question3.id, prompt: 'Use a microphone')
survey1_prompt15 = Prompt.create(question_id: question3.id, prompt: 'Use a scanner')
survey1_prompt16 = Prompt.create(question_id: question3.id, prompt: 'Update software')
survey1_prompt17 = Prompt.create(question_id: question3.id, prompt: 'Do similar tasks on two different operating systems')

survey1_prompt14 = Prompt.create(question_id: question4.id, prompt: 'Save a file to a CD')
survey1_prompt15 = Prompt.create(question_id: question4.id, prompt: 'Select software for a defined task')
survey1_prompt16 = Prompt.create(question_id: question4.id, prompt: 'Connect a new device (e.g. scanner, mouse, printer, hard drive')
survey1_prompt17 = Prompt.create(question_id: question4.id, prompt: 'Install new software (e.g. antivirus)')
survey1_prompt18 = Prompt.create(question_id: question4.id, prompt: 'Do similar tasks on at least two operating systems')

#Survey 2: Internet and Networks
survey2_prompt1 = Prompt.create(question_id: question5.id, prompt: 'Open a browser')
survey2_prompt2 = Prompt.create(question_id: question5.id, prompt: 'Determine the url (web address) of a website')
survey2_prompt3 = Prompt.create(question_id: question5.id, prompt: 'Go to a website')
survey2_prompt4 = Prompt.create(question_id: question5.id, prompt: 'Follow links on a webpage')
survey2_prompt5 = Prompt.create(question_id: question5.id, prompt: 'Print a webpage')

survey2_prompt6 = Prompt.create(question_id: question6.id, prompt: 'Use a browser to move forward and backward through webpages')
survey2_prompt7 = Prompt.create(question_id: question6.id, prompt: 'Use a browser to refresh/reload a webpage')
survey2_prompt8 = Prompt.create(question_id: question6.id, prompt: 'Save a website as a bookmark or favourites')
survey2_prompt9 = Prompt.create(question_id: question6.id, prompt: 'Download files from the internet')
survey2_prompt10 = Prompt.create(question_id: question6.id, prompt: 'Install software from the internet')
survey2_prompt11 = Prompt.create(question_id: question6.id, prompt: 'Check if the computer is connected to the internet')
survey2_prompt12 = Prompt.create(question_id: question6.id, prompt: 'Connect to an (un)secured wireless connection')

survey2_prompt13 = Prompt.create(question_id: question7.id, prompt: 'Determine the domain name of a website')
survey2_prompt14 = Prompt.create(question_id: question7.id, prompt: 'Use search engines (e.g. Google, Yahoo!')
survey2_prompt15 = Prompt.create(question_id: question7.id, prompt: 'Use advanced search filters and strategies')
survey2_prompt16 = Prompt.create(question_id: question7.id, prompt: 'Connect to the internet using a cable')
survey2_prompt17 = Prompt.create(question_id: question7.id, prompt: 'Determine the IP address of a machine')

survey2_prompt14 = Prompt.create(question_id: question8.id, prompt: 'Connect to a modem')
survey2_prompt15 = Prompt.create(question_id: question8.id, prompt: 'Configure a modem')
survey2_prompt16 = Prompt.create(question_id: question8.id, prompt: 'Connect to a wireless router')
survey2_prompt17 = Prompt.create(question_id: question8.id, prompt: 'Configure a wireless router')
survey2_prompt18 = Prompt.create(question_id: question8.id, prompt: 'Check activity status of a specific server')
survey2_prompt19 = Prompt.create(question_id: question8.id, prompt: 'Troubleshoot network connectivity problems')

#Survey 3: Programming
survey3_prompt1 = Prompt.create(question_id: question9.id, prompt: 'Use tools and templates to create websites')
survey3_prompt2 = Prompt.create(question_id: question9.id, prompt: 'Modify basic HTML code or code in other markup languages')
survey3_prompt3 = Prompt.create(question_id: question9.id, prompt: 'Modify simple CSS elements')
survey3_prompt4 = Prompt.create(question_id: question9.id, prompt: 'Understand basic concepts in computer programming')

survey3_prompt5 = Prompt.create(question_id: question10.id, prompt: 'Build simple websites from scratch')
survey3_prompt6 = Prompt.create(question_id: question10.id, prompt: 'Write and test programs to do mathematical calculations')
survey3_prompt7 = Prompt.create(question_id: question10.id, prompt: 'Write and test programs that read from and write to files')
survey3_prompt8 = Prompt.create(question_id: question10.id, prompt: 'Write and test programs that use elementary data structures such as arrays and linked lists')

survey3_prompt9 = Prompt.create(question_id: question11.id, prompt: 'Write and test programs that use complex data structures such as hash maps and trees')
survey3_prompt10 = Prompt.create(question_id: question11.id, prompt: 'Write and test programs that have a graphical user interface')
survey3_prompt11 = Prompt.create(question_id: question11.id, prompt: 'Write and test simple apps for mobile devices')
survey3_prompt12 = Prompt.create(question_id: question11.id, prompt: 'Measure programs for performance')

survey3_prompt13 = Prompt.create(question_id: question12.id, prompt: 'Build complex websites with databases and modern interface')
survey3_prompt14 = Prompt.create(question_id: question12.id, prompt: 'Write and test programs that mimics mathematical models')
survey3_prompt15 = Prompt.create(question_id: question12.id, prompt: 'Write and test programs to run simulations and experiments')
survey3_prompt16 = Prompt.create(question_id: question12.id, prompt: 'Write and test third party apps for social media platform')
survey3_prompt17 = Prompt.create(question_id: question12.id, prompt: 'Optimize programs for performance')

#Survey 4: Word Processing
survey4_prompt1 = Prompt.create(question_id: question13.id, prompt: 'Open a new document')
survey4_prompt2 = Prompt.create(question_id: question13.id, prompt: 'Edit a document')
survey4_prompt3 = Prompt.create(question_id: question13.id, prompt: 'Save a document')
survey4_prompt4 = Prompt.create(question_id: question13.id, prompt: 'Cut/copy/paste content')
survey4_prompt5 = Prompt.create(question_id: question13.id, prompt: 'Close a document')
survey4_prompt6 = Prompt.create(question_id: question13.id, prompt: 'Switch to another opened document')
survey4_prompt7 = Prompt.create(question_id: question13.id, prompt: 'Zoom in and out')

survey4_prompt8 = Prompt.create(question_id: question14.id, prompt: 'Create section headings')
survey4_prompt9 = Prompt.create(question_id: question14.id, prompt: 'Create title pages and table of contents')
survey4_prompt10 = Prompt.create(question_id: question14.id, prompt: 'Adjust text stylizations and spacing')
survey4_prompt11 = Prompt.create(question_id: question14.id, prompt: 'Create bullet lists')
survey4_prompt12 = Prompt.create(question_id: question14.id, prompt: 'Create tables')
survey4_prompt13 = Prompt.create(question_id: question14.id, prompt: 'Insert images')

survey4_prompt9 = Prompt.create(question_id: question15.id, prompt: 'Use a template')
survey4_prompt10 = Prompt.create(question_id: question15.id, prompt: 'Modify paragraph spacing')
survey4_prompt11 = Prompt.create(question_id: question15.id, prompt: 'Set document margins')
survey4_prompt12 = Prompt.create(question_id: question15.id, prompt: 'Change page orientation')
survey4_prompt13 = Prompt.create(question_id: question15.id, prompt: 'Add header and footer content')
survey4_prompt14 = Prompt.create(question_id: question15.id, prompt: 'Add captions to images and tables')

survey4_prompt15 = Prompt.create(question_id: question16.id, prompt: 'Spell check the document')
survey4_prompt16 = Prompt.create(question_id: question16.id, prompt: 'Grammar check the document')
survey4_prompt17 = Prompt.create(question_id: question16.id, prompt: 'Check word count of highlighted text')
survey4_prompt18 = Prompt.create(question_id: question16.id, prompt: 'Add comments to a document')
survey4_prompt19 = Prompt.create(question_id: question16.id, prompt: 'Use "review mode" to highlight contributions made by different users')

#Survey 5: Spreadsheet
survey5_prompt1 = Prompt.create(question_id: question17.id, prompt: 'Open a new spreadsheet')
survey5_prompt2 = Prompt.create(question_id: question17.id, prompt: 'Edit a spreadsheet')
survey5_prompt3 = Prompt.create(question_id: question17.id, prompt: 'Save a spreadsheet')
survey5_prompt4 = Prompt.create(question_id: question17.id, prompt: 'Cut/copy/paste cells')
survey5_prompt5 = Prompt.create(question_id: question17.id, prompt: 'Close a spreadsheet')
survey5_prompt6 = Prompt.create(question_id: question17.id, prompt: 'Switch to another opened spreadsheet')
survey5_prompt7 = Prompt.create(question_id: question17.id, prompt: 'Zoom in and out')

survey5_prompt8 = Prompt.create(question_id: question18.id, prompt: 'Create multiple sheets within one document')
survey5_prompt9 = Prompt.create(question_id: question18.id, prompt: 'Adjust text stylizations and spacing')
survey5_prompt10 = Prompt.create(question_id: question18.id, prompt: 'Format cells')
survey5_prompt11 = Prompt.create(question_id: question18.id, prompt: 'Insert Images')
survey5_prompt12 = Prompt.create(question_id: question18.id, prompt: 'Cut/copy/paste columns')

survey5_prompt13 = Prompt.create(question_id: question19.id, prompt: 'Use a template')
survey5_prompt14 = Prompt.create(question_id: question19.id, prompt: 'Find and use formulas')
survey5_prompt15 = Prompt.create(question_id: question19.id, prompt: 'Create equations')
survey5_prompt16 = Prompt.create(question_id: question19.id, prompt: '(Un)hide rows')
survey5_prompt17 = Prompt.create(question_id: question19.id, prompt: 'Sort information')
survey5_prompt18 = Prompt.create(question_id: question19.id, prompt: 'Reference cells in a different sheet')

survey5_prompt19 = Prompt.create(question_id: question20.id, prompt: 'Freeze panes')
survey5_prompt20 = Prompt.create(question_id: question20.id, prompt: 'Create charts')
survey5_prompt21 = Prompt.create(question_id: question20.id, prompt: 'Calculate basic statistics (e.g. sum, average, histogram)')
survey5_prompt22 = Prompt.create(question_id: question20.id, prompt: 'Creating macros')
survey5_prompt23 = Prompt.create(question_id: question20.id, prompt: 'Writing VBA to define specialized functions')

#Survey 6: Online communication and collab
survey6_prompt1 = Prompt.create(question_id: question21.id, prompt: 'Read emails')
survey6_prompt2 = Prompt.create(question_id: question21.id, prompt: 'Compose new emails')
survey6_prompt3 = Prompt.create(question_id: question21.id, prompt: 'Send, reply, and forward emails')
survey6_prompt4 = Prompt.create(question_id: question21.id, prompt: 'Attend and online meeting')
survey6_prompt5 = Prompt.create(question_id: question21.id, prompt: 'Edit documents online')

survey6_prompt6 = Prompt.create(question_id: question22.id, prompt: 'Carbon copy additional recipients in an email')
survey6_prompt7 = Prompt.create(question_id: question22.id, prompt: 'Create and activate a new email account')
survey6_prompt8 = Prompt.create(question_id: question22.id, prompt: 'Manage an account using folders')
survey6_prompt9 = Prompt.create(question_id: question22.id, prompt: 'Send emails with attachments')
survey6_prompt10 = Prompt.create(question_id: question22.id, prompt: 'Share documents online')

survey6_prompt11 = Prompt.create(question_id: question23.id, prompt: 'Reset an account password')
survey6_prompt11 = Prompt.create(question_id: question23.id, prompt: 'Flag an email as important')
survey6_prompt13 = Prompt.create(question_id: question23.id, prompt: 'Request email client to notify you (the sender) when a respondent has read your email')
survey6_prompt14 = Prompt.create(question_id: question23.id, prompt: 'Email a meeting request with a calender')
survey6_prompt15 = Prompt.create(question_id: question23.id, prompt: 'Establish video conference calls (with multiple parties)')

survey6_prompt16 = Prompt.create(question_id: question24.id, prompt: 'Set up POP/IMAP to synchronize emails accross different computers/devices')
survey6_prompt17 = Prompt.create(question_id: question24.id, prompt: 'Organize an online event')
survey6_prompt18 = Prompt.create(question_id: question24.id, prompt: 'Pool participant available times together')
survey6_prompt19 = Prompt.create(question_id: question24.id, prompt: 'Use an online tool to schedule an event')

#Survey 7: Time, Project, People
survey7_prompt1 = Prompt.create(question_id: question25.id, prompt: 'When working in a group, I ensure we use our time productively')
survey7_prompt2 = Prompt.create(question_id: question25.id, prompt: 'I use tools (e.g. to-do lists, activity log) to improve my time management')
survey7_prompt3 = Prompt.create(question_id: question25.id, prompt: 'I distinguish tasks with different level of priorites')
survey7_prompt4 = Prompt.create(question_id: question25.id, prompt: 'I make plans and set goals each day')
survey7_prompt5 = Prompt.create(question_id: question25.id, prompt: 'I follow my plan of actions whenever possible')
survey7_prompt6 = Prompt.create(question_id: question25.id, prompt: 'I avoid procrastination even when the task is vague or unpleasant')

survey7_prompt7 = Prompt.create(question_id: question26.id, prompt: 'Given a project, I can develop a detailed plan (e.g. a work breakdown structure) with achievable milestones and set resources')
survey7_prompt8 = Prompt.create(question_id: question26.id, prompt: 'Given specific project requirements, I can design various solutions that can meet the client\'s needs')
survey7_prompt9 = Prompt.create(question_id: question26.id, prompt: 'In a project, I can lead the team effectively to meet the target milestones and goals')
survey7_prompt10 = Prompt.create(question_id: question26.id, prompt: 'When working on a project, I reflect on past experiences (successes, challenges, and failures) and use them to plan future actions')
survey7_prompt11 = Prompt.create(question_id: question26.id, prompt: 'Over the course of the project, I use quantitative metrics as well as qualitative feedback to monitor progress')
survey7_prompt12 = Prompt.create(question_id: question26.id, prompt: 'At the end of a project, I am able to identify successes, challenges, and failures, and explain them with quantitative ')

survey7_prompt13 = Prompt.create(question_id: question27.id, prompt: 'I listen to others and am receptive to their ideas')
survey7_prompt14 = Prompt.create(question_id: question27.id, prompt: 'I consider\'s needs and priorities')
survey7_prompt15 = Prompt.create(question_id: question27.id, prompt: 'When working in a group, I ensure everyone has an opportunity to contribute')
survey7_prompt16 = Prompt.create(question_id: question27.id, prompt: 'I am aware of other\'s emotions, perspectives, and behaviours when in a group')
survey7_prompt17 = Prompt.create(question_id: question27.id, prompt: 'I am always involved in group tasks and discussions')
survey7_prompt18 = Prompt.create(question_id: question27.id, prompt: 'I can manage conflict with group members effectively')
survey7_prompt19 = Prompt.create(question_id: question27.id, prompt: 'When working in a group, I am able to discuss and reach a consensus when a decision has to be made')

#Survey 8: Money 
survey8_prompt1 = Prompt.create(question_id: question28.id, prompt: 'Develop budget proposals')
survey8_prompt2 = Prompt.create(question_id: question28.id, prompt: 'Understand financial charts')
survey8_prompt3 = Prompt.create(question_id: question28.id, prompt: 'Recognition of revenues and costs')
survey8_prompt4 = Prompt.create(question_id: question28.id, prompt: 'Keep the team informed')
survey8_prompt5 = Prompt.create(question_id: question28.id, prompt: 'Manage project Scope')

survey8_prompt6 = Prompt.create(question_id: question29.id, prompt: 'Develop budget strategies')
survey8_prompt7 = Prompt.create(question_id: question29.id, prompt: 'Create profit and loss statement')
survey8_prompt8 = Prompt.create(question_id: question29.id, prompt: 'Create balance sheet and cash flow statement')
survey8_prompt9 = Prompt.create(question_id: question29.id, prompt: 'Apply methods to measure inventory, accounts, receivable, accounts payable')
survey8_prompt10 = Prompt.create(question_id: question29.id, prompt: 'Identify relevant costs for pricing')

survey8_prompt11 = Prompt.create(question_id: question30.id, prompt: 'Apply methods to reduce inventory, accounts receivable, and keep capital expenditure under control')
survey8_prompt12 = Prompt.create(question_id: question30.id, prompt: 'Understand and manage types of investments and costs for investment decisions')
survey8_prompt13 = Prompt.create(question_id: question30.id, prompt: 'Compare different pricing techniques')
survey8_prompt14 = Prompt.create(question_id: question30.id, prompt: 'Calculate breakeven point')
survey8_prompt15 = Prompt.create(question_id: question30.id, prompt: 'Conduct budget variation analysis')

survey8_prompt16 = Prompt.create(question_id: question31.id, prompt: 'Develop pricing strategies')
survey8_prompt17 = Prompt.create(question_id: question31.id, prompt: 'Forecast the budget')
survey8_prompt18 = Prompt.create(question_id: question31.id, prompt: 'Forecast resource usage')
survey8_prompt19 = Prompt.create(question_id: question31.id, prompt: 'Create simulations to demonstrate scenarios')
survey8_prompt20 = Prompt.create(question_id: question31.id, prompt: 'Plan organization\'s short and long term financial goals')

#Survey 9: - Presentation
survey9_prompt1 = Prompt.create(question_id: question32.id, prompt: 'Open a new presentation document')
survey9_prompt2 = Prompt.create(question_id: question32.id, prompt: 'Edit a document')
survey9_prompt3 = Prompt.create(question_id: question32.id, prompt: 'Save a document')
survey9_prompt4 = Prompt.create(question_id: question32.id, prompt: 'Cut/copy/paste content')
survey9_prompt5 = Prompt.create(question_id: question32.id, prompt: 'Close a document')
survey9_prompt6 = Prompt.create(question_id: question32.id, prompt: 'Switch to another opened document')
survey9_prompt7 = Prompt.create(question_id: question32.id, prompt: 'Zoom in and out')
survey9_prompt8 = Prompt.create(question_id: question32.id, prompt: 'Switch between presentation and edit mode')

survey9_prompt9 = Prompt.create(question_id: question33.id, prompt: 'Add notes to a slide')
survey9_prompt10 = Prompt.create(question_id: question33.id, prompt: 'Incorporate images')
survey9_prompt11 = Prompt.create(question_id: question33.id, prompt: 'Incorporate audio files')
survey9_prompt12 = Prompt.create(question_id: question33.id, prompt: 'Incorporate video clips')
survey9_prompt13 = Prompt.create(question_id: question33.id, prompt: 'Adjust text stylizations and spacing')
survey9_prompt14 = Prompt.create(question_id: question33.id, prompt: 'Create tables')
survey9_prompt15 = Prompt.create(question_id: question33.id, prompt: 'Add page numbers')

survey9_prompt16 = Prompt.create(question_id: question34.id, prompt: 'Use a template')
survey9_prompt17 = Prompt.create(question_id: question34.id, prompt: 'Change the layout of the slide')
survey9_prompt18 = Prompt.create(question_id: question34.id, prompt: 'Use animations')
survey9_prompt19 = Prompt.create(question_id: question34.id, prompt: 'Use transitions')
survey9_prompt20 = Prompt.create(question_id: question34.id, prompt: 'Change footers')

survey9_prompt21 = Prompt.create(question_id: question35.id, prompt: 'Change template style')
survey9_prompt22 = Prompt.create(question_id: question35.id, prompt: 'Create new template styles')
survey9_prompt23 = Prompt.create(question_id: question35.id, prompt: 'Create a timed slideshow')
survey9_prompt24 = Prompt.create(question_id: question35.id, prompt: 'Add music to a slideshow')
survey9_prompt25 = Prompt.create(question_id: question35.id, prompt: 'Record and incorporate audio')
survey9_prompt26 = Prompt.create(question_id: question35.id, prompt: 'Create and incorporate charts and graphs')

#Survey 10: Multimedia 
survey10_prompt1 = Prompt.create(question_id: question36.id, prompt: 'Listen to music on a CD')
survey10_prompt2 = Prompt.create(question_id: question36.id, prompt: 'Listen to music on a mobile device (e.g. phone or tablet)')
survey10_prompt3 = Prompt.create(question_id: question36.id, prompt: 'Watch a movie on a DVD')
survey10_prompt4 = Prompt.create(question_id: question36.id, prompt: 'Watch a movie on a mobile device')
survey10_prompt5 = Prompt.create(question_id: question36.id, prompt: 'View photos')
survey10_prompt6 = Prompt.create(question_id: question36.id, prompt: 'Take photos using a digital camera or phone')

survey10_prompt7 = Prompt.create(question_id: question37.id, prompt: 'Take a video using a digital camera or phone')
survey10_prompt8 = Prompt.create(question_id: question37.id, prompt: 'Search for images, music, and movies of interest')
survey10_prompt9 = Prompt.create(question_id: question37.id, prompt: 'Trim media (e.g. image, audio, video) content')
survey10_prompt10 = Prompt.create(question_id: question37.id, prompt: 'Combine two files together')
survey10_prompt11 = Prompt.create(question_id: question37.id, prompt: 'Add text and subtitles to the media')
survey10_prompt12 = Prompt.create(question_id: question37.id, prompt: 'Edit a media file without changing the original work much')

survey10_prompt13 = Prompt.create(question_id: question38.id, prompt: 'Create a new media file')
survey10_prompt14 = Prompt.create(question_id: question38.id, prompt: 'Apply filters to manipulate the original media')
survey10_prompt15 = Prompt.create(question_id: question38.id, prompt: 'Use layers to control different changes made to a file')
survey10_prompt16 = Prompt.create(question_id: question38.id, prompt: 'Edit the media file in more complex ways')
survey10_prompt17 = Prompt.create(question_id: question38.id, prompt: 'Transfer media files across multiple devices')

survey10_prompt19 = Prompt.create(question_id: question39.id, prompt: 'Create infographics')
survey10_prompt20 = Prompt.create(question_id: question39.id, prompt: 'Create animated gifs')
survey10_prompt21 = Prompt.create(question_id: question39.id, prompt: 'Browse and purchase media repositories')
survey10_prompt22 = Prompt.create(question_id: question39.id, prompt: 'Determine the copyrights of a media file')
survey10_prompt23 = Prompt.create(question_id: question39.id, prompt: 'Determine if a media file has been manipulated')
survey10_prompt24 = Prompt.create(question_id: question39.id, prompt: 'Identify the specific parts of a media file that has been manipulated')

#Survey 11: Social Media 
survey11_prompt1 = Prompt.create(question_id: question40.id, prompt: 'Read posts')
survey11_prompt2 = Prompt.create(question_id: question40.id, prompt: 'Post updates')
survey11_prompt3 = Prompt.create(question_id: question40.id, prompt: 'Respond to comments')
survey11_prompt4 = Prompt.create(question_id: question40.id, prompt: 'Post pictures and videos')
survey11_prompt5 = Prompt.create(question_id: question40.id, prompt: 'Blog')
survey11_prompt6 = Prompt.create(question_id: question40.id, prompt: 'Comment on blogs or other content')
survey11_prompt7 = Prompt.create(question_id: question40.id, prompt: 'Like/favourite content')
survey11_prompt8 = Prompt.create(question_id: question40.id, prompt: 'Share and curate content')
survey11_prompt9 = Prompt.create(question_id: question40.id, prompt: 'Network with others')

survey11_prompt10 = Prompt.create(question_id: question41.id, prompt: 'Create social media accounts')
survey11_prompt11 = Prompt.create(question_id: question41.id, prompt: 'Update account')
survey11_prompt12 = Prompt.create(question_id: question41.id, prompt: 'Tag pictures and videos')
survey11_prompt13 = Prompt.create(question_id: question41.id, prompt: 'Create a blog')
survey11_prompt14 = Prompt.create(question_id: question41.id, prompt: 'Follow others')
survey11_prompt15 = Prompt.create(question_id: question41.id, prompt: 'Subscribe to groups and forums')
survey11_prompt16 = Prompt.create(question_id: question41.id, prompt: 'Check news updates')
survey11_prompt17 = Prompt.create(question_id: question41.id, prompt: 'Participate in online question and answering forums')

survey11_prompt18 = Prompt.create(question_id: question42.id, prompt: 'Create public forum on specific topics')
survey11_prompt19 = Prompt.create(question_id: question42.id, prompt: 'Solicit user feedback')
survey11_prompt20 = Prompt.create(question_id: question42.id, prompt: 'Develop text content for social media')
survey11_prompt21 = Prompt.create(question_id: question42.id, prompt: 'Develop images/video content for social media')
survey11_prompt22 = Prompt.create(question_id: question42.id, prompt: 'Engage others using social media')
survey11_prompt23 = Prompt.create(question_id: question42.id, prompt: 'Check up on competitors')
survey11_prompt24 = Prompt.create(question_id: question42.id, prompt: 'Use tools to manage multiple channels (e.g. Hootsuite)')

survey11_prompt25 = Prompt.create(question_id: question43.id, prompt: 'Moderate forums and disussions')
survey11_prompt26 = Prompt.create(question_id: question43.id, prompt: 'Incorporate social media as part of a larger campaign')
survey11_prompt27 = Prompt.create(question_id: question43.id, prompt: 'Develop social media plan according to business objectives')
survey11_prompt28 = Prompt.create(question_id: question43.id, prompt: 'Buy paid ads')
survey11_prompt29 = Prompt.create(question_id: question43.id, prompt: 'Actively acquire followers')
survey11_prompt30 = Prompt.create(question_id: question43.id, prompt: 'Collect data')
survey11_prompt31 = Prompt.create(question_id: question43.id, prompt: 'Use tools to view trends and analytics')
survey11_prompt32 = Prompt.create(question_id: question43.id, prompt: 'Organize events/petitons/groups')

#Survey 12: 21st Century Skills 
survey12_prompt1 = Prompt.create(question_id: question44.id, prompt: 'I use language in meaningful ways to inspire, entertain, inform, and persuade others')
survey12_prompt2 = Prompt.create(question_id: question44.id, prompt: 'I think about who my audience is when I communicate and adjust my vocabulary accordingly')
survey12_prompt3 = Prompt.create(question_id: question44.id, prompt: 'I listen actvely to others')
survey12_prompt4 = Prompt.create(question_id: question44.id, prompt: 'When speaking with other people, I think about areas of agreement as well as disagreement')
survey12_prompt5 = Prompt.create(question_id: question44.id, prompt: 'I respect others\' ideas even if I disagree with them')
survey12_prompt6 = Prompt.create(question_id: question44.id, prompt: 'I communicate my ideas effectively and explain my opinions clearly')
survey12_prompt7 = Prompt.create(question_id: question44.id, prompt: 'I support my opinions with credible evidence')

survey12_prompt8 = Prompt.create(question_id: question45.id, prompt: 'I recognize that large problems or projects may not have clear or simple solutions')
survey12_prompt9 = Prompt.create(question_id: question45.id, prompt: 'When I do not solve a problem right away, I take a different perspective and try again')
survey12_prompt10 = Prompt.create(question_id: question45.id, prompt: 'I can think of lots of new ideas to solve the same problem')
survey12_prompt11 = Prompt.create(question_id: question45.id, prompt: 'I prefer working with others because exchanging ideas helps me think of more ideas')
survey12_prompt12 = Prompt.create(question_id: question45.id, prompt: 'I look at situations and processes from a variety of viewpoints in order to indentify problems')
survey12_prompt13 = Prompt.create(question_id: question45.id, prompt: 'I evaluate all possible solutions using criteria of practicality, efficiency, and elegance to choose the best solution')
survey12_prompt14 = Prompt.create(question_id: question45.id, prompt: 'I think ahead in a project to anticipate and avoid possible problems')

survey12_prompt15 = Prompt.create(question_id: question46.id, prompt: 'I set goals independently')
survey12_prompt16 = Prompt.create(question_id: question46.id, prompt: 'I can organize competing priorites')
survey12_prompt17 = Prompt.create(question_id: question46.id, prompt: 'I persevere when things are tough')
survey12_prompt18 = Prompt.create(question_id: question46.id, prompt: 'I ask others for feedback and advice')
survey12_prompt19 = Prompt.create(question_id: question46.id, prompt: 'I consider others\' ideas seriously in thinking about my own work')
survey12_prompt20 = Prompt.create(question_id: question46.id, prompt: 'I seek out new experiences without worrying about what others think of me or whether I\'ll make mistakes')
survey12_prompt21 = Prompt.create(question_id: question46.id, prompt: 'I am willing to voice and support an opinion even if it wil be unpopular with my peers')

survey12_prompt22 = Prompt.create(question_id: question47.id, prompt: 'I am always punctual with good attendance')
survey12_prompt23 = Prompt.create(question_id: question47.id, prompt: 'I always think of questions to ask and do so when appropriate')
survey12_prompt24 = Prompt.create(question_id: question47.id, prompt: 'I carry myself in a professional manner')
survey12_prompt25 = Prompt.create(question_id: question47.id, prompt: 'I consistently manage time and resources in an efficient manner to achieve what I need to get done')
survey12_prompt26 = Prompt.create(question_id: question47.id, prompt: 'I use a variety of tools and techniques')
survey12_prompt27 = Prompt.create(question_id: question47.id, prompt: 'I always communicate with my coworkers if I run into problems')

#---- Template ----
##Survey #: Title 
#survey#_prompt# = Prompt.create(question_id: question#.id, prompt: '')
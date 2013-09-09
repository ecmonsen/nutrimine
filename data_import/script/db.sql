
create table FoodDescription26 (
	NDB_No varchar(5),
	FdGrp_Cd varchar(4),
	Long_Desc varchar(200),
	Shrt_Desc varchar(60),
	ComName varchar(100),
	ManufacName varchar(65),
	Survey varchar(1),
	Ref_desc varchar(135),
	Refuse int,
	SciName varchar(65),
	N_Factor numeric(4,2),
	Pro_Factor numeric(4,2),
	Fat_Factor numeric(4,2),
	CHO_Factor numeric(4,2),

  PRIMARY KEY (NDB_No));

create table FoodGroup (
	FdGrp_Cd varchar(4),
	FdGrp_Desc varchar(60),

  PRIMARY KEY (FdGrp_Cd));

create table LanguaLFactor (
	NDB_No varchar(5),
	Factor_Code varchar(5));

create table LanguaLFactorsDescription (
	Factor_Code varchar(5),
	Description varchar(140));

create table NutrientData (
	NDB_No varchar(5),
	Nutr_No varchar(3),
	Nutr_Val numeric(10,3),
	Num_Data_Pts int,
	Std_Error numeric(8,3),
	Src_Cd varchar(2),
	Deriv_Cd varchar(4),
	Ref_NDB_No varchar(5),
	Add_Nutr_Mark varchar(1),
	Num_Studies int,
	Min numeric(10,3),
	Max numeric(10,3),
	DF int,
	Low_EB numeric(10,3),
	Up_EB numeric(10,3),
	Stat_cmt varchar(10),
	CC varchar(1));

create table NutrientDefinition (
	Nutr_No varchar(3),
	Units varchar(7),
	Tagname varchar(20),
	NutrDesc varchar(60),
	Num_Dec varchar(1),
	SR_Order int,

  PRIMARY KEY(Nutr_No));

create table SourceCode (
	Src_Cd varchar(2),
	SrcCd_Desc varchar(60));

create table DataDerivationCode (
	Deriv_Cd varchar(4),
	Deriv_Desc varchar(120));

create table Weight (
	NDB_No varchar(5),
	Seq varchar(2),
	Amount numeric(5,3),
	Msre_Desc varchar(80),
	Gm_Wgt numeric(7,1),
	Num_Data_Pts int,
	Std_Dev numeric(7,3));

create table Footnote (
	NDB_No varchar(5),
	Footnt_No varchar(4),
	Footnt_Typ varchar(1),
	Nutr_No varchar(3),
	Footnt_Txt varchar(200));

create table SourcesofDataLink (
	NDB_No varchar(5),
	Nutr_No varchar(3),
	DataSrc_ID varchar(6));

create table SourcesofDataData (
	Src_ID varchar(6),
	Authors varchar(255),
	Title varchar(255),
	Year varchar(4),
	Journal varchar(135),
	Vol_City varchar(16),
	Issue_State varchar(5),
	Start_Page varchar(5),
	End_Page varchar(5));

create table Abbreviated (
	NDB_No varchar(5),
	Shrt_Desc varchar(60),
	Water numeric(10,2),
	Energ_Kcal int,
	Protein numeric(10,2),
	Lipid_Tot numeric(10,2),
	Ash numeric(10,2),
	Carbohydrt numeric(10,2),
	Fiber_TD numeric(10,1),
	Sugar_Tot numeric(10,2),
	Calcium int,
	Iron numeric(10,2),
	Magnesium int,
	Phosphorus int,
	Potassium int,
	Sodium int,
	Zinc numeric(10,2),
	Copper numeric(10,3),
	Manganese numeric(10,3),
	Selenium numeric(10,1),
	Vit_C numeric(10,1),
	Thiamin numeric(10,3),
	Riboflavin numeric(10,3),
	Niacin numeric(10,3),
	Panto_acid numeric(10,3),
	Vit_B6 numeric(10,3),
	Folate_Tot int,
	Folic_acid int,
	Food_Folate int,
	Folate_DFE int,
	Choline_Tot int,
	Vit_B12 numeric(10,2),
	Vit_A_IU int,
	Vit_A_RAE int,
	Retinol int,
	Alpha_Carot int,
	Beta_Carot int,
	Beta_Crypt int,
	Lycopene int,
	Lut_Zea int,
	Vit_E numeric(10,2),
	Vit_D_mcg numeric(10,1),
	Vit_D_IU int,
	Vit_K numeric(10,1),
	FA_Sat numeric(10,3),
	FA_Mono numeric(10,3),
	FA_Poly numeric(10,3),
	Cholestrl numeric(10,3),
	GmWt_1 numeric(9,2),
	GmWt_Desc1 varchar(120),
	GmWt_2 numeric(9,2),
	GmWt_Desc2 varchar(120),
	Refuse_Pct int);

create table FoodDeleted (
	NDB_No varchar(5),
	Shrt_Desc varchar(60));

create table NutrientDeleted (
	NDB_No varchar(5),
	Nutr_No varchar(3));

create table FootnoteDeleted (
	NDB_No varchar(5),
	Footnt_No varchar(4),
	Footnt_Typ varchar(1));

create view view_nutrients as 
	select fd.Long_Desc, nd.NutrDesc, nd.Units, n.Nutr_Val*(100.0-Refuse)/100.0 as Nutr_Val_Edible, SR_Order 
	from NutrientData n
	join FoodDescription fd on n.NDB_No = fd.NDB_No
  join NutrientDefinition nd on n.Nutr_No = nd.Nutr_No;

create view view_nutrients_weights as 
	select d.NDB_No, n.Nutr_No, w.Seq as Weight_Seq, d.Long_Desc, w.Amount, 
  w.Msre_Desc, w.Gm_Wgt, nd.NutrDesc,
  w.Gm_Wgt*n.Nutr_Val*(100.0-Refuse)/10000.0 as Nutr_Val_Weight, 
  nd.Units
	from NutrientData n
	join FoodDescription d on n.NDB_No = d.NDB_No
  join Weight w on n.NDB_No = w.NDB_No 
  join NutrientDefinition nd on nd.Nutr_No = n.Nutr_No;

create view view_nutrients_100g as
	select d.NDB_No, n.Nutr_No, 1000 as Weight_Seq, d.Long_Desc, 100, 'grams', 100, nd.NutrDesc,
  n.Nutr_Val*(100.0-Refuse)/100.0 as Nutr_Val_Weight, 
  nd.Units
	from NutrientData n
	join FoodDescription d on n.NDB_No = d.NDB_No
  join Weight w on n.NDB_No = w.NDB_No 
  join NutrientDefinition nd on nd.Nutr_No = n.Nutr_No;

-- This is VERY slow
create view view_nutrients_weights2 as 
  select * from view_nutrients_weights
  union
  select * from view_nutrients_100g;
  

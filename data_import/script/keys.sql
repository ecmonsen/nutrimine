-- Indexes (mostly foreign keys)
create index x_FoodGroup_FdGrp_Cd on FoodGroup(FdGrp_Cd);
create index x_LanguaLFactor_NDB_No on LanguaLFactor(NDB_No);
create index x_LanguaLFactorsDescription_Factor_Code on LanguaLFactorsDescription(Factor_Code);
create index x_NutrientData_NDB_No on NutrientData(NDB_No);
create index x_NutrientData_Nutr_No on NutrientData(Nutr_No);
create index x_NutrientDefinition_Nutr_No on NutrientDefinition(Nutr_No);
create index x_SourceCode_Src_Cd on SourceCode(Src_Cd);
create index x_DataDerivationCode_Deriv_Cd on DataDerivationCode(Deriv_Cd);
create index x_Weight_NDB_No_Seq on Weight(NDB_No, Seq);
create index x_Weight_Seq on Weight(Seq);
create index x_SourcesofDataLink_NDB_No on SourcesofDataLink(NDB_No);
create index x_SourcesofDataLink_Nutr_No on SourcesofDataLink(Nutr_No);
create index x_SourcesofDataLink_DataSrc_ID on SourcesofDataLink(DataSrc_ID);
create index x_SourcesofDataData_Src_ID on SourcesofDataData(Src_ID);
create index x_Abbreviated_NDB_No on Abbreviated(NDB_No);
create index x_FoodDeleted_NDB_No on FoodDeleted(NDB_No);
create index x_NutrientDeleted_NDB_No on NutrientDeleted(NDB_No);
create index x_FootnoteDeleted_NDB_No on FootnoteDeleted(NDB_No);   
create index x_FoodDescription_FdGrp_Cd on FoodDescription(FdGrp_Cd);
create index x_FoodDescription_NDB_No on FoodDescription(NDB_No);
create index x_Footnote_NDB_No on Footnote(NDB_No);
create index x_Footnote_Nutr_No on Footnote(Nutr_No);
create index x_NutrientData_Deriv_Cd on NutrientData(Deriv_Cd);
create index x_NutrientData_Src_Cd on NutrientData(Src_Cd);

-- Keys for search and sorting
create index x_FoodDescription_Shrt_Desc on FoodDescription(Shrt_Desc);
create index x_FoodDescription_Long_Desc on FoodDescription(Long_Desc);
create index x_NutrientDefinition_SR_Order on NutrientDefinition(SR_Order);

-- Full text search of food descriptions
create fulltext index x_fulltext_FoodDescription_Long_Desc on FoodDescription(Long_Desc);

-- "Derived" table
create index x_WeightPlus_NDB_No_Seq on WeightPlus(NDB_No, Seq);
create index x_WeightPlus_Seq on WeightPlus(Seq);


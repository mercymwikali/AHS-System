// //************************************************************************************************************************************
//                                                       //Affordable Housing Levy
// IF blnPaysAHL THEN BEGIN
//   curAHL := 0;
//   curTransBalance := 0;
//   //Get Transaction Code
//   PRTransCode.RESET;
//   PRTransCode.SETRANGE("Transaction Code", 'D002');
//   IF PRTransCode.FIND('-') THEN BEGIN
//     IF PRTransCode."Is Formula" THEN //Employee deduction
//         BEGIN
//             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PRTransCode.Formula);
//             curAHL :=ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
//             strTransDescription := PRTransCode."Transaction Name";
//           TGroup := 'STATUTORIES'; TGroupOrder := 7; TSubGroupOrder := 5;
//           fnUpdatePeriodTrans (strEmpCode, PRTransCode."Transaction Code", TGroup, TGroupOrder, TSubGroupOrder,
//            strTransDescription,curAHL, curTransBalance, intMonth,
//            intYear, '', '',SelectedPeriod,Dept,JournalAc,JournalPostAs::Credit,
//            JournalPostingType,'', PRTransCode."Coop Parameters");            
//         END;

//         IF PRTransCode."Include Employer Deduction" THEN //Employer deduction
//         BEGIN
//             PRTransCode.TESTFIELD(PRTransCode."Formula for Employer");

//             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear,PRTransCode."Formula for Employer");
//             curTransAmount := fnFormulaResult(strExtractedFrml);

//             strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, PRTransCode.Formula);
            
//             curAHL := ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
//             strTransDescription := PRTransCode."Transaction Name";

//           fnUpdateEmployerDeductions(strEmpCode, PRTransCode."Transaction Code",
//                 'EMP', 0, 0,'', curTransAmount, 0, intMonth, intYear,
//                 '', '',SelectedPeriod);
                     
//         END;
//         //***************GET AHL Relief***************************
//          // *************************************Relief Calculation*************************************************
//   CurrAHLRelief := 0;
//   IF VitalSetup."Implement AHL Relief" THEN 
//   BEGIN
//   VitalSetup.TESTFIELD("AHL Relief Percentage");
//   CurrAHLRelief := curAHL * (VitalSetup."AHL Relief Percentage"/100);
//    IF CurrAHLRelief > 0 THEN
//    BEGIN
//         curTransAmount := ROUND(CurrAHLRelief);
//         strTransDescription := 'AHL Relief';
//         TGroup := 'TAX CALCULATIONS'; TGroupOrder := 6; TSubGroupOrder := 8;
 
//         fnUpdatePeriodTrans (strEmpCode, 'AHL-RL', TGroup, TGroupOrder, TSubGroupOrder, strTransDescription,
//         curTransAmount, 0, intMonth, intYear,'','',SelectedPeriod,Dept,
//         '',JournalPostAs::Credit,JournalPostingType::" ",'',CoopParameters::none);
//    END;
//   END;
// //****************************************End Relief Calculation *******************************************************
//         //**************END AHL Relief****************************
//   END;
// END;


// //************************************************************************************************************************************
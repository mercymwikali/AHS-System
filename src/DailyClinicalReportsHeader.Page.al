namespace PTL.HMIS;
using PTL.HMISBC;
using System.Reflection;
using Microsoft.Sales.Customer;

page 52203188 "Daily Clinical Reports Header"
{
    ApplicationArea = All;
    Caption = 'Daily Clinical Reports Header';
    PageType = Card;
    SourceTable = "Daily Clinical Reports Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    MultiLine = true;
                }
                field("Total Bed Occupancy"; Rec."Total Bed Occupancy")
                {
                    ToolTip = 'Specifies the value of the Total Bed Occupancy field.', Comment = '%';
                    Editable = false;
                }
                field("Total Admissions"; Rec."Total Admissions")
                {
                    ToolTip = 'Specifies the value of the Total Admissions field.', Comment = '%';
                    Editable = false;
                }
                field("Total MAKL Occupancy"; Rec."Total MAKL Occupancy")
                {
                    ToolTip = 'Specifies the value of the Total MAKL Occupancy field.', Comment = '%';
                    Editable = false;
                }
                field("Total MAKL %"; Rec."Total MAKL %")
                {
                    ToolTip = 'Specifies the value of the Total MAKL % field.', Comment = '%';
                    Editable = false;
                }
                field("Total SHA Occupancy"; Rec."Total SHA Occupancy")
                {
                    ToolTip = 'Specifies the value of the Total SHA Occupancy field.', Comment = '%';
                    Editable = false;
                }
                field("Total SHA %"; Rec."Total SHA %")
                {
                    ToolTip = 'Specifies the value of the Total SHA % field.', Comment = '%';
                    Editable = false;
                }
                field("Total Acute"; Rec."Total Acute")
                {
                    ToolTip = 'Specifies the value of the Total Acute field.', Comment = '%';
                    Editable = false;
                }
                field("Total IP C.P"; Rec."Total IP C.P")
                {
                    ToolTip = 'Specifies the value of the Total IP C.P field.', Comment = '%';
                    Editable = false;
                }
                field("Total IP C.P %"; Rec."Total IP C.P %")
                {
                    ToolTip = 'Specifies the value of the Total IP C.P % field.', Comment = '%';
                    Editable = false;
                }
                field("Total OP Visits"; Rec."Total OP Visits")
                {
                    ToolTip = 'Specifies the value of the Total OP Visits field.', Comment = '%';
                    Editable = false;
                }
                field("Total OP C.P"; Rec."Total OP C.P")
                {
                    ToolTip = 'Specifies the value of the Total OP C.P field.', Comment = '%';
                    Editable = false;
                }
                field("Total OP C.P %"; Rec."Total OP C.P %")
                {
                    ToolTip = 'Specifies the value of the Total OP C.P % field.', Comment = '%';
                    Editable = false;
                }
            }
            group(BreakDown)
            {
                ShowCaption = false;
                part(BreakdownByDoctor; "Doctor Clinical Reports")
                {
                    ApplicationArea = All;
                    Editable = false;
                    SubPageLink = "Discharge Date Filter" = field("Discharge Date Filter"), "IP Date Filter" = field("Date Filter"), "Date Filter" = field(Date);
                    SubPageView = where(Resident = filter(true));
                }
                part(BreakDownByInsurance; "Daily Clinical Report Ins.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    SubPageLink = "Date Filter" = field(Date);
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PopulateReport)
            {
                Caption = 'Generate Clinical Day Report';
                ApplicationArea = All;
                Image = TransferToLines;
                ToolTip = 'Executes the PopulateReport action.';
                trigger OnAction()
                var
                    PatientManagement: Codeunit "Patient Management";
                begin
                    PatientManagement.CalcClinicalDayStats(Rec.Date);
                    // PatientManagement.UpdateDischargeDates();
                end;
            }
            action(BreakDownReport)
            {
                Caption = 'Clinical BreakDown';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                // RunObject = report "Daily Clinical Breakdown";
                ToolTip = 'Executes the Clinical BreakDown action.';
                trigger OnAction()
                var
                    PatientManagement: Codeunit "Patient Management";
                begin
                    PatientManagement.FnSendDailyClinicalReport(Rec.Date);
                end;
            }
            action(BreakdownTest)
            {
                ApplicationArea = All;
                ToolTip = 'Executes the BreakdownTest action.';
                trigger OnAction()
                var
                    DailyClinicalReportsHeader: Record "Daily Clinical Reports Header";
                    HMSAdmissionFormHeader: Record "HMS Admission Form Header";
                    HMSPatientCharges: Record "HMS Patient Charges";
                    SMSTemplatesTable: Record "SMS Templates Table";
                    ClinicalReportRecepients: Record "Clinical Report Recepients";
                    SMSIntegrationManagement: Codeunit "SMS Integration Management";
                    SMSRenderCodeunit: Codeunit SMSRenderCodeunit;
                    PatientManagement: Codeunit "Patient Management";
                    DocCount: Integer;
                    Blocks: Dictionary of [Text, List of [Dictionary of [Text, Text]]];
                    OPDoctorList: List of [Dictionary of [Text, Text]];
                    IPDoctorList: List of [Dictionary of [Text, Text]];
                    OPPsychologistsList: List of [Dictionary of [Text, Text]];
                    AdmissionsList: List of [Dictionary of [Text, Text]];
                    GeneratedText: Text;
                    MainVars: Dictionary of [Text, Text];
                    Msg: Text;
                    OneOPDoctor: Dictionary of [Text, Text];
                    OneIPDoctor: Dictionary of [Text, Text];
                    OneOPPsychologist: Dictionary of [Text, Text];
                    OneAdmittingDoctor: Dictionary of [Text, Text];
                    AdmissionCounter: Integer;
                begin
                    GeneratedText := '';
                    Msg := '';
                    // Message(DailyClinicalReportsHeader.Remarks);
                    SMSTemplatesTable.Reset();
                    SMSTemplatesTable.SetRange(Active, true);
                    if SMSTemplatesTable.FindFirst() then
                        Msg := SMSTemplatesTable."Template Text";

                    // Fill Template Variables -- Predefined Values 
                    // Use Dictionary Key:Value Pairs to store variables
                    // 1. Main Variables

                    MainVars.Add('ReportDate', Format(Rec.Date, 0, '<Day,2>-<Month Text>-<Year4>'));
                    MainVars.Add('TotalInPatients', Format(Rec."Total Bed Occupancy"));
                    MainVars.Add('TotalMAKL', Format(Rec."Total MAKL Occupancy"));
                    MainVars.Add('TotalMAKLHold', Format(Rec."Total MAKL %"));
                    MainVars.Add('TotalSHA', Format(Rec."Total SHA Occupancy"));
                    MainVars.Add('TotalSHAHold', Format(Rec."Total SHA %"));
                    MainVars.Add('TotalAccuteOccupancy', Format(Rec."Total Acute"));
                    MainVars.Add('TotalInPatientsByCP', Format(Rec."Total IP C.P"));
                    MainVars.Add('TotalInpatientsByCPPercentage', Format(Rec."Total IP C.P %"));
                    MainVars.Add('TotalOutPatientsByCP', Format(Rec."Total IP C.P"));
                    MainVars.Add('TotalOutPatientsByCPPercentage', Format(Rec."Total OP C.P %"));
                    MainVars.Add('TotalOPByCHGPsychologists', '');
                    MainVars.Add('TotalOPByCHGPsychologistsPercentage', '');
                    MainVars.Add('TotalByExternalPsychiatrists', '');
                    MainVars.Add('TotalByExternalPsychologists', '');
                    MainVars.Add('TotalWalkinLabVisits', '');
                    MainVars.Add('TotalWalkinPharmacyVisits', '');
                    MainVars.Add('TotalAdmissions', Format(Rec."Total Admissions"));
                    MainVars.Add('TotalOPVisits', Format(Rec."Total OP Visits"));

                    HMSSetupDoctor.Reset();
                    HMSSetupDoctor.SetRange(Resident, true);
                    HMSSetupDoctor.SetFilter("Date Filter", '=%1', Rec.Date);
                    HMSSetupDoctor.SetAutoCalcFields("Total OP", "Total IP");
                    if HMSSetupDoctor.FindSet() then
                        repeat

                            // 2. Clear Blocks for repeating variables
                            Clear(OneOPDoctor);
                            Clear(OneIPDoctor);
                            Clear(OneOPPsychologist);
                            Clear(AdmissionsList);

                            DocCount := 0;

                            // Get Admissions on the report Date
                            HMSPatientCharges.Reset();
                            HMSPatientCharges.SetRange(HMSPatientCharges.Code, 'ADMISSION FEE');
                            HMSPatientCharges.SetRange(Date, Rec.Date);
                            if HMSPatientCharges.FindSet() then
                                repeat
                                    HMSAdmissionFormHeader.Reset();
                                    HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatientCharges."Visit No");
                                    HMSAdmissionFormHeader.SetRange(Doctor, HMSSetupDoctor."Doctor ID");
                                    if not HMSAdmissionFormHeader.IsEmpty() then begin
                                        OneAdmittingDoctor.add('AdmittingDoctorName', HMSSetupDoctor."Doctors Name");
                                        if HMSPatientCharges."Insurance Name" <> '' then
                                            OneAdmittingDoctor.add('InsuranceName', HMSPatientCharges."Insurance Name")
                                        else
                                            OneAdmittingDoctor.add('InsuranceName', 'CASH');
                                        AdmissionsList.Add(OneAdmittingDoctor);
                                    end;
                                until HMSPatientCharges.Next() = 0;

                            // Get Active Admissions on that Date
                            HMSPatientCharges.Reset();
                            HMSPatientCharges.SetRange(HMSPatientCharges."Transaction Type", 'BED');
                            HMSPatientCharges.SetRange(Date, Rec.Date);
                            HMSPatientCharges.SetAutoCalcFields("Insurance Name");
                            if HMSPatientCharges.FindSet() then
                                repeat
                                    HMSAdmissionFormHeader.Reset();
                                    HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatientCharges."Visit No");
                                    HMSAdmissionFormHeader.SetRange(Doctor, HMSSetupDoctor."Doctor ID");
                                    if not HMSAdmissionFormHeader.IsEmpty() then
                                        DocCount += 1;

                                until HMSPatientCharges.Next() = 0;

                            // Add The List of Corporate Psychologists and Phsychiatrists
                            if HMSSetupDoctor.Specialization = 'PSYCHOLOGIST' then begin
                                OneOPPsychologist.Add('PsychologistsName', HMSSetupDoctor."Doctors Name");
                                OneOPPsychologist.Add('PsychologistsOPCount', Format(HMSSetupDoctor."Total OP"));
                                // Add the Single Doctor to the Doctors List
                                OPDoctorList.Add(OneOPDoctor);

                            end else
                                if HMSSetupDoctor.Specialization = 'PSYCHIATRIST' then begin
                                    OneOPDoctor.Add('OPDoctorName', HMSSetupDoctor."Doctors Name");
                                    OneOPDoctor.Add('OPDoctorsCount', Format(HMSSetupDoctor."Total OP"));
                                    OneIPDoctor.Add('IPDoctorName', HMSSetupDoctor."Doctors Name");
                                    OneIPDoctor.Add('IPDoctorsCount', Format(DocCount));
                                    // Add the Single Doctor to the Doctors List
                                    OPDoctorList.Add(OneOPDoctor);
                                    IPDoctorList.Add(OneIPDoctor);
                                end;
                        until HMSSetupDoctor.Next() = 0;

                    // 3. Individual Variables for each block
                    Blocks.Add('IPDoctors', IPDoctorList);
                    Blocks.Add('OPDoctors', OPDoctorList);
                    Blocks.Add('OPPsychologists', OPPsychologistsList);
                    Blocks.Add('IPDoctorsAdmission', AdmissionsList);

                    // 4. Render the SMS Message
                    GeneratedText := SMSRenderCodeunit.RenderSMSMessage(Msg, MainVars, Blocks);

                    // 5. Send the SMS Message.
                    Message(GeneratedText);
                    // // TODO: Store the message in a buffer table
                    // if ClinicalReportRecepients.FindSet() then
                    //     repeat
                    //         SMSIntegrationManagement.SendSMS(ClinicalReportRecepients."Phone No", Msg)
                    //     until ClinicalReportRecepients.Next() = 0;

                end;
            }
        }
    }
    var
        Customer: Record Customer;
        HMSSetupDoctor: Record "HMS Setup Doctor";

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Date Filter", '..%1', Rec.Date);
        Rec.SETFILTER("Discharge Date Filter", '%1..', Rec.Date);
    end;

    procedure GenerateSMSMessage(TemplateText: Text; Variables: Dictionary of [Text, Text]): Text
    var
        TemplateKey: Text;
        Value: Text;
    begin
        foreach TemplateKey in Variables.Keys() do begin
            Value := Variables.Get(TemplateKey);
            TemplateText := TemplateText.Replace('{{' + TemplateKey + '}}', Value);
        end;
        exit(TemplateText);
    end;
}

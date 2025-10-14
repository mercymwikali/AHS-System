report 52202691 "HMS Discharge Summary Dialysis"
{
    Caption = 'HMS Discharge Summary Dialysis';
    dataset
    {
        dataitem(HMSDialysisFormHeader; "HMS Therapy Form Header")
        {
            column(Branch; Branch)
            {
            }
            column(Closed; Closed)
            {
            }
            column(Completed; Completed)
            {
            }
            column(DialysisDate; "Therapy Date")
            {
            }
            column(DialysisMachineCode; "Therapy Type")
            {
            }
            column(DialysisMachineName; "Therapy Description")
            {
            }
            column(DialysisNotes; "Therapy Notes")
            {
            }
            column(DialysisRemarks; "Therapy Remarks")
            {
            }
            column(DialysisSession; "Therapy Session")
            {
            }
            column(DialysisTime; "Therapy Time")
            {
            }
            column(DialysisUserID; "Therapy User ID")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(LinkNo; "Link No.")
            {
            }
            column(LinkType; "Link Type")
            {
            }
            column(NextAppointmentDate; "Next Appointment Date")
            {
            }
            column(No; "Treatment No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(RelativeNo; "Relative No.")
            {
            }
            column(Search_Name; Search_Name)
            {
            }
            column(Status; Status)
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
            column(TreatmentNotes; "Treatment Notes")
            {
            }
            column(Type; "Type")
            {
            }
            dataitem("HMSDischargeSummary"; "HMS Discharge Summary")
            {
                DataItemLink = "Discharge Code" = field("Treatment No.");

                column(BloodFlowRate_HMSDischargeSummary; "Blood Flow Rate")
                {
                }
                column(Bp_HMSDischargeSummary; Bp)
                {
                }
                column(Description_HMSDischargeSummary; Description)
                {
                }
                column(Diagnosis_HMSDischargeSummary; Diagnosis)
                {
                }
                column(DialysisFlowRate_HMSDischargeSummary; "Dialysis Flow Rate")
                {
                }
                column(DischargeCode_HMSDischargeSummary; "Discharge Code")
                {
                }
                column(Duration_HMSDischargeSummary; "Duration")
                {
                }
                column(HeartRate_HMSDischargeSummary; "Heart Rate")
                {
                }
                column(HeparinUsed_HMSDischargeSummary; "Heparin Used")
                {
                }
                column(LineNo_HMSDischargeSummary; "Line No")
                {
                }
                column(MaintenanceDone_HMSDischargeSummary; "Maintenance Done")
                {
                }
                column(MembraneSize_HMSDischargeSummary; "Membrane Size")
                {
                }
                column(PatientCondition_HMSDischargeSummary; "Patient Condition")
                {
                }
                column(PatientNo_HMSDischargeSummary; PatientNo)
                {
                }
                column(PostDialysisWeight_HMSDischargeSummary; "Post Dialysis Weight")
                {
                }
                column(PreDialysisWeight_HMSDischargeSummary; "Pre Dialysis Weight")
                {
                }
                column(ReviewDate_HMSDischargeSummary; "Review Date")
                {
                }
                column(SPO2_HMSDischargeSummary; SPO2)
                {
                }
                column(TreatmentNo_HMSDischargeSummary; "Admission No")
                {
                }
                column(Type_HMSDischargeSummary; "Type")
                {
                }
                column(UFAchieved_HMSDischargeSummary; "UF Achieved")
                {
                }
                column(UFGoal; UFGoal)
                {
                }
                column(Sign1; Hremp.Signature)
                {
                }
                column(Sign2; UserRec2.Signature)
                {
                }
                column(Age; Age)
                {
                }
                column(Gender; Gender)
                {
                }
                column(BranchName; BranchName)
                {
                }
                column(Access; Access)
                {
                }
                column(Timeout; Timeout)
                {
                }
                column(NurseName; NurseName)
                { }

                trigger OnAfterGetRecord()
                begin
                    DialH.Reset();
                    DialH.SetRange(DialH.TreatmentNo, HMSDischargeSummary."Admission No");
                    if DialH.Find('-') then begin
                        UFGoal := DialH."UF Goal";
                        Timeout := DialH."Dialysis End Time";
                        Access := DialH.Access;
                        if HmsPat.Get(DialH.PatientNo) then begin
                            Age := HmsPat."Age in Years";
                            Gender := HmsPat.Gender;
                            BranchName := HmsPat."Global Dimension 1 Code";
                        end;

                        if Hremp.Get(DialH."Nurse Disconnecting Dialysis") then
                            NurseName := Hremp."First Name" + ' ' + Hremp."Last Name";
                        Hremp.CalcFields(Signature);
                        if UserRec1.Get(Hremp."User ID") then
                            UserRec1.CalcFields(Signature);
                    end else
                        Error('Haemodialysis chart could not be found!');
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        DialH: Record "Dialysis Patient Info";
        HmsPat: Record "HMS Patient";
        Hremp: Record "HR-Employee";
        UserRec1: Record "User Setup";
        UserRec2: Record "User Setup";
        Timeout: DateTime;
        Age: Integer;
        Access: Option ,Fistula,"Temporary Catheter","Permanent Catheter";
        Gender: option " ",Male,Female;
        // Signat: blob;
        BranchName: Text;
        NurseName: Text;
        UFGoal: Text;
}

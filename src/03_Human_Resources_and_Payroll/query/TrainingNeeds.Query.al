namespace PTL.HMISBC;

query 85107 "Training Needs"
{
    Caption = 'Training Needs';
    QueryType = Normal;
    
    elements
    {
        dataitem(HRTrainingNeedsAnalysis; "HR Training Needs Analysis")
        {
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column("Duration"; "Duration")
            {
            }
            column(Department; Department)
            {
            }
            column(Closed; Closed)
            {
            }
            column(TrainingType; "Training Type")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}

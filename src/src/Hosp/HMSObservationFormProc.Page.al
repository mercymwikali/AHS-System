Page 52202698 "HMS Observation Form Proc"
{
    PageType = ListPart;
    SourceTable = "HMS Observation Form Line Proc";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Chief Complaints"; RichTextContent)
                {
                    ToolTip = 'Specifies the value of the Chief Complaints field.';
                    Caption = 'Chief Complaints';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    trigger OnValidate()
                    begin
                        setChiefComplaints();
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                    Visible = false;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.';
                    Visible = false;
                }
                field("Blood Pressure"; "Blood Pressure")
                {
                    ToolTip = 'Specifies the value of the Blood Pressure field.';

                }
                field(Temperature; Rec.Temperature)
                {
                    ToolTip = 'Specifies the value of the Temperature field.';
                }
                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the value of the Height field.';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field(BMI; Rec.BMI)
                {
                    ToolTip = 'Specifies the value of the BMI field.';
                }
                field(SP02; Rec.SP02)
                {
                    ToolTip = 'Specifies the value of the SP02 field.';
                }
                field("Pulse Rate"; Rec."Pulse Rate")
                {
                    ToolTip = 'Specifies the value of the Pulse Rate field.';
                }
                field(Pain; Rec.Pain)
                {
                    ToolTip = 'Specifies the value of the Pain field.';
                }
                field("Blood Sugars"; Rec."Blood Sugars")
                {
                    ToolTip = 'Specifies the value of the Blood Sugars field.';
                }
            }
        }
    }

    actions
    {
    }
    var
        RichTextContent: Text;
    trigger OnAfterGetRecord()
    begin
        getChiefComplaints();
    end;

    local procedure setChiefComplaints()
    var
        outStream: OutStream;
    begin
        Rec."Chief Complaints".CreateOutStream(outStream);
        outStream.Write(RichTextContent);
        Rec.Modify();

    end;

    local procedure getChiefComplaints()
    var
        instrStream: InStream;
    begin
        Rec.CalcFields("Chief Complaints");
        Rec."Chief Complaints".CreateInStream(instrStream);
        instrStream.Read(RichTextContent);
    end;
}

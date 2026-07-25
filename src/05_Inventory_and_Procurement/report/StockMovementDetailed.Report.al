report 85153 "Stock Movement Detailed"
{
    Caption = 'Stock Movement Detailed';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/StockMovementDetailed.rdl';

    dataset
    {
        dataitem(ILE; "Item Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Item No.", "Item Category Code", "Location Code";

            column(Posting_Date; "Posting Date") { }
            column(Item_No_; "Item No.") { }
            column(Item_Description; Description) { }
            column(Location_Code; "Location Code") { }
            column(Entry_Type; "Entry Type") { }
            column(Source_Type; "Source Type") { }
            column(Source_No_; "Source No.") { }
            column(Document_No_; "Document No.") { }
            column(Transaction_Description; TransactionDesc) { }
            column(Quantity; Quantity) { }
            column(CostAmountActual_ILE; "Cost Amount (Actual)")
            {
            }
            
            column(Total_Value; TotalValue) { }
            column(Running_Balance; RunningBalance) { }

            trigger OnAfterGetRecord()
            var
                ValueEntry: Record "Value Entry";
            begin
                // Calculate total value from Value Entries
                ValueEntry.SetRange("Item Ledger Entry No.", "Entry No.");
                if ValueEntry.FindSet() then
                    repeat
                        TotalValue += ValueEntry."Cost Amount (Actual)";
                    until ValueEntry.Next() = 0;

                // Running balance = prior balance + this line qty
                RunningBalance += Quantity;

                // Map transaction description
                TransactionDesc := GetTransactionDescription("Entry Type", ILE."Source Type");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartDate; StartDate) { ApplicationArea = All; }
                field(EndDate; EndDate) { ApplicationArea = All; }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        TotalValue: Decimal;
        RunningBalance: Decimal;
        TransactionDesc: Text[100];

    local procedure GetTransactionDescription(EntryType: Enum "Item Ledger Entry Type"; SourceType: Enum "Analysis Source Type"): Text[100]
    begin
        case EntryType of
            EntryType::Purchase:
                exit('Procurement');
            EntryType::Sale:
                exit('Dispensed / Issued');
            EntryType::Transfer:
                exit('Transfer');
            EntryType::"Positive Adjmt.":
                exit('Adjustment (In)');
            EntryType::"Negative Adjmt.":
                exit('Adjustment (Out)');
        end;

        case SourceType of
            SourceType::Customer:
                exit('Dispensed to Patient');
            SourceType::Vendor:
                exit('Purchase from Vendor');
            SourceType::"Item":
                exit('Journal Movement');
        end;

        exit('Other');
    end;
}

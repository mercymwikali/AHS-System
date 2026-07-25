// pageextension 52202452 "Reversal Entries" extends "Reverse Entries"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         modify(Reverse)
//         {
//             trigger OnBeforeAction()
//             var
//                 UserSetup: Record "User Setup";
//             begin
//                 if UserSetup.get(Database.UserId) then begin
//                     if UserSetup."Allow Transaction Reversal" = false then
//                         error('Please note that you dont have the rights to create items');
//                 end else
//                     error('Please note that you dont have the rights to create items');
//             end;

//             trigger onAfterAction()
//             var
//                 HMSPatCharges: Record "HMS Patient Charges";
//             begin
//                 HMSPatCharges.reset();
//                 HMSPatCharges.setrange(code, Rec."Document No.");
//                 if HMSPatCharges.find('-') then
//                     repeat
//                         HMSPatCharges.Posted := false;
//                         HMSPatCharges.Reversed := true;
//                         //HMSPatCharges."Total Amount" := 0;
//                         HMSPatCharges."User ID" := Database.UserId;
//                         HMSPatCharges.modify();
//                     until HMSPatCharges.next() = 0;
//             end;
//         }
//         modify("Reverse and &Print")
//         {
//             trigger OnBeforeAction()
//             var
//                 UserSetup: Record "User Setup";
//             begin
//                 if UserSetup.get(Database.UserId) then begin
//                     if UserSetup."Allow Transaction Reversal" = false then
//                         error('Please note that you dont have the rights to create items');
//                 end else
//                     error('Please note that you dont have the rights to create items');
//             end;

//             trigger OnAfterAction()
//             var
//                 HMSPatCharges: Record "HMS Patient Charges";
//             begin
//                 HMSPatCharges.reset();
//               //  HMSPatCharges.setrange(code, Rec."Document No.");
//                 if HMSPatCharges.find('-') then
//                     repeat
//                         HMSPatCharges.Posted := false;
//                         HMSPatCharges.Reversed := true;
//                         //HMSPatCharges."Total Amount" := 0;
//                         HMSPatCharges."User ID" := Database.UserId;
//                         HMSPatCharges.modify();
//                     until HMSPatCharges.next() = 0;
//             end;
//         }
//     }
// }
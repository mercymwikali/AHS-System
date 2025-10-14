namespace PTL.HMISBC;

using System.Environment.Configuration;
using System.Security.User;

tableextension 52202455 "Custom User Settings " extends "User Settings"
{
    trigger OnModify()
    var
        UserRec: record "User Setup";
    begin

        if UserRec.get(database.UserId) then
            if not UserRec."Can Change Profile" then
                Error('Please note that you dont have the rights to change your Profile!');

    end;
}

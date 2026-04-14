namespace PTL.HMISBC;

codeunit 85012 APIResponseBuilder
{
    Subtype = Normal;

    procedure Success(Message: Text; EncounterNo: Code[20]): Text
    begin
        exit(BuildResponse(true, '', Message, EncounterNo));
    end;

    procedure Error(Code: Text; Message: Text): Text
    begin
        exit(BuildResponse(false, Code, Message, ''));
    end;

    procedure Custom(Success: Boolean; Code: Text; Message: Text; EncounterNo: Code[20]): Text
    begin
        exit(BuildResponse(Success, Code, Message, EncounterNo));
    end;

    local procedure BuildResponse(Success: Boolean; Code: Text; Message: Text; EncounterNo: Code[20]): Text
    var
        Resp: JsonObject;
        OutText: Text;
    begin
        Resp.Add('success', Success);
        Resp.Add('code', Code);
        Resp.Add('message', Message);
        Resp.Add('encounterNo', EncounterNo);
        Resp.WriteTo(OutText);
        exit(OutText);
    end;
}

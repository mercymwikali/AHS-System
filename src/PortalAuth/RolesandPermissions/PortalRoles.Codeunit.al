namespace PTL.HMISBC;

codeunit 52202465 "Portal Roles"
{
    procedure ToCamelCase(InputText: Text): Text[30]
    var
        Words: List of [Text];
        Word: Text;
        CamelText: Text[30];
        i: Integer;
    begin
        // Split text by spaces
        Words := InputText.Split(' ');
        CamelText := '';

        for i := 1 to Words.Count do begin
            Word := Words.Get(i);

            if i = 1 then
                CamelText += LowerCase(Word) // first word: lowercase
            else
                CamelText += UpperCase(CopyStr(Word, 1, 1)) + LowerCase(CopyStr(Word, 2)); // capitalize first letter, rest lowercase
        end;

        exit(CamelText);
    end;
}

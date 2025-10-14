query 52202437 "Email Sender"
{
    QueryType = Normal;

    elements
    {
        dataitem(Email_Sender; "Email Sender")
        {
            column(Code; Code)
            {
            }
            column(Category; Category)
            {
            }
            column(Message_Desc_1; "Message Desc 1")
            {
            }
            column(Message_Desc_2; "Message Desc 2")
            {
            }
            column(Message_Desc_3; "Message Desc 3")
            {
            }
            column(Message_Desc_4; "Message Desc 4")
            {
            }
            column(Sender; Sender)
            {
            }
            column(Sent_; "Sent?")
            {
            }
            column(Subject; Subject)
            {
            }
            column(Date_Created; "Date Created")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
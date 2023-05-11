Program Register_Event; ///User register
{$MODE DELPHI}
uses
 Sysutils,DateUtils;

const
  C_FNAME = 'Users.txt';

var
    RegisterUserFile: Textfile;
    Date : TDateTime;
    MenuTemp: Integer;
    TextLineCounter: Integer;
    RegisterUserFileCharTemp: Char;
procedure RegisterUser(ID:Integer; Name:String; GradYear:Integer ;Sex: Char; Age:Integer; Job:String ; ParentParticipant:Integer); /// IsOther : to check if there are other participants
begin
    try
        reset(RegisterUserFile);
        append(RegisterUserFile);
        writeln(RegisterUserFile,ID);
        writeln(RegisterUserFile,Name);
        writeln(RegisterUserFile,GradYear);
        writeln(RegisterUserFile,Sex);
        writeln(RegisterUserFile,Age);
        writeln(RegisterUserFile,Job);
        writeln(RegisterUserFile,ParentParticipant);
        CloseFile(RegisterUserFile);
    except
        writeln('error');
    end;
end;

function FindID(ID:integer) : integer;
begin
    
end;

procedure Output();
begin
end;

function NewID():integer;
var
    i,LastID:integer;
    RegisterUserFileTemp:integer;
begin
    if TextLineCounter=0 then
    NewID:= 00001
    else
    begin
    for i:=TextLineCounter to TextLineCounter-6 do
    begin
        ReadLn(RegisterUserFile, RegisterUserFileTemp);
    end;
    LastID:=RegisterUserFileTemp;
    NewID:=LastID+1;
    writeln(NewID)
    end;
    
end;

procedure RegisterUserAsking();
var
    Name:String; 
    GradYear:Integer;
    Sex: Char;
    Age:Integer; 
    Job:String; 
    AskIsOthers:Char; 
    NumbersOfOthers:Integer;
    confirm: Char;
    ID: Integer;
    ParentParticipant: Integer;
begin
    ParentParticipant:= -1;
    writeln('Please input Name: (In English , ASCII supported)') ;
    readln(Name);
    
    writeln('Please input Graduation Year: (In integer)') ;
    readln(GradYear);
    Date := Now;
    while (GradYear > YearOf(Date)) do
    begin
        writeln('Wrong Year , PLease try again');
        writeln('Please input Graduation Year: (In integer)') ;
        readln(GradYear);
    end;
    
    writeln('Please input sex: ("F":Female , "M":Male , "N":Not Stated)');
    readln(Sex);
    while not ((Sex = 'F') or (Sex = 'M') or (Sex = 'N')) do
    begin
        writeln('Wrong input , please try again');
        writeln('Please input sex: ("F":Female , "M":Male , "N":Not Stated)');
        readln(Sex);
    end;
    
    writeln('Please input your age: (In integer)');
    readln(age);
    
    writeln('Please input your job: (Please Make sure your format is correct (e.g. System Analysis ,you should input "SYSTEM_ANALYSIS"))');
    readln(Job);
    
    writeln('Do you bring other participants?If you are the register leader , please type "y". if you are not the register leader but you are member of the register leader, please type "o".If you are join in alone please type "n"');
    readln(AskIsOthers);
    while not ((AskIsOthers = 'y') or (AskIsOthers = 'n') or (AskIsOthers = 'o')) do
    begin
        writeln('worng input, please try again');
        writeln('Do you bring other participants?If you are the register leader , please type "y". if you are not the register leader but you are member of the register leader, please type "o".If you are join in alone please type "n"');
        readln(AskIsOthers);
    end;
    if AskIsOthers = 'o' then
    begin
        writeln('Please input the register leader ID');
        readln(ParentParticipant);
        while (FindID(ParentParticipant)=-1) do
        begin
            writeln('Invalid ID , Please try again');
            writeln('Please input the register leader ID');
            readln(ParentParticipant);
        end;
    end;
    
    writeln('Plase confirm: ');
    writeln('Name: ' , Name);
    writeln('Graduation Year: ' , GradYear);
    writeln('Sex: ', Sex);
    writeln('Age', Age);
    writeln('Job:' , Job);
    writeln('Leader ID(-1 means no):' , ParentParticipant);
    writeln('confirm? ("y","n")');
    readln(confirm);
    while not ((confirm = 'y') or (confirm = 'n')) do
    begin
        writeln('worng input, please try again');
        writeln('confirm? ("y","n")');
        readln(confirm);
    end;
    if(confirm = 'y') then
    begin
        writeln('Generating ID...');
        ID:=NewID();
        write('Registering Users...');
        writeln(ID);
        ParentParticipant:= ParentParticipant;
        RegisterUser(ID ,Name, GradYear , Sex , Age , Job , ParentParticipant);
        writeln('Successfully Registered!');
        writeln('');
        writeln('ID: ',ID);
        writeln('Name: ' , Name);
        writeln('Graduation Year: ' , GradYear);
        writeln('Sex: ', Sex);
        writeln('Age', Age);
        writeln('Job:' , Job);
        writeln('Leader ID(-1 means no):' , ParentParticipant);
        writeln('Bringing back to menu...');
        Exit;
    end
    else
        writeln('Please Register again to modify the Registeration...');
        writeln('Bringing back to menu...');
        Exit;

end;
function Menu() :Integer;
var
input: Integer;
begin
    writeln('Please select the operation:');
    writeln('input "1": Register Users');
    writeln('input "2": Output a sitting table');
    writeln('input "-1" Exit');
    readln(input);
    Menu:=input;
    
end;
begin ///start of the Program {initialization}
    
    Assign(RegisterUserFile , C_FNAME); 

    try ///check if there are file Users.txt
        reset(RegisterUserFile);
    except
    begin
        writeln('No file named as Users.txt');
        writeln('Creating One...');
        rewrite(RegisterUserFile);
    end;
    end;
    ///reset (RegisterUserFile);
    ///    TextLineCounter:=0;
    ///    while not (eof (RegisterUserFile)) do
    ///        begin
    ///            repeat
    ///                read (RegisterUserFile, RegisterUserFileCharTemp);
    ///        until eoln (RegisterUserFile);
    ///        TextLineCounter:=TextLineCounter+1;
    ///        end;
    ///        CloseFile(RegisterUserFile); 
    repeat
        case (MenuTemp) of
            1: RegisterUserAsking();
        end;    
        MenuTemp:=Menu();
    until MenuTemp = -1;
    
end.

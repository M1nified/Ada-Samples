with Ada.Text_Io; 
use  Ada.Text_Io;
procedure Concurrent is
  task type Task1 is
    entry Insert (In1 : in Integer);
  end Task1;
  task body Task1 is
    Value : Integer;
  begin
    Value := 10;
    accept Insert(In1 : in Integer) do
      Value := In1;
    end Insert;
    Put_Line(Integer'Image(Value));
  end Task1;

  thetask : Task1;
begin
  thetask.Insert(2);
end Concurrent;
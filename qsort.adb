with Ada.Text_Io; 
use  Ada.Text_Io;

package body Qsort is

task body SortTask is
  List : vector_ptr;
  Kids : array(1..2) of Sort_access;
  HalfIndex : Integer;
  HalfIndex2 : Integer;
  LLeft : vector_ptr;
  LRight : vector_ptr;
begin
  accept PortIn(ValIn : in vector_ptr) do
    List := ValIn;
    Put_Line(Integer'Image(List'Length));
    if List'Length > 2 then
      Put_Line("Split");
      HalfIndex := List'Length/2;
      HalfIndex2 := HalfIndex + 1;
      Put_Line(Integer'Image(HalfIndex));
      LLeft := new vector(List'first..HalfIndex);
      LRight := new vector(HalfIndex2..List'last);
      --Kids(1).PortIn(LLeft);
      --Kids(2).PortIn(LRight);
    else
      Put_Line("Sort");
    end if;
  end PortIn;
end SortTask;

procedure Sort (List : in out vector_ptr) is
  sort_task_1 : SortTask;
begin
  sort_task_1.PortIn(List);
end Sort;


end Qsort;
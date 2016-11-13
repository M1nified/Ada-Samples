with Ada.Text_Io; 
use  Ada.Text_Io;

package body Qsort is

task body SortTask is
  List : vector_ptr;
  Kids : array(1..2) of Sort_access;
begin
  accept PortIn(ValIn : in vector_ptr) do
    List := ValIn;
    Put_Line(Integer'Image(List'Length));
  end PortIn;
end SortTask;

procedure Sort (List : in out vector_ptr) is
  sort_task_1 : SortTask;
begin
  sort_task_1.PortIn(List);
end Sort;


end Qsort;
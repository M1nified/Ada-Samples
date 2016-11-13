-- przykłady: pakiet, select w zasdaniu, access do zadania jako parametr wywołania

with Qsort;
with Ada.Text_Io;
use Qsort,Ada.Text_Io;

procedure Qsort_demo is
  Arr1 : vector := (1,6,2,67,3);
  Arr1_ptr : vector_ptr;
begin
  Arr1_ptr := new vector(Arr1'range);
  Put_Line(Integer'Image(Arr1'Length));
  Put_Line(Integer'Image(Arr1'Length));
  Put_Line(Integer'Image(Arr1_ptr'Length));
  for i in Arr1'range loop
    Arr1_ptr(i) := Arr1(i);
  end loop;
  Qsort.Sort(Arr1_ptr);
  null;
end Qsort_demo;

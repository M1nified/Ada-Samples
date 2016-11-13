-- przykłady: pakiet, select w zasdaniu, access do zadania jako parametr wywołania

with PMap;
with Ada.Text_Io;
use PMap,Ada.Text_Io;

procedure pmap_demo is
  Arr1 : vector := (1,6,2,67,3);
  Arr1_ptr : vector_ptr;
  Arr2_ptr : vector_ptr;

begin
  Arr1_ptr := new vector(Arr1'range);
  Put_Line(Integer'Image(Arr1'Length));
  Put_Line(Integer'Image(Arr1'Length));
  Put_Line(Integer'Image(Arr1_ptr'Length));
  for i in Arr1'range loop
    Arr1_ptr(i) := Arr1(i);
  end loop;
  Put_Line("");
  for i in Arr1'range loop
    Put(Integer'Image(Arr1(i)));
    Put(",");
  end loop;
  Put_Line("");
  Arr2_ptr := PMap.pmap(Arr1_ptr);
  Put_Line(Integer'Image(Arr2_ptr'Length));
  Put_Line(Integer'Image(Arr2_ptr(Arr2_ptr'first)));
  Put_Line("end");
  for i in Arr2_ptr'range loop
    Put(Integer'Image(Arr2_ptr(i)));
    Put(",");
  end loop;
  Put_Line("");
end pmap_demo;

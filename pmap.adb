with Ada.Text_Io; 
use  Ada.Text_Io;

package body PMap is

task body pmap_apply is
  value : Integer;
  Func : func_type;
begin
  accept PortIn(ValIn : in Integer; FuncIn : in not null func_type) do
    value := ValIn;
    Func := FuncIn;
  end PortIn;
  value := Func(value);
  Put_Line(Integer'Image(value));
  accept PortOut(ValOut : out Integer) do
    ValOut := value;
  end PortOut;
end pmap_apply;

task body pmap_task is
  List, List_modified : vector_ptr;
  Func : func_type;
  Kids : pmap_applies_access;
  val : Integer;
begin
  accept PortIn(ValIn : in vector_ptr; FuncIn : in not null func_type) do
    List := ValIn;
    Func := FuncIn;
  end PortIn;
  --Put_Line(Integer'Image(List'Length));
  List_modified := new vector(List'range);
  
  Kids := new pmap_applies(List'range);
  for i in List'range loop
    Kids(i).PortIn(List(i), Func);
  end loop;

  for i in List'range loop
    Kids(i).PortOut(val);
    List_modified(i) := val;
    --Put_Line(Integer'Image(val));
  end loop;

  accept PortOut(ValOut : out vector_ptr) do
    ValOut := List_modified;
  end PortOut;
end pmap_task;



function example1 (X : in Integer) return Integer is
begin
  return x + 10;
end example1;

function pmap (List : in vector_ptr) return vector_ptr is
  task1 : pmap_task;
  output : vector_ptr;
begin
  task1.PortIn(List, example1'Access);
  task1.PortOut(output);
  return(output);
end pmap;


end PMap;
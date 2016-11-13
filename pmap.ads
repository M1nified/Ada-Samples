with System;
use  System;

package PMap is

type vector is array (Integer range <>) of Integer;
type vector_ptr is access vector;

type func_type is access function (X : in Integer) return Integer;

task type pmap_apply is
  entry PortIn(ValIn : in Integer; FuncIn : in not null func_type);
  entry PortOut(ValOut : out Integer);
end pmap_apply;
type pmap_apply_access is access pmap_apply;

type pmap_applies is array(Integer range <>) of pmap_apply;
type pmap_applies_access is access pmap_applies;

task type pmap_task is
  entry PortIn(ValIn : in vector_ptr; FuncIn : in not null func_type);
  entry PortOut(ValOut : out vector_ptr);
end pmap_task;
type pmap_task_access is access pmap_task;

type pmap_tasks is array(Integer range <>) of pmap_task;
type pmap_tasks_access is access pmap_tasks;

function pmap (List : in vector_ptr) return vector_ptr;

end PMap;
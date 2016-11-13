with System;
use  System;

package Qsort is

type vector is array (Integer range <>) of Integer;
type vector_ptr is access vector;

task type SortTask is
  entry PortIn(ValIn : in vector_ptr);
  entry PortOut(ValOut : out vector);
end SortTask;
type Sort_access is access SortTask;

procedure Sort (List : in out vector_ptr);

end Qsort;
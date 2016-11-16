with Ada.Text_Io;
use  Ada.Text_Io;

procedure main is
   type vector is array (Integer range <>) of Integer;
   type vector_ptr is access vector;

   task type sort_split is
      entry PutArrayRange(vec_ptr: in vector_ptr; l, r : in Integer);
      entry GetResult(ok_ret : out boolean);
   end sort_split;
   type sort_split_ptr is access sort_split;

   task type sort is
      entry PutArray(value : in vector_ptr; l, r : in Integer);
      entry GetResult(ok_ret : out boolean);
   end sort;
   type sort_ptr is access sort;

   procedure merge(arr_ptr:in out vector_ptr; left1, right1, left2, right2 : in Integer) is
      i,j:Integer;
      tmp_arr : vector(left1..right2) := (others => -1);
   begin
      i:=0;
      j:=0;
      while left1 + i <= right1 and left2 + j <= right2 loop
         if arr_ptr(left1 + i) >= arr_ptr(left2 + j) then
            tmp_arr(left1 + i + j) := arr_ptr(left2 + j);
            j := j + 1;
         else
            tmp_arr(left1 + i + j) := arr_ptr(left1 + i);
            i := i + 1;
         end if;
      end loop;
      while left1 + i <= right1 loop
         tmp_arr(left1 + i + j) := arr_ptr(left1 + i);
         i:= i + 1;
      end loop;
      while left2 + j <= right2 loop
         tmp_arr(left1 + i + j) := arr_ptr(left2 + j);
         j := j + 1;
      end loop;
      for index in left1..right2 loop
         arr_ptr(index) := tmp_arr(index);
      end loop;

   end Merge;

   task body sort_split is
      arr : vector_ptr;
      left : Integer;
      right : Integer;
      sort_left : sort_ptr;
      sort_right : sort_ptr;
      tmp : Integer;
      ok : Boolean;
   begin
      -- Put(" sort_split ");
      accept PutArrayRange(vec_ptr: in vector_ptr; l, r : in Integer) do
         -- Put_Line("Splitting...");
         arr := vec_ptr;
         left := l;
         right := r;
         tmp := left + right;
         tmp := tmp/2;
         -- tmp := Float'Floor(tmp2);
         -- Put("TMP:");
         -- Put_Line(Integer'Image(tmp));
         sort_left := new sort;
         sort_right := new sort;
         sort_left.PutArray(arr,left,tmp);
         sort_right.PutArray(arr,tmp+1,right);
         -- RECEIVE
         sort_left.GetResult(ok);
         sort_right.GetResult(ok);
         merge(arr, left,tmp,tmp+1,right);
      end PutArrayRange;
      accept GetResult(ok_ret: out boolean) do
         ok_ret := true;
      end GetResult;

   end sort_split;

   task body sort is
      arr : vector_ptr;
      left : Integer;
      right : Integer;
      kido : sort_split_ptr;
      tmp : Integer;
      ok:boolean;
   begin
      -- Put(" sort ");
      accept PutArray(value : in vector_ptr; l, r : in Integer) do
         arr := value;
         left := l;
         right := r;
      end PutArray;
      -- Put_Line("Going to sort...");
      -- Put_Line(Integer'Image(arr'Length));
      if (right - left) > 1 then
         -- Put_Line("Going to split");
         kido := new sort_split;
         kido.PutArrayRange(arr, left, right);
         kido.GetResult(ok);
      elsif right - left = 1 and arr(left) > arr(right) then
         tmp := arr(left);
         arr(left) := arr(right);
         arr(right) := tmp;
      end if;
      accept GetResult(ok_ret : out boolean) do
         ok_ret := true;
      end GetResult;

   end sort;

   arr : vector (1..15) := (1,5,2,6,7,1,6,7,3,3,4234,5,34,5,2);
   arr_ptr : vector_ptr;
   st : sort;
   ok : Boolean;
begin
   Put_Line("BEFORE: ");
   arr_ptr := new vector(arr'range);
   for i in arr'range loop
      arr_ptr(i) := arr(i);
   end loop;
   for i in arr'range loop
      Put(Integer'Image(arr(i)));
      Put(",");
   end loop;
   Put_Line("");
   -- Put_Line(Integer'Image(arr'First));
   st.PutArray(arr_ptr,arr'First,arr'Last);
   st.GetResult(ok);
   Put_Line("AFTER: ");
   for i in arr_ptr'range loop
      Put(Integer'Image(arr_ptr(i)));
      Put(",");
   end loop;

end main;

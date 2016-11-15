with Ada.Text_Io; 
use  Ada.Text_Io;

procedure msort_demo is
    type vector is array (Integer range <>) of Integer;
    type vector_ptr is access vector;

    task type sort_split is
        entry PutArrayRange(vec_ptr: in vector_ptr; l, r : in Integer);
    end sort_split;
    type sort_split_acc is access sort_split;
    task type sort is
        entry PutArray(value : in vector_ptr; l, r : in Integer);
    end sort;
    type sort_acc is access sort;
    
    task body sort_split is
        arr : vector_ptr;
        left : Integer;
        right : Integer;
        kido : sort_acc;
    begin
        Put(". ");
        accept PutArrayRange(vec_ptr: in vector_ptr; l, r : in Integer) do
            arr := vec_ptr;
            left := l;
            right := r;
        end PutArrayRange;
    end sort_split;

    task body sort is
        arr : vector_ptr;
        left : Integer;
        right : Integer;
        spliters : array(1..2) of sort_split_acc;
        tmp : Integer;
    begin
        Put(".");
        accept PutArray(value : in vector_ptr; l, r : in Integer) do
            arr := value;
            left := l;
            right := r;
        end PutArray;
        Put_Line(Integer'Image(arr'Length));
        if (right - left) > 2 then
            tmp := (left + right) / 2;
            Put("TMP:");
            Put_Line(Integer'Image(tmp));
            spliters(1).PutArrayRange(arr,left,tmp);
            spliters(2).PutArrayRange(arr,tmp+1,right);
        elsif right - left = 2 and arr(left) > arr(right) then
            tmp := arr(left);
            arr(left) := arr(right);
            arr(right) := tmp;
        end if;
    end sort;

    arr : vector := (1,5,2,6,7,1,6,7,3,3,4234,5,34,5,2);
    arr_ptr : vector_ptr;
    st : sort; 
begin
    Put_Line("HELLO");
    arr_ptr := new vector(arr'range);
    for i in arr'range loop
        arr_ptr(i) := arr(i);
    end loop;
    for i in arr'range loop
        Put(Integer'Image(arr(i)));
        Put(",");
    end loop;
    Put_Line("");
    Put_Line(Integer'Image(arr_ptr'First));
    st.PutArray(arr_ptr,arr_ptr'First,arr_ptr'Last);
end msort_demo;
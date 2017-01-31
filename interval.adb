procedure Interval_proc is
    procedure some_procedure is
    begin
        -- this cannot be empty
    end;
    Interval_Length : Time_Span := To_Time_Span(0.5);
    Next_Call_Time : Time;
begin
    Next_Call_Time := Clock;
    loop
        some_procedure;
        Next_Call_Time := Next_Call_Time + Interval_Length;
        delay until Next_Call_Time;
    end loop;
end Interval_proc;

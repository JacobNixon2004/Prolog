%%%%%%%%%%%%%%%%%%%Question 4.1%%%%%%%%%%%%%%%%%%%
mondays(0, _, []).
mondays(D, S, Mondays) :-
    findall(Day, (
        between(1, D, Day),
        (Day + S - 1) mod 7 =:= 1
    ), Mondays).

%%%%%%%%%%%%%%%%%%%Question 4.2%%%%%%%%%%%%%%%%%%%
months(1, 31).
months(2, 29).
months(2, 28).
months(3, 31).
months(4, 30).
months(5, 31).
months(6, 30).
months(7, 31).
months(8, 31).
months(9, 30).
months(10, 31).
months(11, 30).
months(12, 31).

days(1).
days(2).
days(3).
days(4).
days(5).
days(6).
days(7).

generator4([[M1, D1, S1], [M2, D2, S2]]) :-
    months(M1, D1),	
    days(S1),
    month_two(M1,M2,D2,S2),
    valid_start(S1, D1, S2).

month_two(M1,M2,D2,S2) :-
    ( M1 = 12 -> M2 = 1; M2 is M1 + 1),
    months(M2, D2),
    days(S2).

valid_start(S1, D1, S2) :-
    Next_S1 is ((S1 + D1 - 1) mod 7) + 1,
    Next_S1 =:= S2.

%%%%%%%%%%%%%%%%%%%Question 4.3%%%%%%%%%%%%%%%%%%%
month_letters(1, 7).
month_letters(2, 8).
month_letters(3, 5).
month_letters(4, 5).
month_letters(5, 3).
month_letters(6, 4).
month_letters(7, 4).
month_letters(8, 6).
month_letters(9, 9).
month_letters(10, 7).
month_letters(11, 8).
month_letters(12, 8).

selector4([[M1, D1, S1], [M2, D2, S2]]) :-
    D1 \= D2,
    T1 = D1,
    U1 = D2,
    month_letters(M1, T2),
    month_letters(M2, U2),
    U2 \= T2,
    prime_days(M1, M2, T3, U3),
    mondays(D1, S1, T4mondays),
    mondays(D2, S2, U4mondays),
    length(T4mondays, T4),
    length(U4mondays, U4),
    U4 \= T4,
    prime_saturday(D1, D2, S1, S2, T5, U5),
    prime_sum(T1, T2, T3, T4, T5, U1, U2, U3, U4, U5).

prime_days(M1, M2, T3, U3) :-
    count_prime_days(M1, T3),
    count_prime_days(M2, U3),
    U3 \= T3.

count_prime_days(Month, Count) :-
    days_in_month(Month, PrimeDays),
    length(PrimeDays, Count).

days_in_month(Month, Days) :-
    months(Month, MaxDays),
    findall(Day, (between(1, MaxDays, Day), is_prime(Day)), Days).

is_prime(2). 
is_prime(N) :-
    N > 2,
    \+ has_divisor(N, 2). 

has_divisor(N, D) :-
    D * D =< N,
    N mod D =:= 0.
has_divisor(N, D) :-
    D * D =< N,
    D2 is D + 1,
    has_divisor(N, D2).
    
prime_saturday(D1, D2, S1, S2, T5, U5) :-
    count_prime_saturdays(D1, S1, T5),
    count_prime_saturdays(D2, S2, U5),
    U5 \= T5.

count_prime_saturdays(DaysInMonth, StartDay, Count) :-
    saturdays_in_month(DaysInMonth, StartDay, SaturdaysList),
    include(is_prime, SaturdaysList, PrimeSaturdays),
    length(PrimeSaturdays, Count).

saturdays_in_month(DaysInMonth, StartDay, SaturdaysList) :-
    findall(Day, (between(1, DaysInMonth, Day),
                  weekday(Day, StartDay, Weekday),
                  Weekday =:= 6),
            SaturdaysList).

weekday(Day, StartDay, Weekday) :-
    Weekday is (StartDay + Day - 2) mod 7 + 1.


prime_sum(T1, T2, T3, T4, T5, U1, U2, U3, U4, U5) :-
    TotalT is T1 + T2 + T3 + T4 + T5,
    is_prime(TotalT),
    TotalT is U1 + U2 + U3 + U4 + U5,
    is_prime(TotalT).

main :-
    generator4(X),
    selector4(X),
    write(X).

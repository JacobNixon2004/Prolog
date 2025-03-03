%%%%%%%%%%%%%%%%%%%Question 3.1%%%%%%%%%%%%%%%%%%%
number([], 0).
number([D|Ds], N) :-
    number(Ds, M),
    length(Ds, L),
    N is D * 10^L + M.

%%%%%%%%%%%%%%%%%%%Question 3.2%%%%%%%%%%%%%%%%%%%
generator3(Combined) :-
    permutation([1, 2, 3, 4, 5, 6, 7, 8, 9], PermutedList),
    length(PermutedList, Max),
    between(1, Max, N),
    length(List1, N),
    append(List1, List2, PermutedList),
    List1 \= [],
    List2 \= [],
    Combined = [List1, List2].
%%%%%%%%%%%%%%%%%%%Question 3.3%%%%%%%%%%%%%%%%%%%
selector3([AS, BS]) :-
    number(AS, A),
    number(BS, B),
    product_palindrome(A, B),
    last_digit(A, B),
    sum(A, B).

product_palindrome(A, B) :-
    Product is A * B,
    number_to_list(Product, Digits),
    is_palindrome(Digits),
    Digits = [4|_].

number_to_list(0, []).
number_to_list(Number, Digits) :-
    Number > 0,
    Div is Number // 10, 
    number_to_list(Div, RestDigits),
    Digit is Number mod 10, 
    append(RestDigits, [Digit], Digits). 

is_palindrome(List) :- reverse(List, List).

last_digit(A, B) :-
    Min is min(A, B),
    Min mod 10 =:= 3.

sum(A, B) :-
    Sum is A + B + 100,
    number_to_list(Sum, Digits),
    is_palindrome(Digits).

main :-
    generator3(X),
    selector3(X),
    write(X).

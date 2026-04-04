-module(myqueue).
-export([create/0, enqueue/2, dequeue/1, test/0, reverse/1, reverse/2, bcreate/0,benqueue/2, bdequeue/1, test2/0]).


reverse(L) -> reverse([],L).

reverse(ACC,[]) -> ACC;
reverse(ACC,[H | T]) -> reverse([H | ACC],T).


create() -> [] .


enqueue(Queue, Item) -> [Item | Queue] .


dequeue([]) -> empty;
dequeue([X]) -> {[],X};
dequeue([H | T]) -> 
    {Q,Item} = dequeue(T),
    {[H | Q], Item}.

test() ->
    Q = create(),
    empty = dequeue(Q),
    Q1 = enqueue(Q,1),
    Q2 = enqueue(Q1,2),
    Q3 = enqueue(Q2,3),
    Q4 = enqueue(Q3,4),
    Q5 = enqueue(Q4,5),
    Q6 = enqueue(Q5,6),
    Q7 = enqueue(Q6,7),
    {Q8,1} = dequeue(Q7),
    {Q9,2} = dequeue(Q8),
    {Q10,3} = dequeue(Q9),
    {Q11,4} = dequeue(Q10),
    {Q12,5} = dequeue(Q11),
    {Q13,6} = dequeue(Q12),
    {Q14,7} = dequeue(Q13),
    empty = dequeue(Q14), % 🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈
    ok.


bcreate() -> {[],[]}.

benqueue({In,Out}, Item) -> {[Item | In],Out}.

bdequeue({[],[]}) -> empty;
bdequeue({In,[]}) -> bdequeue({[],reverse(In)});
bdequeue({In,[H | T]}) -> {{In,T},H}.




test2() ->
    Q = bcreate(),
    empty = bdequeue(Q),
    Q1 = benqueue(Q,1),
    Q2 = benqueue(Q1,2),
    Q3 = benqueue(Q2,3),
    Q4 = benqueue(Q3,4),
    Q5 = benqueue(Q4,5),
    Q6 = benqueue(Q5,6),
    Q7 = benqueue(Q6,7),
    {Q8,1} = bdequeue(Q7),
    {Q9,2} = bdequeue(Q8),
    {Q10,3} =bdequeue(Q9),
    {Q11,4} = bdequeue(Q10),
    {Q12,5} = bdequeue(Q11),
    {Q13,6} = bdequeue(Q12),
    {Q14,7} = bdequeue(Q13),
    empty = bdequeue(Q14), % 🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈🙈
    ok.

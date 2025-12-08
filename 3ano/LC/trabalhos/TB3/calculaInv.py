from z3 import *

def check_exa_chc():

    N = 4

    a, b     = BitVecs('a b', N)
    r, rb    = BitVecs('r rb', N)  #rb é o r_ do enunciado
    s, sb    = BitVecs('s sb', N)
    t, tb    = BitVecs('t tb', N)
    on       = Bool('on')

  
    a_p, b_p   = BitVecs('a_p b_p', N)
    r_p, rb_p  = BitVecs('r_p rb_p', N)
    s_p, sb_p  = BitVecs('s_p sb_p', N)
    t_p, tb_p  = BitVecs('t_p tb_p', N)
    on_p       = Bool('on_p')

    vars_curr = [a, b, r, rb, s, sb, t, tb, on]
    vars_next = [a_p, b_p, r_p, rb_p, s_p, sb_p, t_p, tb_p, on_p]
    
    absurd = BoolVal(False)

    #SFOTS
    init = And(
        a > 0, b > 0, 
        r == a, rb == b,
        s == 1, sb == 0,
        t == 0, tb == 1,
        on
    )


    q = UDiv(r, rb)
   

    def mul_overflow(x, y):
        return Not(BVMulNoOverflow(x, y, True))

    def sub_overflow(x, y):
        return Or(
            Not(BVSubNoOverflow(x, y)),
            Not(BVSubNoUnderflow(x, y, True))
        )

    mult_rnext_overflow = mul_overflow(q, rb)
    mult_snext_overflow = mul_overflow(q, sb)
    mult_tnext_overflow = mul_overflow(q, tb)

    sub_r_overflow = sub_overflow(r, q * rb)
    sub_s_overflow = sub_overflow(s, q * sb)
    sub_t_overflow = sub_overflow(t, q * tb)

    hasOverFlow = And(on, 
        rb != 0,Or(
        mult_rnext_overflow,
        mult_snext_overflow,
        mult_tnext_overflow,
        sub_r_overflow,
        sub_s_overflow,
        sub_t_overflow
    )
    )




    # t0 é o começo do loop
    t0 = And(on, rb != 0,         
        r_p == rb,
        rb_p == r - (q * rb),
        s_p == sb,              # Todo o calculo 
        sb_p == s - (q * sb),
        t_p == tb,
        tb_p == t - (q * tb),

        a_p == a, b_p == b,
        on_p == on        # As variaveis que nao mudam 
    )

    # saida do loop
    t1 = And( on,rb == 0,          
        
        
        r_p == r, rb_p == rb,
        s_p == s, sb_p == sb,
        t_p == t, tb_p == tb, # As variaveis que nao mudam 
        a_p == a, b_p == b,
        
        on_p == Not(on)   # o loop acabou
    )

    trans = Or(t0, t1)

    # ERROR
    error = Or(
        hasOverFlow,
        And(Not(on), r == 0) 
    )

    

    # funçao inv que tem as variaveis ints e o bool do loop e retorna um bool
    Inv = Function('inv',  BitVecSort(N), BitVecSort(N), BitVecSort(N),
    BitVecSort(N), BitVecSort(N), BitVecSort(N), BitVecSort(N), BitVecSort(N),BoolSort(), 
    BoolSort())

    pre = Inv(*vars_curr)
    pos = Inv(*vars_next)

    # CHC 1: Init => Invariante
    chc0 = ForAll(vars_curr, Implies(init, pre))

    # CHC 2: (Invariante AND Transição) => Invariante'
    chc1 = ForAll(vars_curr + vars_next, Implies(And(pre, trans), pos))

    # CHC 3: (Invariante AND Erro) => False (Absurdo)
    chc2 = ForAll(vars_curr, Implies(And(pre, error), absurd))


    s = SolverFor('HORN')
    s.add([chc0, chc1, chc2])
    
    print("A verificar segurança e a procurar um invariante")
    result = s.check()
    
    if result == sat:
        print("SAFE! O programa é seguro")
        print(s.model().eval(pre)) 
    elif result == unsat:
        print("UNSAFE!!!")
        #print(s.proof())
    else:
        print("UNKNOWN...")
        print(s.reason_unknown())

check_exa_chc()
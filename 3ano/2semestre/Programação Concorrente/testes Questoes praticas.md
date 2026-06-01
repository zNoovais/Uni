
![[Pasted image 20260525123239.png]]

```Java
public class Sondagem {

// estrutura de memoria partilhada
private final Map<String,Integer> votos = new HashMap<>();           

private int getVotos(String candidato) {
	if (votos.contaisKey(candidato)) {
		return votos.get(candidato);
	}
	else {
		return 0;	
	}
}

private synchronized void vota(String candidato) {
	votos.put(candidato, getVotos(candidato) + 1);
	notifyAll();
}

private synchronized void espera(String c1, String c2, String c3) {
	while(!(getVotos(c1) < getVotos(c2) && getVotos(c2) < getVotos(c3))) {
		wait();
	} 
	
}

}


```

![[Pasted image 20260525151741.png]]

```erlang
new() -> spawn(fun() -> loop(#{},[]) end).

loop(Votos,Pids) ->
	receive {voto,Candidato} ->
		VotosCandidato = maps:get(Candidato,Votos,0),
		Votos = maps:put(Candidato, VotosCandidato + 1,Votos),
		[Pid ! {sinal} || Pid <- Pids], % avisar pids
		loop(Votos,[]);
	{espera,Pid} ->
		Pid ! {ok,Votos},
		loop(Votos, Pid | Pids);
		
	{get_votos, Pid} ->
	Pid ! {ok,Votos}
	
voto(LoopPid,Candidato) ->
	LoopPid ! {voto,Candidato},
	ok.

espera(LoopPid,C1,C2,C3) ->
	LoopPid ! {get_votos,self()},
	receive
		{ok,Votos} ->
			V1 = maps:get(C1,Votos,0),
			V2 = maps:get(C2,Votos,0),
			V3 = maps:get(C3,Votos,0),
		if (V1 < V2) and (V2 < V3) ->
			ok;
			true ->
			LoopPid ! {espera,self()},
			receive {sinal} ->
				espera(LoopPid,C1,C2,C3).
			
```

![[Pasted image 20260525161926.png]]

```java
interface Matcher {
	Match waitToPlay(int role) throws InterrupedException
}

public class SoccerMatcher implements Matcher {

private int grCount = 0; // memoria partilhada
private int jgCount = 0;
private Match currentMatch = new Match();


public synchronized waitToPlay(int role) {
	Match myMatch = this.currentMatch;
	if (role == 0) {
		while(grCount >= 0 || this.currentMatch == myMatch) { 
			wait()
		}
		grCount++;
	}
	else if (role == 1) {
		while(jgCount >= 20 || this.currentMatch == myMatch) {
			wait();
		}
		jgCount++;
	}
	
	if (grCount == 2 && jgCount == 20) {
		
		this.grCount = 0;
		this.jgCount = 0;
		this.currentMatch = new Match();
		
		notifyAll();
		return myMatch;
	}
	else {
		while(myMatch==this.currentMatch) {
			wait();
		}	
	}
	
	return myMatch
	
}




}
```

![[Pasted image 20260525173549.png]]

```erlang
new() -> spawn(fun() -> loop(0,0,[],[]) end).

loop(NrJ,NrG,J,G) -> 
	if NrJ >= 20 and NrG >= 2 ->
		[Pid ! ok || Pid <- lists:sublist(J,20)],
		[Pid ! ok || Pid <- lists:sublist(G,2)],
		loop(NrJ-20,NrG-2,lists:nthtail(20,J),lists:nthtail(2,G));
	true ->
		receive 
			{jogador,Pid} ->
				loop(NrJ+1,NrG,J++[Pid],G);
			 {guarda,Pid} -> 
				loop(NrJ,NrG+1,J,G++[Pid])
			end
			
			
waitToPlay(LoopPid,0) ->
	LoopPid ! {guarda,self()},
	receive ok -> ok.

waitToPlay(LoopPid,1) ->
	LoopPid ! {jogador,self()},
	receive ok -> ok.		

```
![[Pasted image 20260525213254.png]]

```java
public class Matcher implements MatchMaker {


private Lock l = new ReentrantLock();

private Arraylist<Condition> condsC = new ArrayList();
private Arraylist<Condition> condsP = new ArrayList();
 

private int nrC;
private int nrP;

BoundedBuffer waitForConsumer() {
	l.lock();
	try {
	if(nrC > 0) {
		condsC.get(0).signal();
		condsC.remove(0);
		this.nrC -= 1;		
	}
	else {
		nrP += 1;
		Condition cond = new lock.newCondition();
		condsP.add(cond);
		while(condsP.constains(cond))
		cond.await();
	}
	
	} finally {
	l.unlock()
	}
	
}

BoundedBuffer waitForProducer() { //PARECIDO EH ANALOGO AO DE CIMA

	l.lock();
	try {
	if(nrC > 0) {
		condsC.get(0).signal();
		condsC.remove(0);
		this.nrC -= 1;		
	}
	else {
		nrP += 1;
		Condition cond = new lock.newCondition();
		condsP.add(cond);
		while(condsP.constains(cond))
		cond.await();
	}
	
	} finally {
	l.unlock()
	}
	
}





}


```

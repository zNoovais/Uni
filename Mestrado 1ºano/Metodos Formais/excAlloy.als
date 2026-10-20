sig User {
follows : set User,
seems : set Photo,
posts : set Photo,
suggested : set User
}

sig Influencer extends User {}

sig Photo {
    data : one Day
}

sig af extends Photo {}

sig Day {}


fact PostsInjective {
	all p:Photo | some u:User | u -> p in posts 
	all p:Photo, u1,u2:User | u1 -> p in posts and u2 -> p  in posts implies u1 = u2
}

run arbitrary {}


run NoReflexive {
	some u:User | u->u not in follows
} expect 1

//run SomePosrs
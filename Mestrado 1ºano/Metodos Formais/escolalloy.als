sig Job {}

sig Professor extends Job {}
sig Student extends Job {}


sig Project {}

sig Grade {}




sig Person {
has : set Job,
works_on : set Project,
teaches : set Course,
is_enrolled : set Course 

}

sig Course {
proposes : set Project,
grades :  set Grade -> set Person
}

pred ExistenciaPessoaProjeto {
	all proj : Project | some per : Person | per -> proj in works_on
}

pred ProfessorEnsinaCurso {
 all cour : Course | some per : Person | per -> cour in teaches and Professor in per.has  }




fact {
	ExistenciaPessoaProjeto[]
 ProfessorEnsinaCurso[]
}


run arbitrary {}

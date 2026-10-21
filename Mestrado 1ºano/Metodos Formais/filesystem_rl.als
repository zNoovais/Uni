/**
Step 1: Encode the system structure through signatures and fields with proper multiplicities
*/
abstract sig Object {}

sig Dir extends Object {
	contains : set Entry
}

sig File extends Object {}

one sig Root in Dir {}

sig Entry {
	refersTo : one Object,
	has : one Name
}

sig Name {}

// Multiplicities can only be imposed in the range of fields, so those on the domain signature must be imposed as additional facts

// Each entry is contained in one directory
fact ContainsInjective {
	all x : Entry | one contains.x
}

/**
Step 2: Write simple run commands to animate this (severely under-constrained) model
*/

run arbitrary { } for 4 but exactly 2 Dir, 3 Name expect 1
run someFile { some File } for 4 but exactly 2 Dir, 3 Name expect 1

/**
Step 3: Customize a theme to improve the visualization of the returned instances
*/

// import file filesystem.thm
// customizations includes:
// - hide skolen sigs/fields
// - change colour and shape of signatures
// - present field has as attribute and hide Names
//

/**
Step 4: For each requirement of the system:
*/

// All directories are referred to in at most one entry

/**
Step 4a: Write a few positive and negative test cases as run commands
*/

run NoSharedDirs_positive {
	some r:Root,d:Dir,e:Entry,n:Name {
		Dir = r + d
		File = none
		Entry = e
		Name = n
		contains = r -> e
		refersTo = e -> d
		has = e -> n
	}
} expect 1

run NoSharedDirs_negative {
	some r:Root,d:Dir,e:Entry,n:Name {
		Dir = r + d
		File = none
		Entry = e
		Name = n
		contains = none -> none
		refersTo = e -> d
		has = e -> n
	}
} expect 0

/**
Step 4b: Execute the commands and validate instances 
*/

// run commands and manually inspect returned instances

/**
Step 4c: Formalize the requirement and impose it in a fact
*/

fact NoSharedDirs {
	all x : Dir | lone refersTo.x
}

/**
Step 4d and 4e: Re-run the test cases and validate the expected outcome and Fix the requirement formalization if needed
*/

// The root is not referred in any entry

/**
Step 4a: Write a few positive and negative test cases as run commands
*/

run DanglingRoot_positive {
	some r:Root {
		Dir = r
		File = none
		Entry = none
		Name = none
		contains = none -> none
		refersTo = none -> none
		has = none -> none
	}
} expect 1

run DanglingRoot_negative {
	some r:Root,d:Dir,e:Entry,n:Name {
		Dir = r + d
		File = none
		Entry = e
		Name = n
		contains = d -> e
		refersTo = e -> r
		has = e -> n
	}
} expect 0

/**
Step 4b: Execute the commands and validate instances 
*/

// run commands and manually inspect returned instances

/**
Step 4c: Formalize the requirement and impose it in a fact
*/

fact DanglingRoot {
	no refersTo.Root
}

/**
Step 4d and 4e: Re-run the test cases and validate the expected outcome and Fix the requirement formalization if needed
*/

// All non-root objects are referred to in at least one entry

/**
Step 4a: Write a few positive and negative test cases as run commands
*/

run NoDanglingObjects_positive {
	some r:Root,d:Dir,f:File,disj e1,e2:Entry,n:Name {
		Dir = r + d
		File = f
		Entry = e1 + e2
		Name = n
		contains = r -> e1 + d -> e2
		refersTo = e1 -> d + e2 -> f
		has = e1 -> n + e2 -> n
	}
} expect 1

run NoDanglingObjects_negative {
	some r:Root,d:Dir,f:File,disj e:Entry,n:Name {
		Dir = r + d
		File = f
		Entry = e
		Name = n
		contains = r -> e
		refersTo = e -> d
		has = e -> n
	}
} expect 0

/**
Step 4b: Execute the commands and validate instances 
*/

// run commands and manually inspect returned instances

/**
Step 4c: Formalize the requirement and impose it in a fact
*/

fact NoDanglingObjects {
	Object-Root in Entry.refersTo
}

/**
Step 4d and 4e: Re-run the test cases and validate the expected outcome and Fix the requirement formalization if needed
*/

// Different entries in a directory must have different names

/**
Step 4a: Write a few positive and negative test cases as run commands
*/

run UniqueNames_positive {
	some r:Root,d:Dir,f:File,disj e1,e2:Entry,n1,n2:Name {
		Dir = r + d
		File = f
		Entry = e1 + e2
		Name = n1 + n2
		contains = r -> e1 + r -> e2
		refersTo = e1 -> d + e2 -> f
		has = e1 -> n1 + e2 -> n2
	}
} expect 1

run UniqueNames_negative {
	some r:Root,d:Dir,f:File,disj e1,e2:Entry,n:Name {
		Dir = r + d
		File = f
		Entry = e1 + e2
		Name = n
		contains = r -> e1 + r -> e2
		refersTo = e1 -> d + e2 -> f
		has = e1 -> n + e2 -> n
	}
} expect 0

/**
Step 4b: Execute the commands and validate instances 
*/

// run commands and manually inspect returned instances

/**
Step 4c: Formalize the requirement and impose it in a fact
*/

fact UniqueNames {
	all d : Dir, n : Name | lone (d.contains & has.n)
}

/**
Step 4d and 4e: Re-run the test cases and validate the expected outcome and Fix the requirement formalization if needed
*/

/**
Step 5: For each desirable property:
*/

/**
Step 5a: Formalize the property and specify it as an assertion
*/

// All objects are reachable from the root

assert NoPartitions {
	Object in Root.*(contains.refersTo)
}

/**
Step 5b: Write a check command to verify whether the assertion holds
*/

check NoPartitions for 3 expect 0

/**
Step 5c: If the check is invalid, inspect the counter-example:
- If it should not be allowed by the system, fix the imposed requirements
- If it should be allowed by the system, fix the desirable property
*/

// A directory cannot be contained in itself

fact NoSelfContainment {
	no iden & ^(contains.refersTo)
}

/**
Step 5d: If the check is valid, increase the scope of the analysis until sufficient confidence
*/

check NoPartitions for 6 expect 0

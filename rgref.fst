module RG

(* Placeholder monad, until we integrate with some other stuff *)
type M :: * => *

(* Stability *)
type Stable :: _ = fun ('a::*) ('P::'a => E) ('R::'a => 'a => E) =>
		   forall x y. 'P x ==> 'R x y ==> 'P y

type RelImplies :: _ = fun ('a::*) ('G::'a => 'a => E) ('R::'a => 'a => E) =>
		       forall x y. 'G x y ==> 'R x y

(* Axiom for the reference type itself *)
type rgref :: 'a::* => ('a => E) => ('a => 'a => E) => ('a => 'a => E) => *

(* Allocation *)
(*assume alloc : forall ('p::('a => E)) ('r::'a => 'a => E) ('g::'a => 'a => E). x:'a{'p x && Stable 'a 'p 'r && RelImplies 'a 'g 'r} -> M (rgref 'a 'p 'r 'g)*)
val alloc : 'a::* -> 'p::('a => E) -> 'r::('a => 'a => E) -> 'g::('a => 'a => E) -> x:'a{('p x) && Stable 'a 'p 'r && RelImplies 'a 'g 'r} -> M (rgref 'a 'p 'r 'g)

val deref : 'a::* -> 'p::('a => E) -> 'r::('a => 'a => E) -> 'g::('a => 'a => E) -> rgref 'a 'p 'r 'g -> v:'a{'p v}
(* TODO: figure out how to do this; deref l is not a value, so can't be type arg! 
val store : 'a::* -> 'p::('a => E) -> 'r::('a => 'a => E) -> 'g::('a => 'a => E) -> l:(rgref 'a 'p 'r 'g) -> e:'a{'r (deref l) e} -> M unit
*)
val modify : 'a::* -> 'p::('a => E) -> 'r::('a => 'a => E) -> 'g::('a => 'a =>
E) -> l:(rgref 'a 'p 'r 'g) -> f:(x:'a{'p x} -> v:'a{'r x v}) -> M unit

(* Example: Monotonically increasing counter *)
(* TODO: Figure out the monadic syntax support *)
(* TODO: Pick a real monad *)
type monotonic_counter = rgref int (LT 0) LTE LTE
val test : M monotonic_counter
let test = alloc<int, (LT 0), LTE, LTE> 1

val inc : monotonic_counter -> M unit
let inc r = modify r (fun x -> x + 1)

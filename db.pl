% Rimma Niyazova
% Each kid got a toy with specific feature.

kid(andrew).
kid(dudley).
kid(georgina).
kid(karen).

toy(flubsub).
toy(gribbet).
toy(jarix).
toy(wattin).

feature(bubbles).
feature(colors).
feature(eyes).
feature(fins).

solve :-
	kid(FlubsubKid), kid(GribbetKid), kid(JarixKid), kid(WattinKid),
	all_different([FlubsubKid, GribbetKid, JarixKid, WattinKid]),

	feature(FlubsubFeature), feature(GribbetFeature),
	feature(JarixFeature), feature(WattinFeature),
	all_different([FlubsubFeature, GribbetFeature, JarixFeature, WattinFeature]),
	
	Triples = [ [flubsub, FlubsubKid, FlubsubFeature],
		    [gribbet, GribbetKid, GribbetFeature],
		    [jarix, JarixKid, JarixFeature],
		    [wattin, WattinKid, WattinFeature] ],

	% 1. Dudley didn't walk out of the store with either Flubsub or Jarix,
	%    and his alien doesn't dvelop fins when placed in water.
	\+ member([flubsub, dudley, _], Triples),
	\+ member([jarix, dudley, _], Triples),	  	
	\+ member([_, dudley, fins], Triples),

	% 2. Jarix (which isn't the name of the alien Andrew picked) has eyes that glow in the dark.
	\+ member([jarix, andrew, _], Triples),
	member([jarix, _, eyes], Triples),

	% 3. Karen left the toy store with the alien Wattin.
	member([wattin, karen, _], Triples),

	% 4. Andrew doesn't own the alien that develops fins and 
	%    Dudley doesn't own the alien that blows bubles. 
	\+ member([_, andrew, fins], Triples),
	\+ member([_, dudley, bubbles], Triples),

	tell(flubsub, FlubsubKid, FlubsubFeature),
	tell(gribbet, GribbetKid, GribbetFeature),
	tell(jarix, JarixKid, JarixFeature),
	tell(wattin, WattinKid, WattinFeature).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).


tell(X, Y, Z) :-
    write(Y), write(' got the '), write(X),
    write(' which has feature - '), write(Z), write('.'), nl.
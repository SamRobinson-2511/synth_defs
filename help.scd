//Static v. Dynamic

//Static with rrand
(
SynthDef(\help_notRand, { |out|
	Out.ar(out,
		SinOsc.ar(rrand(400, 800), 0, 0.2) * Line.kr(1, 0, 1, doneAction: Done.freeSelf)
	)
}).add;
)

a = Synth(\help_notRand);
b = Synth(\help_notRand);

//Dynamic with Rand
(
SynthDef(\help_isRand, { |out|
	Out.ar(out,
		SinOsc.ar(Rand(400, 800), 0, 0.2) * Line.kr(1, 0, 1, doneAction:Done.freeSelf);
	)
}).add;
)
a = Synth(\help_isRand);
b = Synth(\help_isRand);


//Wrap a function within an enclosing SynthDef
//very useful for mass-producing SynthDefs that have a common shell
//
(
d = SynthDef(\demoWrapping, { |out|
	Out.ar(out, SynthDef.wrap({ |freq| SinOsc.ar(freq)}))
});
)
d.allControlNames;

//Examples
//Basic

(
SynthDef(\SimpleSine, { |freq=440, out|
	Out.ar(out, SinOsc.ar(freq, 0, 0.2))
}).add;
)

(
d = SynthDef(\SimpleSine, { |freq=440, out| Out.ar(out, SineOsc.ar(freq, 0, 0.2))
});
)
d.add;




























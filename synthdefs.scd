s.boot;


//SynthDef (https://www.youtube.com/watch?v=b7Mc50_MbBA)
(
SynthDef(\clank, {
	var snd;
	snd = SinOsc.ar(220 * [0.5, 1.0, 1.344, 3.4, 7.9] * XLine.kr(1.05, 1, 0.01));
	snd = snd * Env.perc(0.001, [0.1, 1.0, 0.1, 0.2, 0.5] * 0.2).ar;
	snd = snd.sum;
	snd = snd * (1 + (SinOsc.ar(3420) * Env.perc(0, 0.05).ar));
	snd = snd * (1 + (SinOsc.ar(221) * Env.perc(0, 0.02).ar));
	snd = snd.tanh;
	snd = snd + (Hasher.ar(Sweep.ar) * Env.perc(0.001, 0.02).ar);
	snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 3455, 0.3) * Env.perc(0.01, 0.02).delay(0.012).ar * 3.dbamp);
	snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 1255, 0.3) * Env.perc(0.01, 0.02).delay(0.03).ar * 3.dbamp);
	snd = snd + GVerb.ar(snd * -20.dbamp, 30, 0.5);
	snd = snd * Env.linen(0, 3.0, 1.0, curve: -4).ar(Done.freeSelf);
	snd = snd * -5.dbamp;
	Out.ar(\out.kr(0), snd);
}).add;
)

x = Synth(\clank);

//Hzsher: scrambled value with a hash function
{ Hasher.ar(Line.ar(0, 1, 1), 0.2)}.play;
(
{
	SinOsc.ar(
		Hasher.kr(
			MouseX.kr(0, 10).round(1),
			300,
			500
		)
	) * 0.1
}.play;
)

(
{
	SinOsc.ar(
		Hasher.kr(MouseX.kr(
			0, 10).round(1) + 0.0001,
		300,
		500) * 0.1
	)
}.play;
)

(
{
	SinOsc.ar(
		Hasher.kr(MouseX.kr(
			0, 10), 300, 500)
	) * 0.1
}.play;
)



//Sweep: triggered linear ramp

//using sweep to modulate sine frequency
(
{
	var trig;
	trig = Impulse.kr(MouseX.kr(0.5, 20, 1));
	SinOsc.ar(Sweep.kr(trig, 700) + 500, 0, 0.2)
}.play;
)

//using to sweep index into a buffer
(
b = Buffer.read(s, ExampleFiles.child);

(
{
	var trig;
	trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
	BufRd.ar(1, b, Sweep.ar(trig, BufSampleRate.ir(0)))
}.play;
)
)

//backwards, vsriable offset
(
{
	var trig, pos, rate;
	trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
	rate = BufSampleRate.ir(0);
	pos = Sweep.ar(trig, rate.neg) + (BufFrames.ir(0) * LFNoise0.kr(0.2));
	BufRd.ar(1, b, pos)

}.play;
)


//raising rate
(
{
	var trig, rate;
	trig = Impulse.kr(MouseX.kr(0.5, 10, 1));
	rate = Sweep.kr(trig, 2) + 0.5;
	BufRd.ar(1, b, Sweep.ar(trig, BufSampleRate.ir(0) * rate))
}.play;
)
b.free;

(
SynthDef(\lineReset, {
	|out, start=0, end=1, dur=1, t_trig=1, run=1|
	var phasor = Sweep.ar(t_trig, run / dur).linlin(0, 1, start, end, \minmax);
	phasor.poll;
	Out.ar(out, SinOsc.ar(phasor, 0, 0.2))
}).add;
)

a = Synth(\lineReset, [\start, 400, \end, 800, \dur, 2]);

a.set(\t_trig, 1);
a.set(\run, 0);
a.set(\run, 1);
a.set(\t_trig, 1);

//shorter durations and downwards
a = Synth(\lineReset, [\start, 1000, \end, 500, \dur, 0.5]);
a.set(\t_trig, 1);
a.set(\run, 0);
a.set(\run, 1);
a.set(\t_trig, 1);
a.free;
















































































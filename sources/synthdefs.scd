s.boot;

(
SynthDef(\clank, {
	var snd;
	snd = SinOsc.ar(1220 * [0.5, 1.0, 1.344, 3.4, 7.9] * XLine.kr(1.05, 1, 0.01));
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
-- Synth Definitions
local Snippets = {}

Snippets.synthdef = [[SynthDef(${1:\\name}, {|out=0, amp=0.5| 
	var sig = ${2:Silent.ar()};
	Out.ar(out, sig * amp)
}).add;
]];


return Snippets

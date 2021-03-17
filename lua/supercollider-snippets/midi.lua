-- Midi
local M = {}

M.mididefNoteon = [[MIDIdef.noteOn(${1:\\name}, {
	arg val, num, chan, src; 
	${2:num.postln}
}, chan: ${3:0})${4:.fix};]];

M.mididefNoteoff = [[MIDIdef.noteOff(${1:\\name}, {
	arg val, num, chan, src; 
	${2:num.postln}
}, chan: ${3:0})${4:.fix};]];

M.mididefcc = [[MIDIdef.cc(${1:\\name}, {
	arg val, num, chan, src; 
	${2:val.postln}
},ccNum: ${3:64}, chan: ${4:0})${5:.fix};]];

return M


local utils = require'supercollider-snippets.utilities'
local P = {}

-- P.pdef = "Pdef('${1=os.date('%H_%M_%S')}', {\n\tPbind(*[\n\t\tinstrument: ${2:'default'},\n\t\tdur: ${3:1},\n\t\t$0\n\t]\n)})${4:.play(quant:0)}";
P.pdef = {
    "Pdef('",
    { order=1, id="name", default=function()return os.date('%H_%M_%S')end, is_input=true },
    "', {\n\tPbind(*[\n\t\tinstrument: '",
    { order=2, id="instrument", default="default", is_input=true },
    "',\n\t\tdur: ",
    { order=3, id="dur", default="1/4", is_input=true },
    ",\n\t\t",
    { order=0, id=0 },
    "\n\t]\n)})",
    { order=4, id="method", default=".play(quant:0)", is_input=true },
}

P.pdef_default = [[
(
Pdef('default', 
Pbind(
\instrument, 'default',
\scale, Scale.yu,
\degree, Pseq([12, 5, 5, 5, 7, 7, 8, 7, 2, 11, 9, 11, 9, 7, 11, 12, 2, 2, 4, 5, 12, 12], inf),
\legato, Pxrand([3/6, 12/8, 13/7, 5/7, 14/11, 16/9], inf)*3,
\octave, Pseq([4, 5, 3, 4, 5, 3, 3, 4], inf),
\dur, Pseq([2/9, 12/9, 2/11, 2/4, 13/11, 16/11, 14/16, 6/6, Pwhite(10/14, 9/1, 1)*Rest()], inf)*0.7,
\fdb, Pseq([7, 2, 5, 8, 8, 8, 10, 2, 8, 17], inf)/5,
// \hr1, Pseq([41, 21, 1, 43, 1, 17, 3, 6, 33, 32, 34, 6, 43, 10], inf)/10,
// \hr2, Pseq([8, 5, 5, 21, 9, 13, 24, 23, 17], inf)/10,
\hr3, Pseq([20, 4, 54, 13, 45, 51, 17, 6], inf)/10,
\hr4, Pseq([47, 43, 39, 8, 16, 25, 13, 21, 52, 53], inf),
\mi2, Pseq([4, 1, 8, 8], inf)/7,
\mi3, Pseq([14, 5, 20, 1, 19, 2, 6, 12, 15], inf),
\mi4, Pseq([2, 0, 2, 2, 4, 1, 3, 2, 1, 0, 0, 1, 0, 0, 1, 2, 0, 2], inf),
\en1, Prand([0.5199, 0.2245, 0.5476, 0.6101], inf),
\en2, Prand([0.29510863, 0.272272634, 0.408743794, 0.64299864, 0.4472544, 0.5882, 0.151, 0.739536], inf),
\en3, Pseq([0.28069080, 0.42912, 0.49588085, 0.661], inf),
\en4, Pseq([0.3731341829, 0.17, 0.9], inf),
// \cu1, 1,
// \cu2, 1,
// \cu3, 1,
// \cu4, 1,
// \det, 400.9
)
).play
)
]];

-- P.pseq = [[Pseq(${1|utils.rand(S.v, "array")}, ${2:inf})]];
-- p.prand = [[Prand(${1|utils.rand(S.v, "array")}, ${2:inf})]];
-- P.pxrand = [[Pxrand(${1|utils.rand(S.v, "array")}, ${2:inf})]];

-- P.rand_rest =[[Pwhite(${1|utils.rand(S.v)}, ${2:1})*Rest()]];

-- function P.pseq()
--     local t = {}
--     t.insert = "Pseq("
--     utils.append_table(t, utils.rand(U.snippet_sys_utils.v, "array"))
--     return t
-- end


function P.pseq(len, type, offset)
    offset = offset or 0
    local t = utils.rand_var_list(len, "[", 1, type, offset)
    utils.wrap_in_pat(t, "Pseq")
    return t
end

function P.prand(len, type, offset)
    offset = offset or 0
    local t = utils.rand_var_list(len, "[", 1, type, offset)
    utils.wrap_in_pat(t, "Prand")
    return t
end

function P.pshuf(len, type, offset)
    offset = offset or 0
    local t = utils.rand_var_list(len, "[", 1, type, offset)
    utils.wrap_in_pat(t, "Pshuf")
    return t
end

function P.pxrand(len, type, offset)
    offset = offset or 0
    local t = utils.rand_var_list(len, "[", 1, type, offset)
    utils.wrap_in_pat(t, "Pxrand")
    return t
end

function P.pwrand(len, type, offset)
    offset = offset or 0
    local t = utils.rand_var_list(len, "[", 1, type, offset)
    local probabilities = utils.rand_var_list(len, "[", len+1+offset)
    utils.insert_comma(t)
    utils.append_table(t, probabilities)
    table.insert(t, ".normalizeSum")

    utils.wrap_in_pat(t, "Pwrand")
    return t
end

function P.pseg(len, type, offset)
    offset = offset or 0
    len = len+offset
    local t = P.pseq(len, type)
    local times = P.pseq(len-1, 'i', len+1)
    utils.insert_comma(t)
    utils.append_table(t, times)
    utils.insert_comma(t)
    local curve = utils.var(len + len + 2, "\\lin", true)
    table.insert(t, curve)
    utils.wrap_in_pat(t, "Pseg")
    return t
end

P.swing_routine = [[
~swingify = Prout({ |ev|
var now, nextTime = 0, thisShouldSwing, nextShouldSwing = false, adjust;
while { ev.notNil } {
// current time is what was "next" last time
now = nextTime;
nextTime = now + ev.delta;
thisShouldSwing = nextShouldSwing;
nextShouldSwing = ((nextTime absdif: nextTime.round(ev[\swingBase])) <= (ev[\swingThreshold] ? 0)) and: {
(nextTime / ev[\swingBase]).round.asInteger.odd
};
adjust = ev[\swingBase] * ev[\swingAmount];
// an odd number here means we're on an off-beat
if(thisShouldSwing) {
ev[\timingOffset] = (ev[\timingOffset] ? 0) + adjust;
// if next note will not swing, this note needs to be shortened
if(nextShouldSwing.not) {
ev[\sustain] = ev.use { ~sustain.value } - adjust;
};
} {
// if next note will swing, this note needs to be lengthened
if(nextShouldSwing) {
ev[\sustain] = ev.use { ~sustain.value } + adjust;
};
};
ev = ev.yield;
};
});
]];


-- P.swing_pattern = [[
-- ($0
-- TempoClock.tempo= ${1:90} / 120;
-- Pdef('$2',
-- Ppar([
-- Pseq([
-- Pchain(
-- ~swingify,
-- Pbind(
-- \instrument, '${3:default}',
-- \out, ${4:~bus_1},
-- \dur, ${5:Pwhite(0.1)},
-- \legato, ${6:1.0},
-- \degree, ${7:Pseq((0..12), inf)},
-- \octave, ${8:Pseq([3,4,5], inf)},
-- \scale, ${9:Scale.yu},
-- \pan, Pwhite(-1)*${10:0.25},
-- \amp, ${11:Pwhite(0.6,0.7)} 
-- ),
-- (swingBase: 0.25, swingAmount: ${12:0.1})
-- ),
-- Pfuncn({ q.stop; Event.silent(0) }, 1)
-- ])
-- ])
-- ).play(quant: ${13:1/8});
-- ]];

P.swing_pattern = {
    "TempoClock.tempo = ", { order=1, id="tempo", default="90", is_input=true }, " / 120;\n",
    "Pdef('", { order=2, id="name", default="swing", is_input=true }, "',\n\tPpar([\n\t\tPseq([\n",
    "\t\t\tPchain(\n\t\t\t\t~swingify,\n\t\t\t\tPbind(\n\t\t\t\t\t\\instrument, '",
    { order=3, id="instrument", default="default", is_input=true }, "',\n",
    "\t\t\t\t\t", "\\out, ", { order=4, id="out", default="~bus_1", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\dur, ", { order=5, id="duration", default="Pwhite(0.1)", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\legato, ", { order=6, id="legato", default="1.0", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\degree, ", { order=7, id="degree", default="Pseq((0..12), inf)", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\octave, ", { order=8, id="octave", default="Pseq([3,4,5,4,5], inf)", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\scale, ", { order=9, id="scale", default="Scale.yu", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\pan, Pwhite(-1) * ", { order=10, id="random pan amount", default="1/4", is_input=true }, ",\n",
    "\t\t\t\t\t", "\\amp, ", { order=11, id="amplitude", default="Pwhite(0.6,0.7)", is_input=true }, ",\n",
    "\t\t\t\t),\n",
    "\t\t\t\t(swingBase: 0.25, swingAmount: ", { order=12, id="swing amount", default="0.1", is_input=true }, ")\n",
    "\t\t\t),\n",
    "\t\t\tPfuncn({ q.stop; Event.silent(0) }, 1)", "\n",
    "\t\t])\n\t])\n).play(quant: ", { order=13, id="quant", default="1/8", is_input=true }, ");"
};

P.lazy = {
    "Pn(Plazy {",
    "\n\t", { order=1, id="variable", default="var n = [3, 5, 7].choose;", is_input=true },
    "\n\t", { order=2, id="return", default="40 * Pseq((1..n), 1);", is_input=true },
    "}).trace(", { order=3, id="tempo", default="prefix: 'lazy_val'", is_input=true }, "),"
};

return P

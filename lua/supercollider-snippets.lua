local S = require'snippets'
local utils = require'supercollider-snippets/utilities'
local synth = require'supercollider-snippets/synth'
local maths = require'supercollider-snippets/maths'
local patterns = require'supercollider-snippets/patterns'
local node = require'supercollider-snippets/nodeproxy'
local opt = require'supercollider-snippets/options'
local midi = require'supercollider-snippets/midi'
local misc = require'supercollider-snippets/miscellaneous'
local conv = require'supercollider-snippets/convenience'
local cond = require'supercollider-snippets/conditionals'
local bus = require'supercollider-snippets/bus'

local snippets = {
    -- Snippets = {
    -- hej = utils.rando();
    -- yo = utils.rand();
    -- yo = function()utils.doer(vim.fn.input("hvor mange? "))end;

    -- p = "(\n${=vim.fn.getreg('\"')}\n)"; -- wrap register in parenthesis
    -- p_a = "(\n${=vim.fn.getreg('\"a')}\n)"; -- wrap register a in parenthesis
    p = utils.getreg();
    -- pnul = utils.getreg("\"0");
    -- p1 = utils.getreg("\"1");
    -- pa = utils.getreg("\"a");

    -- Buffers
    b = [[${1:b} = Buffer.read(${3:s}, "${2:~/SoundFiles/file.wav}".asAbsolutePath);$0]];

    -- Random sequences of numbers
    -- ["rand"] = "${1|utils.rand(S.v)}";
    -- rand_array = "${1|utils.rand(S.v, 'array')}";
    -- rand = "${1|utils.rand(utils.snippet_sys.v)}";
    -- rand_array = "${1|utils.rand(utils.snippet_sys.v, 'array')}";
    randlist = utils.rand_var_list(math.random(3,16), "[");
    randlisti = utils.rand_var_list(math.random(3,12), "[", 0, 'i');
    randlistfr = utils.rand_var_list(math.random(3,16), "[", 0, 'fr');

    -- Conditionals
    ["if"] = cond.ifs;

    -- Math
    primes = maths.primes;

    -- Midi
    noteon = midi.mididefNoteon;
    noteoff = midi.mididefNoteoff;
    cc = midi.mididefcc;

    -- Synthdefs
    sd = synth.synthdef;
    synthdef = synth.synthdef;
    tosynthdef = [[SynthDef(\yanked_${=os.date('%H_%M_%S')}, {${=vim.fn.getreg('"')}}).play;]];
    tosynthdef_a = [[SynthDef(\yanked_${=os.date('%H_%M_%S')}, {${=vim.fn.getreg('a')}}).play;]];

    -- Ndefs
    nd = node.ndef;
    ndef = node.ndef;
    input = node.ndefinput;
    tondef = [[Ndef(\yanked_${=os.date('%H_%M_%S')}, {${=vim.fn.getreg('"')}}).play;]];
    tondef_a = [[Ndef(\yanked_${=os.date('%H_%M_%S')}, {${=vim.fn.getreg('a')}}).play;]];

    -- Bus
    busfactory = bus.create_top_envir_busses;

    -- Convenience
    c = conv.p;
    crawl = conv.crawl;

    -- Routines
    routine = misc.routine;

    -- Patterns
    pdef = patterns.pdef;
    pdefault = patterns.pdef_default;

    swingroutine = patterns.swing_routine;
    swingpattern = patterns.swing_pattern;

    plazy = patterns.lazy;
    -- pseq = [[Pseq(${1|require'supercollider-snippets.utilities.rand("array")'}, ${2:inf})]];
    -- prand = [[Prand(${1|utils.rand(S.v, "array")}, ${2:inf})]];
    -- pxrand = [[Pxrand(${1|utils.rand(S.v, "array")}, ${2:inf})]];

    pseq = patterns.pseq(opt.default_sequence_length);
    pseqi = patterns.pseq(opt.default_sequence_length, 'i');
    pseqfr = patterns.pseq(opt.default_sequence_length, 'fr');
    pseqr = patterns.pseq(opt.default_sequence_length, 'r');

    prand = patterns.prand(opt.default_sequence_length);
    prandi = patterns.prand(opt.default_sequence_length, 'i');
    prandfr = patterns.prand(opt.default_sequence_length, 'fr');
    prandr = patterns.prand(opt.default_sequence_length, 'r');

    pxrand = patterns.pxrand(opt.default_sequence_length);
    pxrandi = patterns.pxrand(opt.default_sequence_length, 'i');
    pxrandfr = patterns.pxrand(opt.default_sequence_length, 'fr');
    pxrandr = patterns.pxrand(opt.default_sequence_length, 'r');

    pshuf = patterns.pshuf(opt.default_sequence_length);
    pshufi = patterns.pshuf(opt.default_sequence_length, 'i');
    pshuffr = patterns.pshuf(opt.default_sequence_length, 'fr');
    pshufr = patterns.pshuf(opt.default_sequence_length, 'r');

    pwrand = patterns.pwrand(opt.default_sequence_length);
    pwrandi = patterns.pwrand(opt.default_sequence_length, 'i');
    pwrandfr = patterns.pwrand(opt.default_sequence_length, 'fr');
    pwrandr = patterns.pwrand(opt.default_sequence_length, 'r');

    pseg = patterns.pseg(opt.default_sequence_length);
    psegi = patterns.pseg(opt.default_sequence_length, 'i');
    psegfr = patterns.pseg(opt.default_sequence_length, 'fr');
    psegr = patterns.pseg(opt.default_sequence_length, 'r');
}

return snippets
-- return Snippets

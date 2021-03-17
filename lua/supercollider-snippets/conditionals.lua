local utils = require'supercollider-snippets.utilities'
C = {}

C.ifs = utils.snippet_sys_utils.match_indentation [[
if(${1:true}, {${2:"Expressions was true".postln}}, {${3:"Expression was false".postln}});
]];

return C

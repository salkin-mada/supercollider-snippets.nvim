-- local utils = require'supercollider-snippets.utilities'
B = {}

B.create_top_envir_busses = {
    { order=1, id="how many busses?", default="5", is_input=true },
    ".do{arg i;\n",
    "\tvar num = i+1;\n",
    "\tvar key = (\"",
    { order=2, id="bus prefix name", default="bus", is_input=true }, "\"++\"",
    { order=3, id="bus name spacer", default="_", is_input=true },
    "\"++num).asSymbol;\n",
    "\tvar env = topEnvironment;\n",
    "\tenv.put(key, Bus.audio(s, ",
    { order=4, id="num channels", default="2", is_input=true }, "));\n",
    "\tNdef(key, {\n\t\tvar in = In.ar(env.at(key), ",
    { order=4, id="num channels" }, ");\n\t\t",
    { order=5, default="Limiter.ar(LeakDC.ar(in*0.95), 0.99)"},
    ";\n\t}).play(i*",{ order=4, id="num channels" },");\n}\n",
    { order=0, id=0 }
};


return B

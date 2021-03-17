C = {}

C.p = {
    "(\nC.p(",
    { order=1, id="name", default="'c'", is_input=true },
    ",\n\tbus: 0,\n\tnumChannels: 2,\n\tfolder: ",
    { order=2, id="folder", default="C.folderNum(0).postln", is_input=true },
    ",\n\tindex: 1,\n\tdur: ",
    { order=3, id="dur", default="Pwhite(0.1,1.0)", is_input=true },
    ",\n\tstretch: 1.0,",
    "\n\tpos: ",
    { order=4, id="pos", default="Psinen(0.05)", is_input=true },
    ",\n\trate: ",
    { order=5, id="rate", default="Pwhite(-1)", is_input=true },
    ",\n\ttuningOnOff: 0,",
    "\n\tdegree: 0,",
    "\n\toctave: 3,",
    "\n\troot: 0,",
    "\n\tscale: nil,",
    "\n\tcutoff: 22000.0,",
    "\n\tres: 0.01,",
    "\n\tfgain: 1.0,",
    "\n\tftype: 0,",
    "\n\tbass: 0,",
    "\n\tpan: ",
    { order=6, id="pan", default="Pwhite(-1)", is_input=true },
    ",\n\twidth: 2.0,",
    "\n\tspread: 0.5,",
    "\n\tamp: 0.5,",
    "\n\tattack: 0.01,",
    "\n\tsustain: 1.0,",
    "\n\trelease: 0.5,",
    "\n\tpst: ",
    { order=7, id="pitchshift toggle", default="0", is_input=true },
    ",\n\tpr: 1.0,",
    "\n\tfr: 1.0\n)\n);\n",
    { order=0, id=0 }
};

C.crawl = "C.crawl(${1:Platform.recordingsDir});";

return C

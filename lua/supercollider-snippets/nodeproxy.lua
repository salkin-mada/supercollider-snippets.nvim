local N = {}

-- Ndefs
N.ndef = "Ndef('${1=os.date('%H_%M_%S')}', {\n\t${2:SinOsc.ar(345)}\n})${3:.play};";
N.ndefinput = "Ndef(${1:\\name}, {|in=${2:0}|\n\tSoundIn.ar(in)})${3:.play};";

return N

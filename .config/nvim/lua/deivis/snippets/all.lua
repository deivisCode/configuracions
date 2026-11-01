local funcions = require("deivis.snippets.funcions.funcions")

-- :FACER: traducir todo
return {

s({
    trig = 'uuid',
    name = 'Universal Unique IDentifier',
    dscr = 'Generate a UUID with %Y%m%dT%H%M%S format'
}, {
    f(funcions.uuid)
}),

s({
    trig = 'time',
    name = 'Time',
    dscr = 'Insert the time in %H:%M format'
}, {
    f(funcions.time)
}),

s({
    trig = 'date',
    name = 'Date',
    dscr = 'Write the current date in %d-%m-%Y format'
}, {
    f(funcions.date)
}),

s({
    trig = 'rdate',
    name = 'ReadableDate',
    dscr = 'Write the current date in a readable %A %e, %B(%m) %Y format'
}, {
    f(funcions.rdate)
}),

}

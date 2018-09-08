Handlebars.registerHelper("slugifyPeriod", function(period) {
    return period.replace(" ","_").replace('!','');
});

Handlebars.registerHelper("consolelog", function(something) {
  console.log(something);
});

Handlebars.registerHelper("debug", function(what) {
  debugger;
});

Handlebars.registerHelper("checkedIf", function (pattern, note) {
    return (pattern.includes(note)) ? "checked" : "";
});

Handlebars.registerHelper("selectedIf", function (root, value) {
    return (root === value) ? "selected" : "";
});

Handlebars.registerHelper("gColour", function (value, index) {
    return (255 - (index*10) - value);
});

Handlebars.registerHelper("bColour", function (value, index) {
    return (value + (index*10));
});

Handlebars.registerHelper("getNoteName", function (midi) {
    notes = {55: "G", 56: "G#/Ab", 57: "A", 58: "A#/Bb", 59: "B", 60: "C", 61: "C#/Db", 62: "D", 63: "D#/Eb", 64: "E", 65: "F", 66: "F#/Gb", 67: "G", 68: "G#/Ab", 69: "A", 70: "A#/Bb", 71: "B", 72: "C", 73: "C#/Db", 74: "D", 75: "D#/Eb", 76: "E", 77: "F", 78: "F#/Gb"};
    return notes[midi];
});

Musician.destroy_all
Practise.destroy_all
Note.destroy_all
Scale.destroy_all

Note.create(name: "G3", midi_value: 55, frequency: 196.00)
Note.create(name: "G#/Ab3", midi_value: 56, frequency: 207.65)
Note.create(name: "A3", midi_value: 57, frequency: 220.00)
Note.create(name: "A#/Bb3", midi_value: 58, frequency: 233.08)
Note.create(name: "B3", midi_value: 59, frequency: 246.94)
Note.create(name: "C4", midi_value: 60, frequency: 261.63)
Note.create(name: "C#/Db4", midi_value: 61, frequency: 277.18)
Note.create(name: "D4", midi_value: 62, frequency: 293.66)
Note.create(name: "D#/Eb4", midi_value: 63, frequency: 311.13)
Note.create(name: "E4", midi_value: 64, frequency: 329.63)
Note.create(name: "F4", midi_value: 65, frequency: 349.23)
Note.create(name: "F#/Gb4", midi_value: 66, frequency: 369.99)
Note.create(name: "G4", midi_value: 67, frequency: 392.00)
Note.create(name: "G#/Ab4", midi_value: 68, frequency: 415.30)
Note.create(name: "A4", midi_value: 69, frequency: 440.00)
Note.create(name: "A#/Bb4", midi_value: 70, frequency: 466.16)
Note.create(name: "B4", midi_value: 71, frequency: 493.88)
Note.create(name: "C5", midi_value: 72, frequency: 523.25)
Note.create(name: "C#/Db5", midi_value: 73, frequency: 554.37)
Note.create(name: "D5", midi_value: 74, frequency: 587.33)
Note.create(name: "D#/Eb5", midi_value: 75, frequency: 622.25)
Note.create(name: "E5", midi_value: 76, frequency: 659.25)
Note.create(name: "F5", midi_value: 77, frequency: 698.46)
Note.create(name: "F#/Gb5", midi_value: 78, frequency: 739.99)
Note.create(name: "G5", midi_value: 79, frequency: 783.99)
Note.create(name: "G#/Ab5", midi_value: 80, frequency: 830.61)
Note.create(name: "A5", midi_value: 81, frequency: 880.00)
Note.create(name: "A#/Bb5", midi_value: 82, frequency: 932.33)
Note.create(name: "B5", midi_value: 83, frequency: 987.77)
Note.create(name: "C6", midi_value: 84, frequency: 1046.50)
Note.create(name: "C#/Db6", midi_value: 85, frequency: 1108.73)
Note.create(name: "D6", midi_value: 86, frequency: 1174.66)
Note.create(name: "D#/Eb6", midi_value: 87, frequency: 1244.51)
Note.create(name: "E6", midi_value: 88, frequency: 1318.51)
Note.create(name: "F6", midi_value: 89, frequency: 1396.91)
Note.create(name: "G#/Ab6", midi_value: 90, frequency: 1479.98)
Note.create(name: "G6", midi_value: 91, frequency: 1567.98)

major = Scale.create(name: "major (ionian)", pattern: "2212221")
dorian = Scale.create(name: "dorian", pattern: "2122212")
phrygian = Scale.create(name: "phrygian", pattern: "1222122")
lydian = Scale.create(name: "lydian", pattern: "2221221")
mixolydian = Scale.create(name: "mixolydian", pattern: "2212212")
aeolian = Scale.create(name: "aeolian", pattern: "2122122")
locrian = Scale.create(name: "locrian", pattern: "1221222")

aki = Musician.create(name: "Al Gakovic", password: "password")
beti = Musician.create(name: "Beth Schofield", password: "password")

Practise.create(musician_id: 1, scale_id: 1)
Practise.create(musician_id: 1, scale_id: 2)
Practise.create(musician_id: 2, scale_id: 1)
Practise.create(musician_id: 2, scale_id: 3)

Musician.destroy_all
Practise.destroy_all
Note.destroy_all
Scale.destroy_all

Note.create(name: "G3", midi_value: 55, frequency: 196.00, solfege: "so")
Note.create(name: "G#/Ab3", midi_value: 56, frequency: 207.65, solfege: "le-si")
Note.create(name: "A3", midi_value: 57, frequency: 220.00, solfege: "la")
Note.create(name: "A#/Bb3", midi_value: 58, frequency: 233.08, solfege: "te-li")
Note.create(name: "B3", midi_value: 59, frequency: 246.94, solfege: "ti",)
Note.create(name: "C4", midi_value: 60, frequency: 261.63, solfege: "do", reference: true)
Note.create(name: "C#/Db4", midi_value: 61, frequency: 277.18, solfege: "rah-di", reference: true)
Note.create(name: "D4", midi_value: 62, frequency: 293.66, solfege: "re", reference: true)
Note.create(name: "D#/Eb4", midi_value: 63, frequency: 311.13, solfege: "me-ri", reference: true)
Note.create(name: "E4", midi_value: 64, frequency: 329.63, solfege: "mi", reference: true)
Note.create(name: "F4", midi_value: 65, frequency: 349.23, solfege: "fa", reference: true)
Note.create(name: "F#/Gb4", midi_value: 66, frequency: 369.99, solfege: "se-fi", reference: true)
Note.create(name: "G4", midi_value: 67, frequency: 392.00, solfege: "so", reference: true)
Note.create(name: "G#/Ab4", midi_value: 68, frequency: 415.30, solfege: "le-si", reference: true)
Note.create(name: "A4", midi_value: 69, frequency: 440.00, solfege: "la", reference: true)
Note.create(name: "A#/Bb4", midi_value: 70, frequency: 466.16, solfege: "te-li", reference: true)
Note.create(name: "B4", midi_value: 71, frequency: 493.88, solfege: "ti", reference: true)
Note.create(name: "C5", midi_value: 72, frequency: 523.25, solfege: "do")
Note.create(name: "C#/Db5", midi_value: 73, frequency: 554.37, solfege: "rah-di")
Note.create(name: "D5", midi_value: 74, frequency: 587.33, solfege: "re")
Note.create(name: "D#/Eb5", midi_value: 75, frequency: 622.25, solfege: "me-ri")
Note.create(name: "E5", midi_value: 76, frequency: 659.25, solfege: "mi")
Note.create(name: "F5", midi_value: 77, frequency: 698.46, solfege: "fa")
Note.create(name: "F#/Gb5", midi_value: 78, frequency: 739.99, solfege: "se-fi")
Note.create(name: "G5", midi_value: 79, frequency: 783.99, solfege: "so")
Note.create(name: "G#/Ab5", midi_value: 80, frequency: 830.61, solfege: "le-si")
Note.create(name: "A5", midi_value: 81, frequency: 880.00, solfege: "la")
Note.create(name: "A#/Bb5", midi_value: 82, frequency: 932.33, solfege: "te-li")
Note.create(name: "B5", midi_value: 83, frequency: 987.77, solfege: "ti",)
Note.create(name: "C6", midi_value: 84, frequency: 1046.50, solfege: "do")
Note.create(name: "C#/Db6", midi_value: 85, frequency: 1108.73, solfege: "rah-di")
Note.create(name: "D6", midi_value: 86, frequency: 1174.66, solfege: "re")
Note.create(name: "D#/Eb6", midi_value: 87, frequency: 1244.51, solfege: "me-ri")
Note.create(name: "E6", midi_value: 88, frequency: 1318.51, solfege: "mi")
Note.create(name: "F6", midi_value: 89, frequency: 1396.91, solfege: "fa")
Note.create(name: "G#/Ab6", midi_value: 90, frequency: 1479.98, solfege: "se-fi")
Note.create(name: "G6", midi_value: 91, frequency: 1567.98, solfege: "so")


admin = Musician.create(name: "Admin", email: "thegingertonicstudios@gmail.com", password: "administration", admin: true) #user 1
aki = Musician.create(name: "Al Gakovic", email: "al@gak.com", password: "password") #user 2
beti = Musician.create(name: "Beth Schofield", email: "gingertonic@test.com", password: "password") #user 3

Scale.create(name: "ionian", aka: "major", scale_type: "mode (major scale)", pattern: "221222", private: false, created_by: 1)
Scale.create(name: "dorian", scale_type: "mode (major scale)", pattern: "212221", private: false, created_by: 1)
Scale.create(name: "phrygian", scale_type: "mode (major scale)", pattern: "122212", private: false, created_by: 1)
Scale.create(name: "lydian", scale_type: "mode (major scale)", pattern: "222122", private: false, created_by: 1)
Scale.create(name: "mixolydian", scale_type: "mode (major scale)", pattern: "221221", private: false, created_by: 1)
Scale.create(name: "aeolian", aka: "natural minor", scale_type: "mode (major scale)", pattern: "212212", private: false, created_by: 1)
Scale.create(name: "locrian", scale_type: "mode (major scale)", pattern: "122122", private: false, created_by: 1)

# Scale.create(name: "jazz minor", scale_type: "mode (jazz minor scale)", pattern: "2122221", private: false, created_by: 1)
Scale.create(name: "phrygian #6", scale_type: "mode (jazz minor scale)", pattern: "122221", private: false, created_by: 1)
Scale.create(name: "lydian augmented", scale_type: "mode (jazz minor scale)", pattern: "222212", private: false, created_by: 1)
Scale.create(name: "overtone", scale_type: "mode (jazz minor scale)", pattern: "222121", private: false, created_by: 1)
Scale.create(name: "mixolydian b6", scale_type: "mode (jazz minor scale)", pattern: "221212", private: false, created_by: 1)
Scale.create(name: "locrian #2", scale_type: "mode (jazz minor scale)", pattern: "212122", private: false, created_by: 1)
Scale.create(name: "altered", scale_type: "mode (jazz minor scale)", pattern: "121222", private: false, created_by: 1)

Scale.create(name: "major pentatonic", scale_type: "pentatonic", pattern: "2232", private: false, created_by: 1)
Scale.create(name: "minor pentatonic", scale_type: "pentatonic", pattern: "3223", private: false, created_by: 1)

Scale.create(name: "chromatic", scale_type: "essentials", pattern: "11111111111", private: false, created_by: 1)
Scale.create(name: "whole-tone", scale_type: "essentials", pattern: "22222", private: false, created_by: 1)

Scale.create(name: "dominant diminished", scale_type: "octatonic", pattern: "1212121", private: false, created_by: 1)
Scale.create(name: "diminished", scale_type: "octatonic", pattern: "2121212", private: false, created_by: 1)

Scale.create(name: "augmented", scale_type: "essentials", pattern: "13131", private: false, created_by: 1)

Scale.create(name: "harmonic minor", scale_type: "essentials", pattern: "212213", private: false, created_by: 1)
Scale.create(name: "melodic minor asc", aka: "jazz minor", scale_type: "essentials", pattern: "212222", melody_rules: "When descending, use natural minor", private: false, created_by: 1)

Scale.create(name: "oriental minor", aka: "Hungarian minor, Hungarian gypsy scale, Arabic minor", scale_type: "other", pattern: "213113", private: false, created_by: 1)



Practise.create(musician_id: 2, scale_id: 1, experience: 3)
Practise.create(musician_id: 2, scale_id: 2, experience: 4)
Practise.create(musician_id: 2, scale_id: 3, experience: 30)
Practise.create(musician_id: 2, scale_id: 4, experience: 4)
Practise.create(musician_id: 2, scale_id: 5, experience: 4)
Practise.create(musician_id: 2, scale_id: 6, experience: 10)
Practise.create(musician_id: 3, scale_id: 1, experience: 1)
Practise.create(musician_id: 3, scale_id: 3, experience: 4)
Practise.create(musician_id: 3, scale_id: 3, experience: 10)
Practise.create(musician_id: 3, scale_id: 3, experience: 3)

p2 = Practise.find(2)
p2.updated_at = Time.now - 2.weeks
p2.save
p3 = Practise.find(3)
p3.updated_at = Time.now - 7.weeks
p3.save
p4 = Practise.find(4)
p4.updated_at = Time.now - 1.day
p4.save
p5 = Practise.find(5)
p5.updated_at = Time.now - 2.months
p5.save
p6 = Practise.find(6)
p6.updated_at = Time.now - 2.weeks
p6.save
p7 = Practise.find(7)
p7.updated_at = Time.now - 3.days
p7.save
p8 = Practise.find(8)
p8.updated_at = Time.now - 3.days
p8.save
p9 = Practise.find(9)
p9.updated_at = Time.now - 3.days
p9.save

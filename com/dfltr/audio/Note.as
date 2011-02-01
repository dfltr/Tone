package com.dfltr.audio {
    public class Note {
        public var duration:Number;
        private var tone:Tone;

        public function Note(note:String) {
            var freq:Number = this.noteToFreq(note);

            //trace('Frequency should be: ' + freq);

            tone = new Tone(freq);
        }

        private function noteToFreq(note:String):Number {
            //D3:4 - D in octave 3 : duration quarter note
            //octaves: A0 to C8
            //durations: 1, 2, 4, 8, 16, 32, 64

            var reg:RegExp = /^([a-z][#|b]?)([0-8]):(\d+)$/i; //'fix highlighting

            var res:Object = reg.exec(note);

            if(res === null) {
                throw new Error('Could not parse note format for: ' + note);
            }

            //trace(res);

            this.duration = 64 / res[3];

            function delta(note2:String, octave2:Number):Number {
                var note1:String = 'A';
                var octave1:Number = 4;
                var delta:Number = 0;

                var scales:Object = {
                    sharps: ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"],
                    flats: ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"]
                };

                //find the number of octaves between the two
                var d0:Number = (octave2 - octave1) * 12;


                //find the number of steps between the two
                var scale:String = note2.indexOf("#") > -1 ? 'sharps' : 'flats';
                var dS:Number = scales[scale].indexOf(note2) - scales[scale].indexOf(note1);

                //trace('note2 is: ' + dS);


                //up: delta = deltaOctaves + deltaSteps
                //down: delta = deltaOctaves - deltaSteps
                if(d0 > -1) {
                    delta = d0 + dS;
                } else {
                    delta = d0 - dS;
                }

                //trace('delta is: ' + delta);

                //E5 -> G6
                //dO = 1 * 12 = 12
                //dS = 4 - 7 = -3
                //d = 12 - -3 = 15 (should be 15)

                //A4 -> E2
                //dO = -2 * 12 = -24
                //dS = 9 - 4 = 5
                //d = -24 + 5 = -19 (should be -29)

                //A4 -> B5
                //d0 = 1 * 12 = 12
                //dS = 9 - 11 = -2
                //d = 12 - -2 = 14 (should be 14)

                return delta
            }

            var d:Number = delta(res[1], res[2]);

            return Math.round((440 * Math.pow(1.059463094359, d)) * 1000) / 1000;
        }

        public function play():void {
            this.tone.play();
        }

        public function stop():void {
            this.tone.stop();
        }
    }
}
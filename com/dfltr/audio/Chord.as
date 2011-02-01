package com.dfltr.audio {
    public class Chord {
        private var tones:Array = new Array();

        public function Chord(notes:Array) {
            for(var i:Number = 0; i < notes.length; i++) {
                this.tones[i] = new Tone(notes[i]);
            }
        }

        public function play():void {
            for(var i in this.tones) {
                tones[i].play();
            }
        }

        public function stop():void {
            for(var i in this.tones) {
                tones[i].stop();
            }
        }
    }
}
package com.dfltr.audio {
    public class Phrase {
        import flash.utils.Timer;
        import flash.events.TimerEvent;

        private var tones:Array = new Array();

        private var timer:Timer = new Timer(2000, 1);

        public function Phrase() {
            var a4Maj:Chord = new Chord(new Array(440, 587.330, 739.989));
            var d4Min:Chord = new Chord(new Array(293.665, 349.228, 440));

            this.timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
                d4Min.play();
                a4Maj.stop();
            });

            a4Maj.play();
            this.timer.start()
        }
    }
}
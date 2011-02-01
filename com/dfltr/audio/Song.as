package com.dfltr.audio {
    public class Song {
        import flash.events.EventDispatcher;
        import flash.events.Event;
        import flash.utils.Timer;
        import flash.events.TimerEvent;

        private var bpm:Number = 120;
        private var granularity:Number = 64;
        private var timer:Timer;
        private var ticker = new SongTickDispatcher();

        public function Song() {
            var tickInterval:Number = this.bpmToTickInterval();

            //trace(tickInterval);

            this.timer = new Timer(tickInterval);
            var tickNumber:Number = 1;

            timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void {
                ticker.tick();

                //var d2:Number = new Date().getTime();
                //trace('Step took: ' + String(d2 - lastTime));
                //lastTime = d2;
            });

            timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
                //var d2:Number = new Date().getTime();
                //trace('It took: ' + String(d2 - d1));
            });

            this.ticker.addEventListener(SongTickDispatcher.SONG_TICK, function(e:Event):void {
                //trace(ticker.count);
            });

            timer.start();
            //var d1:Number = new Date().getTime();
            //var lastTime:Number = d1;

            this.ticker.addEventListener(SongTickDispatcher.NOTE_END, function(e:Event):void {
                //trace('A NOTE ENDED');
            });
        }

        public function play():void {
            this.timer.start();
        }

        //One "tick" is the time between the beginning of a 64th note and the beginning of the next one
        private function bpmToTickInterval():Number {
            //signature = 4/4
            //whole notes per minute = bpm / 4
            //wps = wpm / 60
            //seconds per whole note = 1 / wps
            //seconds per 64th = spw / 64
            //milliseconds per 64th note = 64ps * 1000

            return ((1 / ((this.bpm / 4) / 60)) / this.granularity) * 1000;
        }

        public function note(note:String):void {
            var n:Note = new Note(note);
            var startTicks:Number = this.ticker.count;

            //trace('DURATION SHOULD BE: ' + String(n.duration));

            n.play();

            var noteTick:Function = function(e:Event):void {
                //trace('duration: ' + String(ticker.count - startTicks));
                if(ticker.count - startTicks >= n.duration) {
                    n.stop();
                    ticker.removeEventListener(SongTickDispatcher.SONG_TICK, noteTick);

                    ticker.dispatchEvent(new Event(SongTickDispatcher.NOTE_END));
                }
            }

            ticker.addEventListener(SongTickDispatcher.SONG_TICK, noteTick);
        }

        public function phrase(notes:Array):void {
            var currentNote:Number = 0;

            var nextNote:Function = function(e:Event):void {
                currentNote++;

                if(notes[currentNote]) {
                    note(notes[currentNote]);
                } else {
                    ticker.removeEventListener(SongTickDispatcher.SONG_TICK, nextNote);
                }
            }

            ticker.addEventListener(SongTickDispatcher.NOTE_END, nextNote);

            note(notes[currentNote]);
        }
    }
}
package com.dfltr.audio {
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class SongTickDispatcher extends EventDispatcher {
        public static const SONG_TICK:String = "songTick";
        public static const NOTE_END:String = "noteEnd";
        public var count:Number = 0;

        public function tick():void {
            this.count++;
            dispatchEvent(new Event(SongTickDispatcher.SONG_TICK));
        }
    }
}
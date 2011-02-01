package com.dfltr.audio {
    import flash.events.Event;

    public class SongTickEvent extends Event {

        public static const TICK:String = "songTick";
        public var tickCount:Number = 0;

        public function SongTickEvent(count:Number) {
            super(TICK, true, false);
            this.tickCount = count;
        }
    }
}
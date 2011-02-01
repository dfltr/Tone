package com.dfltr.audio {
    public class Tone {
        import flash.events.SampleDataEvent;
        import flash.media.Sound;
        import flash.media.SoundChannel;

        private var sound:Sound = new Sound();
        private var channel:SoundChannel = new SoundChannel();

        public function Tone(freq:Number = 440) {
            function sineWaveGenerator(event:SampleDataEvent):void {
                for (var c:int = 0; c < 8192; c++) {
                    var sample:Number = Math.sin( Number(c+event.position) * (freq * 2 * Math.PI) / 44100) * 0.25;
                    event.data.writeFloat(sample);
                    event.data.writeFloat(sample);
                }
            }
            this.sound.addEventListener(SampleDataEvent.SAMPLE_DATA,sineWaveGenerator);
        }

        public function play():void {
            this.channel = this.sound.play();
        }

        public function stop():void {
            this.channel.stop();
        }
    }
}
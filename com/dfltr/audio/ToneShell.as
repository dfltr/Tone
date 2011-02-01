package com.dfltr.audio {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    public class ToneShell extends flash.display.MovieClip {
        public function ToneShell() {
            import com.dfltr.audio.*

            //var a4:Tone = new Tone();
            //var d5:Tone = new Tone(587.330);

            //var a4Maj = new Chord(new Array(440, 587.330, 739.989, 880));

            //a4Maj.play();

            //var ph:Phrase = new Phrase();

            //var note1:Note = new Note("A3:4");
            //var note2:Note = new Note("D4:4");
            //var note3:Note = new Note("F#4:4");

            var s:Song;

            this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
                s = new Song();

                //s.note("F#4:32");

                s.phrase([
                    'A3:4', 'D4:8', 'F4:8',
                    'D4:8', 'F4:8', 'A4:8',
                    'F4:8', 'A4:8', 'D5:8',
                    'A4:8', 'D5:8', 'F5:8',
                    'D5:8', 'F5:8', 'A5:8',
                    'A5:8', 'F5:8', 'D5:8',
                    'F5:8', 'D5:8', 'A4:8',
                    'D5:8', 'A4:8', 'F4:8',
                    'A4:8', 'F4:8', 'D4:8',
                    'F4:8', 'D4:8', 'A3:4'
                ]);

                s.play();
            });

            var outputText:TextField = new TextField();
            outputText.text = getPropertiesString();
            outputText.width = stage.stageWidth;
            outputText.height = outputText.textHeight;
            addChild(outputText);
        }

        private function getPropertiesString():String {
            var str:String = ""
                + "currentFrame: " + currentFrame + "\n"
                + "currentLabel: " + currentLabel + "\n"
                + "currentScene: " + currentScene + "\n"
                + "framesLoaded: " + framesLoaded + "\n"
                + "totalFrames: " + totalFrames + "\n"
                + "trackAsMenu: " + trackAsMenu + "\n";
            return str;
        }
    }
}
package {
import demo.Application;

[SWF (frameRate=60, width=600, height=800, backgroundColor=0)]
public class Main extends StarlingMainBase {

    public function Main() {
        super(Application);
    }

    override protected function initialize():void {
        super.initialize();

        setSize(600, 800);
        showStats = true;
    }
}
}

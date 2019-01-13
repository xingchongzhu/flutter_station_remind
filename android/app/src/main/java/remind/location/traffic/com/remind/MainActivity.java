package remind.location.traffic.com.remind;

import android.os.Build;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.WebviewPlugin;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
      //FlutterWebviewPlugin.registerWith(this,this.registrarFor(FlutterWebviewPlugin.CHANNEL));
      WebviewPlugin.registerWith(this.registrarFor(WebviewPlugin.CHANNEL));
      getFlutterView().addFirstFrameListener(new FlutterView.FirstFrameListener() {
      @Override
      public void onFirstFrame() {
        // Report fully drawn time for Play Store Console.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
          MainActivity.this.reportFullyDrawn();
        }
        MainActivity.this.getFlutterView().removeFirstFrameListener(this);
      }
    });
  }
}

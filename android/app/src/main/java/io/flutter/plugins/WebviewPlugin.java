package io.flutter.plugins;


import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.Point;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.ViewGroup;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * WebviewPlugin
 */
public class WebviewPlugin implements MethodChannel.MethodCallHandler {
    private final static String TAG = "WebviewPlugin";
    public final static String CHANNEL = "webview_plugin";
    private Activity activity;
    private WebView webView;
    private MethodChannel.Result result;

    /**
     * Plugin registration.
     */
    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL);
        channel.setMethodCallHandler(new WebviewPlugin(registrar.activity()));
    }

    @TargetApi(Build.VERSION_CODES.ECLAIR_MR1)
    public WebviewPlugin(Activity activity) {
        this.activity = activity;
        webView = new WebView(activity);
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setLoadWithOverviewMode(true);
        webView.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
        webView.getSettings().setLoadsImagesAutomatically(true);// 加载网页中的图片
        webView.getSettings().setUseWideViewPort(true); //设置使用视图的宽端口
        webView.getSettings().setAllowFileAccess(true);// 可以读取文件缓存(manifest生效)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            webView.getSettings().setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }

    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        this.result = result;
        switch (methodCall.method) {
            case "load":
                FrameLayout.LayoutParams params = buildLayoutParams(methodCall);
                LinearLayout linearLayout = new LinearLayout(activity);
                linearLayout.setOrientation(LinearLayout.VERTICAL);
                linearLayout.addView(webView);
                activity.addContentView(linearLayout, params);
                /*String cityName = "shenzhen.json";
                Log.d(TAG,"initData "+" cityName = "+cityName);
                String url = "file:///android_asset/src/index.html?cityCode="+cityName;
                webView.loadUrl(url);*/
                String url = methodCall.argument("url").toString();
                webView.loadUrl("file:///android_asset/src/index.html?cityCode=beijing.json");
                break;
        }
    }

    public class MyWebviewClient extends WebViewClient {
        Activity activity;
        private final WebClientLoadListener loadListener;
        private boolean isError;

        public MyWebviewClient(Activity activity, WebClientLoadListener loadListener) {
            this.activity = activity;
            this.loadListener = loadListener;
        }

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
            return super.shouldOverrideUrlLoading(view, request);
        }

        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {
            super.onPageStarted(view, url, favicon);
            isError = false;
        }

        @Override
        public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
            super.onReceivedError(view, request, error);
            isError = true;
        }
    }

    public interface WebClientLoadListener {
        void loadFinished(String title, boolean isError);
    }

    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
    private FrameLayout.LayoutParams buildLayoutParams(MethodCall call) {
        Map<String, Number> rc = call.argument("rect");
        FrameLayout.LayoutParams params;
        if (rc != null) {
            params = new FrameLayout.LayoutParams(
                    dp2px(activity, rc.get("width").intValue()), dp2px(activity, rc.get("height").intValue()));
            params.setMargins(dp2px(activity, rc.get("left").intValue()), dp2px(activity, rc.get("top").intValue()),
                    0, 0);
        } else {
            Display display = activity.getWindowManager().getDefaultDisplay();
            Point size = new Point();
            display.getSize(size);
            int width = size.x;
            int height = size.y;
            params = new FrameLayout.LayoutParams(width, height);
        }
        return params;
    }

    private int dp2px(Context context, float dp) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dp * scale + 0.5f);
    }
}